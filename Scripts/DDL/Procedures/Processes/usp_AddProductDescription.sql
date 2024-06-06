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
        ProductEmployeeLogin    varchar(60),
        CharacteristicsName     varchar(20),
        CharacteristicsValue    varchar(20)
    );

    -- insert data from json into tempJson table
    insert into tempJson (ProductBrand, ProductCode, ProductName, ProductMinAge, ProductCatalogName, ProductEmployeeLogin, CharacteristicsName, CharacteristicsValue)
    select js.ProductBrand,
           js.ProductCode,
           js.ProductName,
           js.ProductMinAge,
           js.ProductCatalogName,
           js.ProductEmployeeLogin,
           js.CharacteristicsName,
           js.CharacteristicsValue
    from JSON_TABLE(InJson, '$' columns (
                            ProductBrand            varchar(20)  path '$.Product.Brand',
                            ProductCode             varchar(10)  path '$.Product.Code',
                            ProductName             varchar(20)  path '$.Product.Name',
                            ProductMinAge           tinyint      path '$.Product.MinAge',
                            ProductCatalogName      varchar(20)  path '$.CatalogSection.Name',
                            ProductEmployeeLogin    varchar(60)  path '$.Employee.Login',
                            nested path '$.Product.Characteristics[*]' columns 
                            (
                                CharacteristicsName     varchar(20)     path N'$.Name',
                                CharacteristicsValue    varchar(20)     path N'$.Value'
                            )
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
    insert into ProductCharacteristicsLink (ProductID, CharacteristicsID, Value)
    select Product.ProductID,
           Characteristics.CharacteristicsID,
           tempJson.CharacteristicsValue
    from tempJson
    inner join Product on (tempJson.ProductBrand = Product.Brand and
                           tempJson.ProductCode = Product.Code)
    inner join Characteristics on (tempJson.CharacteristicsName = Characteristics.Name);
    

end$$

delimiter ;
