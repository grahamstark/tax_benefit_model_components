drop database raw_schema;
create database raw_schema;
use raw_schema;
create table tables( 
        dataset char(20) not null,
        year char(4)  not null, 
        name char(40)  not null,
        primary key ( dataset, year, name ));

create table variables( 
        dataset char(20) not null,
        year char(4) not null,
        tables char(60) not null,
        datatype char(60) not null,
        name char(60) not null,
        pos integer,
        label char(255),
        primary key( dataset, year, tables, name ),
        foreign key( dataset, year, tables ) references tables on delete cascade );

create table enum( 
        dataset char(20) not null,
        year char(4) not null,
        tables char(60) not null,
        variable char(60) not null,
        value char(60) not null,
        label char(60),
        primary key( dataset, year, tables, variable, value ),
        foreign key( dataset, year, tables, variable ) references variables  on delete cascade );

create view type_var_combos as (
        select distinct dataset,name,datatype,tables 
        from variables 
        group by dataset,name,datatype,tables);
