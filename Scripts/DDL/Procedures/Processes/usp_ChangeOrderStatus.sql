use eStore;

drop procedure if exists usp_ChangeOrderStatus;

delimiter $$
create procedure usp_ChangeOrderStatus(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
        -- unsuccessful end of transaction
        rollback;
    end;    
    
    -- create temporary table for json data    
    drop table if exists tempJson;
    create temporary table tempJson
    (
        Code            nvarchar(60),
        CurrentStatus   nvarchar(20),  
        NewStatus       nvarchar(20),
        ChangeDate      datetime,
        Employee        nvarchar(60)  
    );

    start transaction;

    -- insert data from json in tempJson table
    insert into tempJson (Code, CurrentStatus, NewStatus, ChangeDate, Employee)
    select js.Code, CurrentStatus, NewStatus, ChangeDate, Employee
    from JSON_TABLE(InJson, '$' columns 
                                (
                                    Code            nvarchar(10) path N'$.Order.Code',
                                    CurrentStatus   nvarchar(20) path N'$.Order.Status',
                                    NewStatus       nvarchar(20) path N'$.NewStatus',
                                    ChangeDate      nvarchar(60) path N'$.ChangeDateTime',
                                    Employee        nvarchar(60) path N'$.Employee'
                                ) 
                   ) js;

    -- insert order status history record
    insert into OrderStatusHistory (OrderID, EmployeeID, OrderStatusID, ChangeDate)
    select Order.OrderID,
           Employee.EmployeeID,
           OrderStatus.OrderStatusID,
           tempJson.ChangeDate
    from tempJson inner join
    Employee on (tempJson.Employee = Employee.Login) inner join
    OrderStatus on (tempJson.NewStatus = OrderStatus.Name) inner join
    `Order` on (tempJson.Code = Order.Code);

    -- update order
    update `Order` inner join
    tempJson on `Order`.Code = tempJson.Code inner join
    OrderStatus on (tempJson.NewStatus = OrderStatus.Name)
    set status = OrderStatus.OrderStatusID;   

    commit;

    drop temporary table if exists tempJson;

end$$
delimiter ;

