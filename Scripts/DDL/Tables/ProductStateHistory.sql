use estore;

create table if not exists ProductStateHistory
(
    ProductID       smallint        not null,
    EmployeeID      smallint        not null,
    NewState        varchar(20)     not null,      
    ChangeDate      datetime        not null,

    constraint PK_ProductStateHistory primary key (ProductID, EmployeeID)
);