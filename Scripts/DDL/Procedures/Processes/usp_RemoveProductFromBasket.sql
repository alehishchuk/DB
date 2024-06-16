use eStore;

drop procedure if exists usp_RemoveProductFromBasket;

delimiter $$
create procedure usp_RemoveProductFromBasket(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- delete basket
    drop table if exists tempJson;
    create table tempJson
    (
        `Login`         varchar(60),
        ProductBrand    varchar(10),
        ProductCode     varchar(10)
    );
    insert into tempJson (`Login`, ProductBrand, ProductCode)
    select js.`Login`, 
           js.ProductBrand, 
           js.ProductCode
    from JSON_TABLE(InJson, '$' columns
                            (
                                `Login`         varchar(60)     path N'$.Client.Login',
                                ProductBrand    varchar(10)     path N'$.Product.Brand',
                                ProductCode     varchar(10)     path N'$.Product.Code'
                            )
    ) js;

    delete Basket 
    from Basket inner join
    Product p on (Basket.ProductID = p.ProductID) inner join
    Client c on (Basket.ClientID = c.ClientID) inner join
    tempjson t on (p.Brand = t.ProductBrand and p.Code = t.ProductCode);
    
end$$
delimiter ;

