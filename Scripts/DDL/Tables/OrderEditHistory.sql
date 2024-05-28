use estore;

create table if not exists OrderEditHistory
(
    OrderID         smallint        not null,
    EmployeeID      smallint        not null,
    ChangeDate      datetime        not null,
    FinalCost       smallint        null,
    ShelfLife       tinyint         null,
    VAT             tinyint         null,

    constraint PK_OrderEditHistory primary key (OrderID, EmployeeID)
);