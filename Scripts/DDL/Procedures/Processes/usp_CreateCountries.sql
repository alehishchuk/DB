use eStore;

drop procedure if exists usp_CreateCountries;

delimiter $$
create procedure usp_CreateCountries(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create countries (addition countries to existing ones)
    insert into Country (`Name`)
    with cte_JsonData (`Name`) as
    (
        select js.`Name`
        from JSON_TABLE(InJson, '$.Country[*]' columns 
                                (
                                    `Name` varchar(50) path N'$.Name'
                                ) 
                        ) js
    )
    select cte_JsonData.`Name`
    from cte_JsonData left outer join
         Country on (cte_JsonData.`Name` = Country.`Name`)
    where (Country.Name is null);
end$$
delimiter ;

