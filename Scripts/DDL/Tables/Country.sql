use estore;

drop table if exists Country;

create table Country
(
    CountryID       tinyint         not null    auto_increment,
    Name            varchar(50)     not null,

    constraint PK_Country primary key (CountryID)
);