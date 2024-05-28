use estore;

drop table if exists ProductState;

create table ProductState
(
    ProductStateID      tinyint         not null    auto_increment,
    Name                varchar(20)     not null,

    constraint PK_ProductState primary key (ProductStateID)
);