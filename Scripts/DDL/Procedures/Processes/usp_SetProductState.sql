use eStore;

drop procedure if exists usp_SetProductState;

delimiter $$
create procedure usp_SetProductState(in InJson json)
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
        State            varchar(20), 
        EmployeeLogin    varchar(20),
        ChangeDate       datetime
    );

    start transaction;

    -- insert data from json into tempJson table
    insert into tempJson (Brand, Code, State, EmployeeLogin, ChangeDate)
    select js.Brand,
           js.Code,
           js.State,
           js.EmployeeLogin,
           js.ChangeDate
    from JSON_TABLE(InJson, '$' columns (
                            Brand           varchar(20)  path '$.Product.Brand',
                            Code            varchar(10)  path '$.Product.Code',
                            State           varchar(20)  path '$.Product.State',
                            EmployeeLogin   varchar(20)  path '$.Employee.Login',
                            ChangeDate      varchar(60)  path '$.Product.ChangeDate'
    )) js;

    -- Insert into ProductStateHistory table
    delete from ProductStateHistory
    where exists(
        select * 
        from tempJson
        inner join Product on (tempJson.Brand = Product.Brand and
                               tempJson.Code = Product.Code)
        inner join Employee on (tempJson.EmployeeLogin = Employee.Login)
        where ProductStateHistory.ProductID = Product.ProductID and 
              ProductStateHistory.EmployeeID = Employee.EmployeeID               
    );  

    insert into ProductStateHistory (NewState, ChangeDate, ProductID, EmployeeID)
    select ProductState.ProductStateID, 
           tempJson.ChangeDate, 
           Product.ProductID, 
           Employee.EmployeeID
    from tempJson
    inner join Product on (tempJson.Brand = Product.Brand and
                           tempJson.Code = Product.Code)
    inner join Employee on (tempJson.EmployeeLogin = Employee.Login)
    inner join ProductState on (tempJson.State = ProductState.Name);

    -- update product with new product state
    update Product
    inner join tempJson on (tempJson.Brand = Product.Brand and
                            tempJson.Code = Product.Code)
    inner join ProductState on (tempJson.State = ProductState.Name)
    set Product.State = ProductState.ProductStateID;

    commit;

    drop temporary table if exists tempJson;
    
end$$
delimiter ;

