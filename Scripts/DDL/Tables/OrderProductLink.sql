use estore;

drop table if exists OrderProductLink;

create table OrderProductLink
(
    OrderID             smallint    not null,
    ProductID           smallint    not null,
    ProductPrice        smallint    not null,
    ProductQuantity     tinyint     not null,
    DiscountValue       tinyint     null,

    constraint PK_OrderProductLink primary key (OrderID, ProductID)
);