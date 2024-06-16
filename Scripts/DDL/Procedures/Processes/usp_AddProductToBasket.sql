use eStore;

drop procedure if exists usp_AddProductToBasket;

delimiter $$
create procedure usp_AddProductToBasket(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create basket (addition states to existing ones)
    insert into Basket (ClientID, ProductID, Quantity)
    with cte_JsonData (ClientLogin, ProductBrand, ProductCode, Quantity) as
    (
        select js.ClientLogin,
               js.ProductBrand,
               js.ProductCode,
               js.Quantity
        from JSON_TABLE(InJson, '$' columns 
                                (
                                    ClientLogin     varchar(60) path N'$.Client.Login',
                                    ProductBrand    varchar(20) path N'$.Product.Brand',
                                    ProductCode     varchar(10) path N'$.Product.Code',
                                    Quantity        smallint    path N'$.Product.ProductQuantity'
                                ) 
                        ) js
    )
    select Client.ClientID,
           Product.ProductID,
           cte_JsonData.Quantity
    from cte_JsonData inner join
        Product on (cte_JsonData.ProductBrand = Product.Brand and
                    cte_JsonData.ProductCode = Product.Code) inner join
        Client on (cte_JsonData.ClientLogin = Client.Login);
    
end$$
delimiter ;

