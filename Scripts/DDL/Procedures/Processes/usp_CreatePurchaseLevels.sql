use eStore;

drop procedure if exists usp_CreatePurchaseLevels;

delimiter $$
create procedure usp_CreatePurchaseLevels(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create purchase levels (addition levels to existing ones)
    insert into PurchaseLevel (`Name`)
    with cte_JsonData (`Name`) as
    (
        select js.`Name`
        from JSON_TABLE(InJson, '$.PurchaseLevel[*]' columns 
                                (
                                    `Name` varchar(10) path N'$.Name'
                                ) 
                        ) js
    )
    select cte_JsonData.`Name`
    from cte_JsonData left outer join
         PurchaseLevel on (cte_JsonData.`Name` = PurchaseLevel.`Name`)
    where (PurchaseLevel.Name is null);
end$$
delimiter ;

