use estore;

drop table if exists ProductWarehouseLink;

create table ProductWarehouseLink
(
    ProductID       smallint    not null,
    WarehouseID     tinyint     not null,
    Quantity        tinyint     not null,

    constraint PK_ProductWarehouseLink primary key (ProductID, WarehouseID)
);