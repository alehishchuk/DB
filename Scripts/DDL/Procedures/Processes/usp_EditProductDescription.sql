use eStore;

drop procedure if exists usp_EditProductDescription;

delimiter $$

create procedure usp_EditProductDescription(in InJson json)
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
        Active                  tinyint(1),       
        ProductEmployeeLogin    varchar(60),
        CharacteristicsName     varchar(20),
        CharacteristicsValue    varchar(20)
    );

    -- insert data from json into tempJson table
    insert into tempJson (ProductBrand, ProductCode, ProductName, ProductMinAge, Active, ProductEmployeeLogin, CharacteristicsName, CharacteristicsValue)
    select js.ProductBrand,
           js.ProductCode,
           js.ProductName,
           js.ProductMinAge,
           js.Active,           
           js.ProductEmployeeLogin,
           js.CharacteristicsName,
           js.CharacteristicsValue
    from JSON_TABLE(InJson, '$' columns 
                            (
                                ProductBrand            varchar(20)  path '$.Product.Brand',
                                ProductCode             varchar(10)  path '$.Product.Code',
                                ProductName             varchar(20)  path '$.NewDescription.Name',
                                ProductMinAge           tinyint      path '$.NewDescription.MinAge',
                                Active                  tinyint(1)   path '$.NewDescription.Active',
                                ProductEmployeeLogin    varchar(60)  path '$.Employee.Login',
                                nested path '$.NewDescription.Characteristics[*]' columns 
                                (
                                    CharacteristicsName     varchar(20)     path N'$.Name',
                                    CharacteristicsValue    varchar(20)     path N'$.Value'
                                )
                            )
                    ) js;

    -- update product description
    update Product
    inner join tempJson on (tempJson.ProductBrand = Product.Brand and 
                            tempJson.ProductCode = Product.Code) 
    set Product.Name = tempJson.ProductName,
        Product.MinAge = tempJson.ProductMinAge,
        Product.Active = tempJson.Active;

    -- update characteristics
    delete ProductCharacteristicsLink
    from ProductCharacteristicsLink
    inner join Product on (ProductCharacteristicsLink.ProductID = Product.ProductID)
    inner join tempJson on (tempJson.ProductBrand = Product.Brand and
                            tempJson.ProductCode = Product.Code);

    insert into ProductCharacteristicsLink (ProductID, CharacteristicsID, Value)
    select Product.ProductID,
           Characteristics.CharacteristicsId,
           tempJson.CharacteristicsValue
    from tempJson
    inner join Product on (tempJson.ProductBrand = Product.Brand and
                           tempJson.ProductCode = Product.Code)
    inner join Characteristics on (tempJson.CharacteristicsName = Characteristics.Name);    

end$$

delimiter ;
