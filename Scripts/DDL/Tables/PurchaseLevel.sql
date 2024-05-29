use estore;

drop table if exists PurchaseLevel;

create table PurchaseLevel
(
    PurchaseLevelID     tinyint         not null    auto_increment,
    Name                varchar(10)     not null,

    constraint PK_PurchaseLevel primary key (PurchaseLevelID)
);