drop table tables;
create table tables( 
        year char(4)  not null, 
        name char(40)  not null,
        primary key (year, name ));

create table variable( 
        year char(4) not null,
        tables char(60) not null,
        name char(60) not null,
        pos integer,
        var_fmt char(60),
        label char(255),
        minval char(60),
        maxval char(60),
        xkey char(60),
        derived char(60),
        per_var char(60),
        benefit char(60),
        question char(60),
        type char(60),
        block char(60),
        varseq char(60),
        xusage char(60),
        set_type char(60), 
        primary key( year, tables, name ),
        foreign key( year, tables ) references tables on delete cascade );

create table enum( 
        year char(4) not null,
        tables char(60) not null,
        variable char(60) not null,
        frsvalue char(60) not null,
        fmtvalue char(60),
        primary key( year, tables, variable, frsvalue ),
        foreign key( year, tables, variable ) references variable  on delete cascade );

create view type_var_combos as (
        select distinct name,type,tables 
        from variable 
        group by name,type,tables);
        
        
