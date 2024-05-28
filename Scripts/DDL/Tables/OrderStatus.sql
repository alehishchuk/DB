use estore;

create table if not exists OrderStatus
(
    OrderStatusID   tinyint         not null    auto_increment,
    Name            varchar(10)     not null,

    constraint PK_OrderStatus primary key (OrderStatusID)
);