use eStore;

drop procedure if exists usp_CreateOrderStatus;

delimiter $$
create procedure usp_CreateOrderStatus(in InJson json)
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
        `Name` nvarchar(60)
    );
    -- insert data from json in tempJson table
    insert into tempJson (`Name`)
    select js.`Name`
    from JSON_TABLE(InJson, '$[*]' columns 
                                (
                                    `Name` nvarchar(60) path N'$.Name'
                                ) 
                   ) js;
    -- check new list of statuses
    if not exists (select tempJson.`Name`
                   from tempJson)
    then
        select 'Error: no data for replace.';
        leave proc_body;
    end if;
    -- describe operations as transaction
    start transaction;
        -- delete old job positions, except for the same ones in both tables
        delete OrderStatus
        from OrderStatus left outer join
             tempJson on (OrderStatus.`Name` = tempJson.`Name`)
        where (tempJson.`Name` is null);
        -- add new job positions that don't exist
        insert into OrderStatus (`Name`)
        select tempJson.`Name`
        from tempJson left outer join
             OrderStatus on (tempJson.`Name` = OrderStatus.`Name`)
        where (OrderStatus.OrderStatusID is null);
    -- successful end of transaction
    commit;
end$$
delimiter ;

