use eStore;

-- Initialization

call usp_CreateSystemRoles(N'
    {
        "SystemRole": [
            {
                "Name": "director"
            },
            {
                "Name": "manager"
            },
            {
                "Name": "warehouse worker"
            },
            {
                "Name": "pick-up point worker"
            }
        ]
    }'
);


call usp_CreateJobPositions(N'
    [
        {
            "Name": "директор"
        },
        {
            "Name": "бухгалтер"
        },
        {
            "Name": "начальник отдела"
        },
        {
            "Name": "менеджер по продажам"
        },
        {
            "Name": "контент-менеджер"
        },
        {
            "Name": "оператор склада"
        },
        {
            "Name": "специалист"
        }
    ]'
);


call usp_CreateNewAdministrator(N'
    {
        "Administrator": {
            "Login": "sysadmin",
            "PasswordHashMD5": "2fbc9a5d512ecaa00507bf9113960f37"
        }
    }'
);


call usp_AuthorizationAdministrator(N'
    {
        "Guest": {
            "IP": "160.137.93.63",
            "SessionDateTime": "2023-01-02 10:00:00.000",    
            "UserAgent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0"
        },
        "Administrator": {
            "Login": "sysadmin"
        },
        "PasswordHashMD5": "2fbc9a5d512ecaa00507bf9113960f37",
        "ProcessStartDateTime": "2023-01-02 10:10:00.000"
    }'
);


call usp_CreateNewEmployee(N'
    {
        "Administrator": {
            "Login": "sysadmin"
        },
        "Employee": {
            "Login": "belyaevvi", 
            "PasswordHashMD5": "fe0233e68fa48b1496269e6f14ae00d7",
            "FullName": "Беляев Вадим Игоревич",
            "PhoneNumber": "+375(29)6660001",
            "JobPosition": "директор",
            "ContractExpirationDate": "2025-01-25",
            "SystemRole": "director"
        },
        "ProcessStartDateTime": "2023-01-02 11:00:00.000"
    }'
);



call usp_CreateNewEmployee(N'
    {
        "Administrator": {
            "Login": "sysadmin"
        },
        "Employee": {
            "Login": "bachtiyarovbb", 
            "PasswordHashMD5": "fe0233e68f00005555889e6f14ae00d7",
            "FullName": "Бахтияр Бахтиярович Бахтияров",
            "PhoneNumber": "+375(29)7770002",
            "JobPosition": "менеджер по продажам",
            "ContractExpirationDate": "2025-01-25",
            "SystemRole": "manager"
        },
        "ProcessStartDateTime": "2023-01-02 11:00:00.000"
    }'
);



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



call usp_CreateProductStates(N'
    {
        "ProductState": [
            {
                "Name": "not available"
            },
            {
                "Name": "in stock"
            },
            {
                "Name": "on demand"
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



call usp_CreateWarehouse(N'
    {
        "Warehouse": {
            "Name": "Central warehouse",
            "Address": "Bulgaria, Sofia, Center",
            "WorkingHours": "10.00 - 22.00"
        }
    }'
)


call usp_CreateWarehouse(N'
    {
        "Warehouse": {
            "Name": "Warehouse Druzhba",
            "Address": "Bulgaria, Sofia, Druzhba",
            "WorkingHours": "10.00 - 23.00"
        }
    }'
)


call usp_CreateWarehouse(N'
    {
        "Warehouse": {
            "Name": "Warehouse Plovdiv",
            "Address": "Bulgaria, Plovdiv, Center",
            "WorkingHours": "10.00 - 22.00"
        }
    }'
)


call usp_CreatePickUpPoint(N'
    {
        "PickUpPoint": {
            "Name": "Point Druzhba 1",
            "Address": "Bulgaria, Sofia, Druzhba 1",
            "WorkingHours": "10.00 - 22.00"
        }
    }'
)


call usp_CreatePickUpPoint(N'
    {
        "PickUpPoint": {
            "Name": "Point Druzhba 2",
            "Address": "Bulgaria, Sofia, Druzhba 2",
            "WorkingHours": "10.00 - 21.00"
        }
    }'
)


call usp_CreatePickUpPoint(N'
    {
        "PickUpPoint": {
            "Name": "Point Plovdiv",
            "Address": "Bulgaria, Plovdiv, Center",
            "WorkingHours": "10.00 - 19.00"
        }
    }'
)



call usp_AuthorizationClient(N'
    {
        "Guest": {
            "IP": "201.75.254.40",
            "SessionDateTime": "2024-01-20 12:00:00.000",    
            "UserAgent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0"
        },
        "Client": {
            "Login": "Client_1"
        },    
        "PasswordHashMD5": "2fbc9a5d512ecaa00507bf9113960f37",
        "ProcessStartDateTime": "2023-01-20 10:10:00.000"
    }'
)



call usp_CreateCatalogSection(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Catalog": {
            "Name": "Phones"        
        },
        "ParentCatalog": {
            "Name": null
        }    
    }'
)


call usp_CreateCatalogSection(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Catalog": {
            "Name": "Cell phones"        
        },
        "ParentCatalog": {
            "Name": "Phones"
        }    
    }'
)


call usp_CreateCatalogSection(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Catalog": {
            "Name": "Old fashion phones"        
        },
        "ParentCatalog": {
            "Name": "Phones"
        }    
    }'
)



call usp_CreateProductCharacteristics(N'
    {
        "Characteristics": [
            {
                "Name": "Height"
            },
            {
                "Name": "Width"
            },
            {
                "Name": "Color"
            },
            {
                "Name": "Volume"
            },
            {
                "Name": "Impact resistance"
            }
        ]
    }'
)



call usp_AddProductDescription(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Brand": "Nokia",
            "Code": "N-0002",
            "Name": "3200",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Height",
                    "Value": "250"
                }
            ]           
        },    
        "CatalogSection": {
            "Name": "Cell phones"
        }
    }'
)



call usp_AddProductDescription(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Brand": "Iphone",
            "Code": "I-0020",
            "Name": "5S",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Color",
                    "Value": "Black"
                }
            ]           
        },    
        "CatalogSection": {
            "Name": "Cell phones"
        }
    }'
)