use eStore;

drop procedure if exists usp_CreateCatalogSection;

delimiter $$
create procedure usp_CreateCatalogSection(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- save Catalog section point
    insert into CatalogSection(Name, Catalog, DirectorID)
    with cte_JsonData(Name, Catalog, DirectorLogin) as
    (
        select js.Name,
               js.Catalog,
               js.DirectorLogin
        from JSON_TABLE(InJson, '$' columns
                                (
                                    Name            varchar(50)     path N'$.Catalog.Name',
                                    Catalog         varchar(50)     path N'$.ParentCatalog.Name',
                                    DirectorLogin   varchar(20)     path N'$.Employee.Login'
                                )

        )js
    )
    select cte_JsonData.Name,
           CatalogSection.CatalogSectionID,
           Employee.EmployeeID
    from cte_JsonData
    left join CatalogSection on (cte_JsonData.Catalog = CatalogSection.`Name`)
    inner join Employee on (cte_JsonData.DirectorLogin = Employee.Login);
end$$
delimiter ;