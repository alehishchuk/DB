use eStore;

drop procedure if exists usp_CreatePickUpPoint;

delimiter $$
create procedure usp_CreatePickUpPoint(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- save Pick-up point
    insert into PickUpPoint(Name, Address, WorkingHours)
    with cte_JsonData(Name, Address, WorkingHours) as
    (
        select js.Name,
               js.Address,
               js.WorkingHours
        from JSON_TABLE(InJson, '$' columns
                                (
                                    Name            varchar(20)     path N'$.PickUpPoint.Name',
                                    Address         varchar(50)     path N'$.PickUpPoint.Address',
                                    WorkingHours    varchar(100)    path N'$.PickUpPoint.WorkingHours'
                                )

        )js
    )
    select cte_JsonData.Name,
           cte_JsonData.Address,
           cte_JsonData.WorkingHours
    from cte_JsonData;
end$$
delimiter ;