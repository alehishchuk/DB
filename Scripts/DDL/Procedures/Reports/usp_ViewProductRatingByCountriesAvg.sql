use eStore;

drop procedure if exists usp_ViewProductRatingByCountriesAvg;

delimiter $$
create procedure usp_ViewProductRatingByCountriesAvg(in InJson json)
proc_body:
begin
    -- Local variables
    declare var_StartDate date;
    declare var_FinishDate date;
    declare var_ShowNullCols bool;
    declare var_ShowNullRows bool;
    
    -- Error handling
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    
    -- Create temp table for a parsing of json
    drop table if exists tempJson;
    create temporary table tempJson
    (
        CountryName     varchar(50),
        ProductCode     varchar(10),
        ProductBrand    varchar(20),
        StartDate       date,
        FinishDate      date,
        ShowNullCols    int,
        ShowNullRows    int        
    );
    
    insert into tempJson (CountryName, ProductCode, ProductBrand, StartDate, FinishDate, ShowNullCols, ShowNullRows)
    select js.CountryName,
           js.ProductCode,
           js.ProductBrand,
           js.StartDate,
           js.FinishDate,
           js.ShowNullCols,
           js.ShowNullRows
    from JSON_TABLE(InJson, '$' columns 
                            (
                                nested path '$.Countries[*]' columns
                                (
                                    CountryName varchar(50) path '$.Name'
                                ),
                                nested path '$.Products[*]' columns
                                (
                                    ProductCode     varchar(10)     path '$.Code',
                                    ProductBrand    varchar(20)     path '$.Brand'    
                                ),
                                StartDate    date        path N'$.Period.StartDate',
                                FinishDate   date        path N'$.Period.FinishDate',
                                ShowNullCols int         path N'$.ShowNullCols',
                                ShowNullRows int         path N'$.ShowNullRows'
                            )
                   ) js;

    -- check period
    if exists (select tempJson.StartDate
               from tempJson 
               where ((tempJson.StartDate > tempJson.FinishDate) or
                      (tempJson.StartDate is null) or
                      (tempJson.FinishDate is null)))
    then
        select 'Error: period wrong!';
        leave proc_body;
    end if;
    -- prepare period variables
    set var_StartDate := (select distinct tempJson.StartDate from tempJson);
    set var_FinishDate := (select distinct tempJson.FinishDate from tempJson);
    
    -- prepare ShowNullCols and ShowNullRows variables
    set var_ShowNullCols := (select distinct tempJson.ShowNullCols from tempJson);
    set var_ShowNullRows := (select distinct tempJson.ShowNullRows from tempJson);

    -- Create temporary tables for products and countries
    drop table if exists tempProducts;
    create temporary table tempProducts
    (
        `Name` varchar(50)
    );
    
    drop table if exists tempCountries;
    create temporary table tempCountries
    (
        `Name` varchar(50)
    );
    
    -- Create temporary table for review data
    drop table if exists tempReviewData;
    create temporary table tempReviewData
    (
        ProductName     varchar(50),
        CountryName     varchar(50),
        Rating          float
    );

    -- populate tempProducts
    if var_ShowNullRows = 1 then
        insert into tempProducts
        select Name
        from Product;
    else
        insert into tempProducts
        select distinct p.Name
        from tempJson t
        inner join Product p on (t.ProductCode = p.Code and t.ProductBrand = p.Brand);
    end if;
    
    -- populate tempCountries
    insert into tempCountries
    select distinct tempJson.CountryName
    from tempJson;

    -- Populate tempReviewData
    insert into tempReviewData (ProductName, CountryName, Rating)
    select p.Name, c.Name, r.Rating
    from Review r
    inner join Client cl on r.ClientID = cl.ClientID
    inner join Product p on r.ProductID = p.ProductID
    inner join Country c on cl.CountryID = c.CountryID
    inner join tempProducts tp on p.Name = tp.Name
    where r.ReviewDate >= var_StartDate
      and r.ReviewDate <= var_FinishDate;

    -- prepare sub-query    
    if var_ShowNullCols = 1 then
        select 
            group_concat(
                distinct concat(
                            'avg(case when CountryName = ''', 
                            tempCountries.Name, 
                            ''' then Rating else null end) as `', 
                            tempCountries.Name, 
                            '`'
                        )           
            ) into @columns
        from tempCountries;
    else
        select 
            group_concat(
                distinct concat(
                            'avg(case when CountryName = ''', 
                            tempCountries.Name, 
                            ''' then Rating else null end) as `', 
                            tempCountries.Name, 
                            '`'
                        )                
            ) into @columns
        from tempCountries
        where tempCountries.Name in (select distinct CountryName from tempReviewData where Rating is not null);
    end if;

    select @columns;
    -- form a main query    
    set @sql = concat(
        'select 
            tp.Name as Product, 
            ', @columns, '
        from tempProducts tp
        left join tempReviewData trd on tp.Name = trd.ProductName
        group by tp.Name'
    );
    
    -- execute statement
    prepare stmt from @sql;
    execute stmt;
    deallocate prepare stmt;
    
    -- remove temporary tables
    drop temporary table if exists tempJson;
    drop temporary table if exists tempProducts;
    drop temporary table if exists tempCountries;
    drop temporary table if exists tempReviewData;

end$$
delimiter ;
