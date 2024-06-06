use eStore;

drop procedure if exists usp_SetProductPrice;

delimiter $$
create procedure usp_SetProductPrice(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;

    -- create temporary table for json data
    drop table if exists tempJson;
    create temporary table tempJson (
        Brand            varchar(20),
        Code             varchar(10),
        Price            varchar(10), 
        EmployeeLogin    varchar(10),
        ChangeDate       datetime
    );

    start transaction;

    -- insert data from json into tempJson table
    insert into tempJson (Brand, Code, Price, EmployeeLogin, ChangeDate)
    select js.Brand,
           js.Code,
           js.Price,
           js.EmployeeLogin,
           js.ChangeDate
    from JSON_TABLE(InJson, '$' columns (
                            Brand           varchar(20)  path '$.Product.Brand',
                            Code            varchar(10)  path '$.Product.Code',
                            Price           varchar(20)  path '$.Product.Price',
                            EmployeeLogin   varchar(20)  path '$.Employee.Login',
                            ChangeDate      varchar(60)  path '$.Product.ChangeDate'
    )) js;

    -- Insert into ProductPriceHistory table
    delete from ProductPriceHistory
    where exists(
        select * 
        from tempJson
        inner join Product on (tempJson.Brand = Product.Brand and
                               tempJson.Code = Product.Code)
        inner join Employee on (tempJson.EmployeeLogin = Employee.Login)
        where ProductPriceHistory.ProductID = Product.ProductID and 
              ProductPriceHistory.EmployeeID = Employee.EmployeeID               
    );  

    insert into ProductPriceHistory (NewPrice, ChangeDate, ProductID, EmployeeID)
    select tempJson.Price, 
           tempJson.ChangeDate, 
           Product.ProductID, 
           Employee.EmployeeID
    from tempJson
    inner join Product on (tempJson.Brand = Product.Brand and
                           tempJson.Code = Product.Code)
    inner join Employee on (tempJson.EmployeeLogin = Employee.Login);

    -- update product with new product price
    update Product
    inner join tempJson on (tempJson.Brand = Product.Brand and
                            tempJson.Code = Product.Code)
    set Product.Price = tempJson.Price;

    commit;

    drop temporary table if exists tempJson;
    
end$$
delimiter ;

