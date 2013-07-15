drop table enums;
drop table variables;
drop table tables;
drop table waves;
drop view type_var_combos;

create table waves( wave char not null primary key ) engine=InnoDB;
insert into waves values( 'x' ); -- not done by loading code for xvars

create table tables( 
        wave char  not null, 
        name char(40)  not null,
        primary key (wave, name ),
        foreign key( wave ) references waves( wave ) on delete cascade ) engine=InnoDB;

create table variables( 
        wave char not null,
        tables char(60) not null,
        name char(60) not null,
        pos integer,
        var_fmt char(60),
        measurement_level char(60),
        label char(255) not null,
        ada_name char(255) not null,
        type integer not null,
        primary key( wave, tables, name ),
        foreign key( wave, tables ) references tables( wave, name ) on delete cascade ) engine=InnoDB;

create unique index `alt_variable_on_adaname` on variables( wave, tables, ada_name );

create table enums( 
        wave char not null,
        tables char(60) not null,
        variable_name char(60) not null,
        value char(60) not null,
        label char(60)  not null,
        enum_value char(60) not null,
        primary key( wave, tables, variable_name, value ),
        foreign key( wave, tables, variable_name ) references variables( wave, tables, name )  on delete cascade ) engine=InnoDB;

create view type_var_combos as (
        select distinct name,type,tables 
        from variables 
        group by name,type,tables );
        
-- when loaded

create view enum_candidates as select tables,variable_name, max( value ) from enums group by tables,variable_name having max( value ) > 0;
update variables set type=98 where name in (select variable_name from enum_candidates);

create view final_types as select distinct tables,name,max(type) as mtype from variables group by tables,name;

create index `ft1` on variables ( tables );
create index `ft2` on variables ( name );
create index `ft3` on variables ( tables, name );
create index `ft4` on variables ( ada_name );
create index `ft5` on variables ( wave );
-- can't remember of mysql creates proper index for pk anyway..
create index `ft6` on variables ( wave, tables, name );


create index `et1` on enums ( tables );
create index `et2` on enums ( variable_name );
create index `et3` on enums ( tables, variable_name );
create index `et4` on enums ( tables, wave );
create index `et5` on enums ( tables, wave, variable_name );

create index `et6` on enums ( wave );
create index `et7` on enums ( wave, tables, variable_name, value );

drop table  final_enum_mappings;       
create table final_enum_mappings(
        variable_name char(60) not null,
        enum_type_key char(60),
        enum_type_name char(60),
        primary key( variable_name ),
        foreign key( variable_name ) references variables( name ),
        foreign key( enum_type_key ) references variables( name )
) engine=InnoDB;

create view distinct_enums as
        select tables, variable_name,value,label, enum_value from 
                enums 
        group by 
                tables, variable_name having max( value ) > 0 
        order by 
                tables, variable_name, value;


create index `fe1` on final_enum_mappings( variable_name );
create index `fe2` on final_enum_mappings( enum_type_key );
create index `fe3` on final_enum_mappings( variable_name, enum_type_key );

-- idiot checks 
update variables set type = 1 where ( label like "%year%" or name like "%04" ) and ( type = 5 or type = 3);

update variables set type = 1 where ( label like "%SIC 92%" or label like '% SOC %' or label like '%SOC 2000%' or label like '%Citizenship%') and ( type = 5 );
update variables set type = 1 where ( label like "%(SIC92)%" or label like '%SOC:%' or label like '%(SOC)%' or label like '%SOC2000%' or label like 'International SOC:'or label like '%Citizenship%'  or label like '') and ( type = 5 );

update variables set type = 99 where ( name='pid' or name ='hid' or name='id' or name='gechphid' );

update variables set type=1 where name in ( 'opid', 'jbot', 'jbhrs', 'jbttwt', 'jbttwt', 'jbsat2', 'net1ag', 'j2hrs', 'jsttwt' ) or name like 'pcusr_' or name like 'net_ag';


update variables set type = 5 where name in ( 'Xpleclw', 'xpfood', 'xpgaslw', 'xpoily', 'cjswk9', 'xpself', 'paisco', 'fthh2w', 'jupayl', 'jbhrbg', 'jbotbg', 'jbotly', 'jsttwt', 'jbotpd', 'jbhrly', 'jshrs' ) or 
        label like '%Cambridge%' or label like '%Goldthorpe%' or label like '%annual weeks employed%' or
        name like 'fthh_v';
        
update variables set type = 99 where ( name like '_hid' and tables = 'xwaveid' ) or ( name in ('mpid', 'cosapid', 'fpid', 'rapid', 'sppid' )) ;        
        
-- final consistency forcing
update variables set type=( select mtype from final_types where final_types.name=variables.name and final_types.tables=variables.tables );

update variables set type = (
        select 
                mtype mtype 
        from 
                final_types 
        where 
                final_types.tables = variables.tables and final_types.name = variables.name );
                
                
                
