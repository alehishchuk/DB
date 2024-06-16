use estore;

drop table if exists Order;

create table Order
(
    OrderID             smallint        not null    auto_increment,
    ClientID            smallint        not null,
    Code                char(10)        not null,
    CreatedDate         datetime        not null,
    FinalCost           smallint        not null,
    Status              tinyint         not null,
    ShelfLife           datetime        not null,
    WarehouseID         tinyint         null,
    PickUpPointID       tinyint         null,
    VAT                 tinyint         not null,

    constraint PK_Order primary key (OrderID)
);