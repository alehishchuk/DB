use estore;

drop table if exists CatalogSection;

create table CatalogSection
(
    CatalogSectionID    tinyint         not null    auto_increment,
    Name                varchar(20)     not null,
    Catalog             varchar(20)     null,        
    DirectorID          tinyint         not null,

    constraint PK_CatalogSection primary key (CatalogSectionID)        
);