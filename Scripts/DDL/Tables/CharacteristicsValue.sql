use estore;

drop table if exists CharacteristicsValue;

create table CharacteristicsValue
(
    ProductID               smallint        not null,
    CharacteristicsID       smallint        not null,
    Value                   varchar(20)     not null,

    constraint PK_CharacteristicsValue primary key (ProductID, CharacteristicsID)
);