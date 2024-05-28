use estore;

create table if not exists ProductPriceHistory
(
    ProductID       smallint    not null,
    EmployeeID      smallint    not null,
    NewPrice        smallint    not null,      
    ChangeDate      datetime    not null,

    constraint PK_ProductPriceHistory primary key (ProductID, EmployeeID)
);