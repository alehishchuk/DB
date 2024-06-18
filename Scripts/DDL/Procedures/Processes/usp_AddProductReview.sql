use eStore;

drop procedure if exists usp_AddProductReview;

delimiter $$
create procedure usp_AddProductReview(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create review
    insert into Review (ProductID, ClientID, Comment, Rating, ReviewDate)
    with cte_JsonData (ProductBrand, ProductCode, ClientLogin, Comment, Rating, ReviewDate) as
    (
        select js.ProductBrand,
               js.ProductCode,
               js.ClientLogin,
               js.Comment,
               js.Rating,
               js.ReviewDate
        from JSON_TABLE(InJson, '$' columns 
                                (
                                    ProductBrand    varchar(20)     path N'$.Product.Brand',
                                    ProductCode     varchar(10)     path N'$.Product.Code',
                                    ClientLogin     varchar(60)     path N'$.Client.Login',
                                    Comment         varchar(255)    path N'$.Comment',
                                    Rating          tinyint         path N'$.Rating',
                                    ReviewDate      date            path N'$.ReviewDate'
                                ) 
                        ) js
    )
    select Product.ProductID,
           Client.ClientID,
           cte_JsonData.Comment,
           cte_JsonData.Rating,
           cte_JsonData.ReviewDate
    from cte_JsonData inner join
        Product on (cte_JsonData.ProductBrand = Product.Brand and
                    cte_JsonData.ProductCode = Product.Code) inner join
        Client on (cte_JsonData.ClientLogin = Client.Login);
    
end$$
delimiter ;

