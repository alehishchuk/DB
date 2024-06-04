use eStore;

drop procedure if exists usp_CreateProductCharacteristics;

delimiter $$
create procedure usp_CreateProductCharacteristics(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create characteristics (addition characteristics to existing ones)
    insert into Characteristics (`Name`)
    with cte_JsonData (`Name`) as
    (
        select js.`Name`
        from JSON_TABLE(InJson, '$.Characteristics[*]' columns 
                                (
                                    `Name` varchar(20) path N'$.Name'
                                ) 
                        ) js
    )
    select cte_JsonData.`Name`
    from cte_JsonData left outer join
         Characteristics on (cte_JsonData.`Name` = Characteristics.`Name`)
    where (Characteristics.Name is null);
end$$
delimiter ;

