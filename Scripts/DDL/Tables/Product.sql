use estore;

drop table if exists Product;

create table Product
(
    ProductID           smallint        not null    auto_increment,
    Brand               varchar(20)     not null,
    Code                varchar(10)     not null,
    Name                varchar(20)     not null,
    Price               decimal(10, 2)  null,
    MinAge              tinyint         null,
    State               smallint        null,
    Active              boolean         not null,
    CatalogID           smallint        not null,    
    EmployeeID          smallint        not null,

    constraint PK_Product primary key (ProductID)
);