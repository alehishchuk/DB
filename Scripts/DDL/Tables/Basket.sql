use estore;

create table if not exists Basket
(
    ClientID        smallint    not null,
    ProductID       smallint    not null,      
    Quantity        tinyint     not null,

    constraint PK_Basket primary key (ClientID, ProductID)
);