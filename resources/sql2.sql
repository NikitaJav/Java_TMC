create schema library;

set search_path = library;

create table book
(
    id         serial primary key,
    name       varchar(64),
    count_page integer,
    genre      varchar(64)
);

create table author
(
    id          serial primary key,
    full_name   varchar(64),
    birth_date  date,
    nationality varchar(64)
);

create table author_books
(
    id        serial primary key,
    author_id integer references author (id),
    book_id   integer references book (id)
);

insert into book (name, count_page, genre)
values ('Book1', 190, 'Drama'),
       ('Book2', 90, 'Comedy'),
       ('Book3', 112, 'Roman'),
       ('Book4', 142, 'Roman'),
       ('Book5', 399, 'Drama'),
       ('Book6', 191, 'Comedy'),
       ('Book7', 122, 'Horor'),
       ('Book8', 190, 'Horor    '),
       ('Book9', 231, 'Drama'),
       ('Book10', 423, 'Comedy');

insert into author (full_name, birth_date, nationality)
values ('Author1', '1888-01-01', 'Russian'),
       ('Author2', '2000-03-02', 'Belarus'),
       ('Author3', '1923-04-05', 'Pole'),
       ('Author4', '1899-12-12', 'Russian'),
       ('Author5', '1941-11-11', 'Belarus');

insert into author_books (author_id, book_id)
values ((select id from author where full_name = 'Author1'), (select id from book where name = 'Book1')),
       ((select id from author where full_name = 'Author2'), (select id from book where name = 'Book1')),
       ((select id from author where full_name = 'Author3'), (select id from book where name = 'Book2')),
       ((select id from author where full_name = 'Author4'), (select id from book where name = 'Book3')),
       ((select id from author where full_name = 'Author5'), (select id from book where name = 'Book4'));

select a.full_name as book_author, b.name as book_name
from author_books ab
         join author a on ab.author_id = a.id
         join book b on ab.book_id = b.id;

select b.name
from author_books ab
         join author a on ab.author_id = a.id
         join book b on ab.book_id = b.id
where a.nationality = 'Russian';

select b.name
from author_books ab
         join author a on ab.author_id = a.id
         join book b on ab.book_id = b.id
where extract(year from a.birth_date) > 1900;

delete
from book
where name = 'Book1';

select a.full_name, a.nationality, a.birth_date, avg(b.count_page)
from author_books ab
         join author a on ab.author_id = a.id
         join book b on ab.book_id = b.id
group by a.full_name, a.nationality, a.birth_date
order by a.birth_date;

select a.full_name, a.nationality, avg(b.count_page)
from author_books ab
         join author a on ab.author_id = a.id
         join book b on ab.book_id = b.id
group by a.full_name, a.nationality
having avg(count_page) > 140;

select a.full_name, avg(b.count_page)
from author_books ab
         join author a on ab.author_id = a.id
         join book b on ab.book_id = b.id
group by a.full_name
having (select avg(b.count_page)
        from author_books ab
                 join author a on ab.author_id = a.id
                 join book b on ab.book_id = b.id) < avg(b.count_page);
