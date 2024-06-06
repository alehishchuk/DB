use eStore;

drop procedure if exists usp_SetProductQuantity;

delimiter $$

create procedure usp_SetProductQuantity(in InJson json)
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
        WarehouseName           varchar(20),
        ProductEmployeeLogin    varchar(60),
        ProductQuantity         tinyint        
    );

    -- insert data from json into tempJson table
    insert into tempJson (ProductBrand, ProductCode, WarehouseName, ProductEmployeeLogin, ProductQuantity)
    select js.ProductBrand,
           js.ProductCode,
           js.WarehouseName,
           js.ProductEmployeeLogin,
           js.ProductQuantity
    from JSON_TABLE(InJson, '$' columns 
                            (
                                ProductBrand            varchar(20)  path '$.Product.Brand',
                                ProductCode             varchar(10)  path '$.Product.Code',
                                WarehouseName           varchar(20)  path '$.Warehouse.Name',
                                ProductEmployeeLogin    varchar(60)  path '$.Employee.Login',
                                ProductQuantity         varchar(10)  path '$.ProductQuantity'                                
                            )
                    ) js;
select * from tempJson;
    -- insert ProductWarehouseLink table
    insert into ProductWarehouseLink (ProductID, WarehouseID, Quantity)
    select Product.ProductID,
           Warehouse.WarehouseID,
           tempJson.ProductQuantity
    from tempJson
    inner join Product on (tempJson.ProductBrand = Product.Brand and
                           tempJson.ProductCode = Product.Code)
    inner join Warehouse on (tempJson.WarehouseName = Warehouse.Name);    

end$$

delimiter ;
