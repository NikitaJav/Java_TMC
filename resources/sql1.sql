create schema country_list;

create table country_list.country_info
(
    id         serial primary key,
    name       varchar(64),
    population integer,
    square     integer,
    language   varchar(64)
);

insert into country_list.country_info (name, population, square, language)
values ('Belarus', 10, 207, 'Belarusian'),
       ('Russia', 144, 17130, 'Russian'),
       ('Ukraine', 44, 603, 'Ukrainian'),
       ('Poland', 38, 312, 'Polish'),
       ('Lithuania', 3, 65, 'Belarusian'),
       ('Latvia', 2, 64, 'Latvian'),
       ('Germany', 83, 357, 'Deutsch'),
       ('France', 67, 543, 'French'),
       ('China', 1402, 9597, 'Chinese'),
       ('Egypt', 102, 1010, 'Arab');

select *
from country_list.country_info
order by id;

select e.name, e.population
from country_list.country_info e
where e.population > 50;

select e.name, e.square
from country_list.country_info e
order by e.square;

update country_list.country_info
set language = 'java'
where name like 'Po%';

delete
from country_list.country_info
where population = (select max(population) from country_list.country_info);
