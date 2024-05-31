use eStore;

call usp_CreateCountries(N'
    {
        "Country": [
            {
                "Name": "Bulgaria"
            },
            {
                "Name": "Belarus"
            },
            {
                "Name": "Russia"
            },
            {
                "Name": "China"
            },
            {
                "Name": "Lybia"
            },
            {
                "Name": "USA"
            },
            {
                "Name": "Canada"
            },
            {
                "Name": "Zimbabwe"
            },
            {
                "Name": "Congo"
            }
        ]    
    }'
)


call usp_CreatePurchaseLevels(N'
    {
        "PurchaseLevel": [
            {
                "Name": "Tin"
            },
            {
                "Name": "Bronze"
            },
            {
                "Name": "Silver"
            },
            {
                "Name": "Gold"
            }
        ]    
    }'
)


call usp_RegistrationNewClient(N'
    {
        "Client": {
            "Name": "qwerty",
            "Login": "Client_1",
            "PasswordHash": "fjl87fgkor",
            "PhoneNumber": "+375296678745",
            "Email": "client1@gmail.com",
            "PurchaseLevel": "Silver",
            "BonusPoints": "1740",
            "RegistrationDateTime": "2024-05-27 12.00.00",
            "LastAuthorizationDateTime": "2024-05-27 12.00.00"
        },
        "Country": {
            "Name": "Bulgaria"        
        }    
    }'
)


call usp_RegistrationNewClient(N'
    {
        "Client": {
            "Name": "qwerty",
            "Login": "Client_2",
            "PasswordHash": "hjbjhblh",
            "PhoneNumber": "+275290080090",
            "Email": "client2@gmail.com",
            "PurchaseLevel": "Gold",
            "BonusPoints": "10000",
            "RegistrationDateTime": "2024-05-31 12.00.00",
            "LastAuthorizationDateTime": "2024-05-31 12.00.00"
        },
        "Country": {
            "Name": "Lybia"        
        }    
    }'
)