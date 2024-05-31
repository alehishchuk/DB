use eStore;

drop procedure if exists usp_RegistrationNewClient;

delimiter $$
create procedure usp_RegistrationNewClient(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;    
    -- create new client
    insert into Client (Name, Login, PasswordHash, PhoneNumber, Email, PurchaseLevelID, BonusPoints, RegistrationDateTime, LastAuthorizationDateTime, CountryID)
    with cte_JsonData(Name, Login, PasswordHash, PhoneNumber, Email, PurchaseLevel, BonusPoints, RegistrationDateTime, LastAuthorizationDateTime, Country) as 
    (
        select js.Name,
               js.Login,
               js.PasswordHash,
               js.PhoneNumber,
               js.Email,
               js.PurchaseLevel,
               js.BonusPoints,
               js.RegistrationDateTime,
               js.LastAuthorizationDateTime,
               js.Country
        from JSON_TABLE(InJson, '$' columns
            (
                                Name                        varchar(120)        path N'$.Client.Name',
                                Login                       varchar(60)         path N'$.Client.Login',
                                PasswordHash                char(32)            path N'$.Client.PasswordHash',
                                PhoneNumber                 varchar(20)         path N'$.Client.PhoneNumber',
                                Email                       varchar(50)         path N'$.Client.Email',
                                PurchaseLevel               varchar(10)         path N'$.Client.PurchaseLevel',
                                BonusPoints                 smallint            path N'$.Client.BonusPoints',
                                RegistrationDateTime        datetime            path N'$.Client.RegistrationDateTime',
                                LastAuthorizationDateTime   datetime            path N'$.Client.LastAuthorizationDateTime',
                                Country                     varchar(50)         path N'$.Country.Name'
            )
        )js
    )
    select cte_JsonData.Name,
           cte_JsonData.Login,
           cte_JsonData.PasswordHash,
           cte_JsonData.PhoneNumber,
           cte_JsonData.Email,
           PurchaseLevel.PurchaseLevelID,
           cte_JsonData.BonusPoints,
           cte_JsonData.RegistrationDateTime,
           cte_JsonData.LastAuthorizationDateTime,
           Country.CountryID
    from cte_JsonData
    inner join PurchaseLevel on (cte_JsonData.PurchaseLevel = PurchaseLevel.`Name`)
    inner join Country on (cte_JsonData.Country = Country.`Name`);

end$$
delimiter ;
