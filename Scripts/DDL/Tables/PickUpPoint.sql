use estore;

create table if not exists PickUpPoint
(
    PickUpPointID       tinyint         not null    auto_increment,
    Name                varchar(20)     not null,
    Address             varchar(50)     not null,
    WorkingHours        varchar(100)    not null,

    constraint PK_PickUpPoint primary key (PickUpPointID) 
);