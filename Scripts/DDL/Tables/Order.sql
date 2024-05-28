use estore;

create table if not exists Order
(
    OrderID             smallint        not null    auto_increment,
    ClientID            smallint        not null,
    Code                char(10)        not null,
    CreatedDate         datetime        not null,
    FinalCost           smallint        not null,
    Status              varchar(20)     not null,
    ShelfLife           tinyint         not null,
    WarehouseID         tinyint         null,
    PickUpPointID       tinyint         null,
    VAT                 tinyint         not null,

    constraint PK_Order primary key (OrderID)
);