use estore;

drop table if exists Client;

create table Client
(
    ClientID                        smallint        not null    auto_increment,
    Name                            nvarchar(120)   not null,
    Login                           nvarchar(60)    not null,
    PasswordHash                    char(32)        not null,
    PhoneNumber                     varchar(20)     null,
    Email                           varchar(50)     null,
    CountryID                       tinyint         not null,
    PurchaseLevelID                 tinyint         not null,
    BonusPoints                     smallint        not null,
    RegistrationDateTime            datetime        not null,
    LastAuthorizationDateTime       datetime        not null,

    constraint PK_Client primary key (ClientID)
);