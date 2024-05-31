use estore;

drop table if exists Characteristics;

create table Characteristics
(
    CharacteristicsID       smallint        not null    auto_increment,
    Name                    varchar(20)     not null,

    constraint PK_Characteristics primary key (CharacteristicsID)
);