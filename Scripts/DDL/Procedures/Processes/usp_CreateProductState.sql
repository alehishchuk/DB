use eStore;

drop procedure if exists usp_CreateProductStates;

delimiter $$
create procedure usp_CreateProductStates(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create product states (addition states to existing ones)
    insert into ProductState (`Name`)
    with cte_JsonData (`Name`) as
    (
        select js.`Name`
        from JSON_TABLE(InJson, '$.ProductState[*]' columns 
                                (
                                    `Name` varchar(20) path N'$.Name'
                                ) 
                        ) js
    )
    select cte_JsonData.`Name`
    from cte_JsonData left outer join
         ProductState on (cte_JsonData.`Name` = ProductState.`Name`)
    where (ProductState.Name is null);
end$$
delimiter ;

