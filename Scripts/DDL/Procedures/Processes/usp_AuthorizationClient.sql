use eStore;

drop procedure if exists usp_AuthorizationClient;

delimiter $$
create procedure usp_AuthorizationClient(in InJson json)
proc_body:
begin
    -- describe reaction on error
    declare exit handler for sqlexception
    begin
        get diagnostics @p1 = number;
        get diagnostics condition @p1 @p2 = message_text;
        select @p1, @p2;
    end;
    -- create temporary table for json data    
    drop table if exists tempJson;
    create temporary table tempJson
    (
        Login varchar(60)
    );
    -- insert data from json in tempJson table
    insert into tempJson (Login)
    select js.Login
    from JSON_TABLE(InJson, '$' columns 
                                (
                                   Login varchar(60) path N'$.Client.Login'
                                )
                   ) js;
     -- does client exist?
     if not exists (select Client.ClientID
                    from tempJson inner join 
                         Client on (tempJson.Login = Client.Login))
     then
        select 'Error: no such client.';
        leave proc_body;
     end if;
     -- no other operations required at this iteration of project
end$$
delimiter ;

