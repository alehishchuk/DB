use estore;

drop table if exists Review;

create table Review
(
    ProductID           smallint        not null,
    ClientID            smallint        not null,
    Comment             varchar(255)    null,
    Rating              tinyint         null,
    ReviewDate          date            not null,

    constraint PK_Review primary key (ProductID, ClientID)
);