use estore;

drop table if exists ProductPriceHistory;

create table ProductPriceHistory
(
    ProductID       smallint    not null,
    EmployeeID      smallint    not null,
    NewPrice        smallint    not null,      
    ChangeDate      datetime    not null,

    constraint PK_ProductPriceHistory primary key (ProductID, EmployeeID)
);