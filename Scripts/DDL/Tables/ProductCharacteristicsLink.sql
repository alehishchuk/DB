use estore;

drop table if exists ProductCharacteristicsLink;

create table ProductCharacteristicsLink
(
    ProductID               smallint        not null,
    CharacteristicsID       smallint        not null,
    Value                   varchar(20)     not null,

    constraint PK_ProductCharacteristicsLink primary key (ProductID, CharacteristicsID)
);