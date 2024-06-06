use estore;

drop table if exists ProductStateHistory;

create table ProductStateHistory
(
    ProductID       smallint        not null,
    EmployeeID      smallint        not null,
    NewState        tinyint         not null,      
    ChangeDate      datetime        not null,

    constraint PK_ProductStateHistory primary key (ProductID, EmployeeID)
);