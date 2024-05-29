use estore;

drop table if exists Basket;

create table Basket
(
    ClientID        smallint    not null,
    ProductID       smallint    not null,      
    Quantity        tinyint     not null,

    constraint PK_Basket primary key (ClientID, ProductID)
);