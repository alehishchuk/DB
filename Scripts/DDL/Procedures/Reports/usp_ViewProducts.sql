use estore;

drop procedure if exists usp_ViewProducts;

delimiter $$

create procedure usp_ViewProducts(in injson json)
begin
    declare var_WhereSectionExists tinyint;
    declare var_CatalogSection     varchar(50);
    declare var_Brands             varchar(50);
    declare var_State              varchar(20);
    declare var_MinVal             varchar(10); 
    declare var_MaxVal             varchar(10);
    declare var_SortingMode        tinyint;
    declare var_Offset             tinyint;
    declare var_Limit              tinyint;
    
    declare exit handler for sqlexception
    begin
        get diagnostics condition 1 @p1 = message_text;
        select @p1;
    end;

    drop temporary table if exists tempjson;
    create temporary table tempjson (
        CatalogSection varchar(50),
        Brand varchar(50),
        State varchar(20),
        CharacteristicName varchar(50),
        MinVal smallint,
        MaxVal smallint,
        SortingMode tinyint,
        `Offset` int,
        `Limit` int
    );

    insert into tempjson (CatalogSection, Brand, State, CharacteristicName, MinVal, MaxVal, SortingMode, `Offset`, `Limit`)
    select distinct
        js.CatalogSection,
        js.Brand,
        js.State,
        js.CharacteristicName,
        js.MinVal,
        js.MaxVal,
        js.SortingMode,
        js.`Offset`,
        js.`Limit`
    from json_table(injson, '$' columns (
        CatalogSection varchar(50) path '$.CatalogSection',
        State          varchar(20) path '$.State',
        nested path '$.Brands[*]' columns (
            brand varchar(50) path N'$'
        ),
        nested path '$.CharValueRanges[*]' columns (
            characteristicname 	varchar(20) path N'$.CharacteristicName',
            minval				varchar(20)	path N'$.Min',
            maxval				varchar(20)	path N'$.Max'
        ),
        SortingMode     int         path '$.SortingMode',
        `Offset`        int         path '$.Offset',
        `Limit`         int         path '$.Limit'
    )) js;

    set @ResultQuery = 'select p.Name, p.Brand, ps.Name as State, p.Price, 
                        group_concat(c.Name order by c.Name asc separator ",") as `Characteristics`, 
                        group_concat(pcl.Value order by c.Name asc separator ",") as `Values` 
                        from Product p inner join 
                        CatalogSection on (p.CatalogID = CatalogSection.CatalogSectionID) inner join
                        ProductState ps on (p.State = ps.ProductStateID) inner join 
                        ProductCharacteristicsLink pcl on (pcl.ProductID = p.ProductID) inner join 
                        Characteristics c on (pcl.CharacteristicsID = c.CharacteristicsID)';                        

    -- add filter by characteristics value range
    if exists (select tempJson.CharacteristicName
               from tempJson 
               where (tempJson.CharacteristicName is not null))
    then
        set @ResultQuery := CONCAT(@ResultQuery, ' inner join tempJson on (c.Name = tempJson.CharacteristicName)');
    end if;

    -- add filter to query products from specified catalog section 
    set @var_WhereSectionExists := 0;

    if @var_WhereSectionExists = 0
        then set @ResultQuery := CONCAT(@ResultQuery, ' where');
        set @var_WhereSectionExists := 1;
    else set @ResultQuery := CONCAT(@ResultQuery, ' and');
    end if;
    set var_CatalogSection := (select distinct tempJson.CatalogSection from tempJson);
    set @ResultQuery := CONCAT(@ResultQuery, ' CatalogSection.Name = "', var_CatalogSection, '"');

    -- add filter to query products with specified brands 
    set var_Brands = (select GROUP_CONCAT(distinct quote(Brand) separator ',') 
                      from tempjson
                      where Brand is not null);

    if @var_WhereSectionExists = 0
    then set @ResultQuery := CONCAT(@ResultQuery, ' where');
        set @var_WhereSectionExists := 1;
    else set @ResultQuery := CONCAT(@ResultQuery, ' and');
    end if;
    set @ResultQuery := CONCAT(@ResultQuery, ' p.Brand IN (', var_Brands, ')');

    -- add filter to query products with specified state   
    set var_State := (select distinct tempJson.State from tempJson); 
    
    if @var_WhereSectionExists = 0
        then set @ResultQuery := CONCAT(@ResultQuery, ' where');
        set @var_WhereSectionExists := 1;
    else set @ResultQuery := CONCAT(@ResultQuery, ' and');
    end if;
    set @ResultQuery := CONCAT(@ResultQuery, ' ps.Name = "', var_State, '"');
    
    -- add data grouping section to the resulting query
    set @ResultQuery := CONCAT(@ResultQuery, ' group by p.Name, p.Brand, ps.Name, p.Price');

    -- add sorting to query
    set var_SortingMode := (select distinct tempJson.SortingMode from tempJson); 
    
    if var_SortingMode is not null then
        case var_SortingMode
            when 1 then set @ResultQuery = concat(@ResultQuery, ' order by p.Name asc');
            when 2 then set @ResultQuery = concat(@ResultQuery, ' order by p.Name desc');
            when 3 then set @ResultQuery = concat(@ResultQuery, ' order by p.Price asc');
            when 4 then set @ResultQuery = concat(@ResultQuery, ' order by p.Price desc');
            else set @ResultQuery = concat(@ResultQuery, ' order by p.ProductName asc');
        end case;
    end if;

    -- add pagination
    set var_Offset := (select distinct tempJson.`Offset` from tempJson); 
    set var_Limit := (select distinct tempJson.`Limit` from tempJson);     

    if var_Offset is not null and var_Limit is not null then
        set @ResultQuery = concat(@ResultQuery, ' Limit ', var_Offset, ', ', var_Limit);
    end if;

    -- REMOVE AFTER TESTING
    select @ResultQuery;  

    prepare stmt from @resultquery;
    execute stmt;
    deallocate prepare stmt;

end$$

delimiter ;
