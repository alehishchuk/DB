use estore;

create table if not exists OrderStatusHistory
(
    OrderID             smallint    not null,
    EmployeeID          smallint    not null,
    OrderStatusID       tinyint     not null,
    ChangeDate          datetime    not null,

    constraint PK_OrderStatusHistory primary key (OrderID, EmployeeID)
);