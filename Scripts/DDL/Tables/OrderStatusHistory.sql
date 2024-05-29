use estore;

drop table if exists OrderStatusHistory;

create table OrderStatusHistory
(
    OrderID             smallint    not null,
    EmployeeID          smallint    not null,
    OrderStatusID       tinyint     not null,
    ChangeDate          datetime    not null,

    constraint PK_OrderStatusHistory primary key (OrderID, EmployeeID)
);