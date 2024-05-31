use eStore;

drop procedure if exists usp_CreateWarehouse;

delimiter $$
create procedure usp_CreateWarehouse(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- save warehouse
    insert into Warehouse(Name, Address, WorkingHours)
    with cte_JsonData(Name, Address, WorkingHours) as
    (
        select js.Name,
               js.Address,
               js.WorkingHours
        from JSON_TABLE(InJson, '$' columns
                                (
                                    Name            varchar(20)     path N'$.Warehouse.Name',
                                    Address         varchar(50)     path N'$.Warehouse.Address',
                                    WorkingHours    varchar(100)    path N'$.Warehouse.WorkingHours'
                                )

        )js
    )
    select cte_JsonData.Name,
           cte_JsonData.Address,
           cte_JsonData.WorkingHours
    from cte_JsonData;
end$$
delimiter ;