use estore;

drop table if exists Warehouse;

create table Warehouse
(
    WarehouseID         tinyint         not null    auto_increment,
    Name                varchar(20)     not null,
    Address             varchar(50)     not null,
    WorkingHours        varchar(100)    not null,

    constraint PK_Warehouse primary key (WarehouseID) 
);