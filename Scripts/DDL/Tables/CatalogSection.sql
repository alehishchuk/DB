use estore;

drop table if exists CatalogSection;

create table CatalogSection
(
    CatalogSectionID    smallint        not null    auto_increment,
    Name                varchar(20)     not null,
    Catalog             smallint        null,        
    DirectorID          smallint         not null,

    constraint PK_CatalogSection primary key (CatalogSectionID)        
);