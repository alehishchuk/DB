use eStore;

drop procedure if exists usp_AddProductDescription;

delimiter $$

create procedure usp_AddProductDescription(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition 1 @p2 = message_text;
        select @p1 as ErrorNumber, @p2 as ErrorMessage;
        rollback;
    end;
    
    -- create temporary table for json data
    drop table if exists tempJson;
    create temporary table tempJson (
        ProductBrand            varchar(20),
        ProductCode             varchar(10),
        ProductName             varchar(20),
        ProductMinAge           tinyint,
        ProductCatalogName      varchar(20),
        ProductEmployeeLogin    varchar(60)
    );

    -- insert data from json into tempJson table
    insert into tempJson (ProductBrand, ProductCode, ProductName, ProductMinAge, ProductCatalogName, ProductEmployeeLogin)
    select js.ProductBrand,
           js.ProductCode,
           js.ProductName,
           js.ProductMinAge,
           js.ProductCatalogName,
           js.ProductEmployeeLogin
    from JSON_TABLE(InJson, '$' columns (
                            ProductBrand            varchar(20)  path '$.Product.Brand',
                            ProductCode             varchar(10)  path '$.Product.Code',
                            ProductName             varchar(20)  path '$.Product.Name',
                            ProductMinAge           tinyint      path '$.Product.MinAge',
                            ProductCatalogName      varchar(20)  path '$.CatalogSection.Name',
                            ProductEmployeeLogin    varchar(60)  path '$.Employee.Login'
    )) js;

    -- Insert into Product table
    insert into Product (Brand, Code, Name, MinAge, CatalogID, EmployeeID)
    select tempJson.ProductBrand, 
           tempJson.ProductCode, 
           tempJson.ProductName, 
           tempJson.ProductMinAge, 
           CatalogSection.CatalogSectionID, 
           Employee.EmployeeID
    from tempJson
    inner join CatalogSection on (tempJson.ProductCatalogName = CatalogSection.Name)
    inner join Employee on (tempJson.ProductEmployeeLogin = Employee.Login);

    -- Insert into ProductCharacteristicsLink table
    insert into ProductCharacteristicsLink (ProductID, CharacteristicsId, Value)
    select p.ProductID,
           c.CharacteristicsId,
           js.Value
    from Product p
    inner join JSON_TABLE(InJson, '$.Product.Characteristics[*]' columns 
                            (
                                Name    varchar(20) path '$.Name',
                                Value   varchar(20) path '$.Value'
                            )
                    ) js
    inner join Characteristics c on (js.Name = c.Name)
    where p.Name = (select tempJson.ProductName from tempJson limit 1);

end$$

delimiter ;
