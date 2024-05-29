use estore;

drop table if exists OrderStatus;

create table OrderStatus
(
    OrderStatusID   tinyint         not null    auto_increment,
    Name            varchar(10)     not null,

    constraint PK_OrderStatus primary key (OrderStatusID)
);