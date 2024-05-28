use estore;

create table if not exists ProductWarehouseLink
(
    ProductID       smallint    not null,
    WarehouseID     tinyint     not null,
    Quantity        tinyint     not null,

    constraint PK_ProductWarehouseLink primary key (ProductID, WarehouseID)
);