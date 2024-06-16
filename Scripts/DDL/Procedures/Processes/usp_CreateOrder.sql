use eStore;

drop procedure if exists usp_CreateOrder;

delimiter $$
create procedure usp_CreateOrder(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    
    -- create temporary table
    drop table if exists tempJson;
    create table tempJson
    (
        ClientLogin     varchar(60),
        CreatedDate     datetime,
        OrderCode       varchar(10),
        OrderStatus     varchar(20),
        VAT             tinyint,
        ShelfLife       datetime,
        ProductCode     varchar(10),
        ProductBrand    varchar(10),
        Warehouse       varchar(50),
        PickUpPoint     varchar(50)
    );
    insert into tempJson (ClientLogin, 
                          CreatedDate, 
                          OrderCode, 
                          OrderStatus, 
                          VAT,
                          ShelfLife,
                          ProductCode,
                          ProductBrand,
                          Warehouse,
                          PickUpPoint)
    select js.ClientLogin, 
           js.CreatedDate, 
           js.OrderCode,
           js.OrderStatus,
           js.VAT,
           js.ShelfLife,
           js.ProductCode,
           js.ProductBrand,
           js.Warehouse,
           js.PickUpPoint
    from JSON_TABLE(InJson, '$' columns
                            (
                                ClientLogin     varchar(60)     path N'$.Client.Login',
                                CreatedDate     datetime        path N'$.Order.CreatedDate',
                                OrderCode       varchar(10)     path N'$.Order.Code',
                                OrderStatus     varchar(10)     path N'$.Order.Status',
                                VAT             tinyint         path N'$.Order.VAT',
                                ShelfLife       datetime        path N'$.Order.ShelfLife',
                                Warehouse       varchar(50)     path N'$.Warehouse.Name',
                                PickUpPoint     varchar(50)     path N'$.PickUpPoint.Name',
                                nested path '$.Product[*]' columns 
                                (
                                    ProductCode         varchar(10)     path N'$.Code',
                                    ProductBrand        varchar(10)     path N'$.Brand'
                                )
                            )
    ) js;

    -- create order
    insert into `Order` (ClientID,
                         Code,
                         CreatedDate,
                         FinalCost,
                         `Status`,
                         ShelfLife,
                         WarehouseID,
                         PickUpPointID,
                         VAT)
    select distinct Client.ClientID,
                    tempJson.OrderCode,
                    tempJson.CreatedDate,
                    0.0,
                    OrderStatus.OrderStatusID,
                    tempJson.ShelfLife,
                    Warehouse.WarehouseID,
                    PickUpPoint.PickUpPointID,
                    tempJson.VAT
    from tempJson inner join
    Warehouse on (tempJson.Warehouse = Warehouse.Name) left join
    PickUpPoint on (tempJson.PickUpPoint = PickUpPoint.Name) inner join
    Client on (tempJson.ClientLogin = Client.Login) inner join
    OrderStatus on (tempJson.OrderStatus = OrderStatus.Name)    
    limit 1;

    -- set Final Cost

    set @orderID = LAST_INSERT_ID();

    select SUM(p.Price * b.Quantity) into @totalCost
    from tempJson t inner join
    Product p on (t.ProductCode = p.Code and 
                  t.ProductBrand = p.Brand) inner join
    Client c on (t.ClientLogin = c.Login) inner join             
    Basket b on (p.ProductID = b.ProductID and 
                 c.ClientID = b.ClientID);

    update `Order`
    set FinalCost = @totalCost
    where OrderID = @orderID;

    -- remove baskets for this order
    delete Basket 
    from Basket inner join
    Product p on (Basket.ProductID = p.ProductID) inner join
    Client c on (Basket.ClientID = c.ClientID) inner join
    tempjson t on (p.Brand = t.ProductBrand and p.Code = t.ProductCode)
    where p.Brand = t.ProductBrand and 
          p.Code = t.ProductCode and 
          c.Login = t.ClientLogin;    
    
end$$
delimiter ;

