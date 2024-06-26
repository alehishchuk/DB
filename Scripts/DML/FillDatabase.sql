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


call usp_CreateOrderStatus(N'
    [
        {
            "Name": "created"
        },
        {
            "Name": "confirmed"
        },
        {
            "Name": "collected"
        },
        {
            "Name": "ready for delivery"
        },
        {
            "Name": "issued"
        },
        {
            "Name": "returned"
        },
        {
            "Name": "cancelled"
        },
        {
            "Name": "completed"
        }
    ]'
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



call usp_RegistrationNewClient(N'
    {
        "Client": {
            "Name": "qwerty",
            "Login": "Client_3",
            "PasswordHash": "kjgwelkgjshrl",
            "PhoneNumber": "+843698573048756",
            "Email": "client3@gmail.com",
            "PurchaseLevel": "Gold",
            "BonusPoints": "456",
            "RegistrationDateTime": "2024-05-31 12.00.00",
            "LastAuthorizationDateTime": "2024-05-31 12.00.00"
        },
        "Country": {
            "Name": "Lybia"        
        }    
    }'
)


call usp_RegistrationNewClient(N'
    {
        "Client": {
            "Name": "qwerty",
            "Login": "Client_4",
            "PasswordHash": "kjsghdkjlg",
            "PhoneNumber": "+53986573548",
            "Email": "client4@gmail.com",
            "PurchaseLevel": "Gold",
            "BonusPoints": "888",
            "RegistrationDateTime": "2024-05-31 12.00.00",
            "LastAuthorizationDateTime": "2024-05-31 12.00.00"
        },
        "Country": {
            "Name": "Belarus"        
        }    
    }'
)


call usp_RegistrationNewClient(N'
    {
        "Client": {
            "Name": "qwerty",
            "Login": "Client_5",
            "PasswordHash": ".skjlgfga;sj;glsj",
            "PhoneNumber": "+3753985763087",
            "Email": "client5@gmail.com",
            "PurchaseLevel": "Gold",
            "BonusPoints": "666",
            "RegistrationDateTime": "2024-05-31 12.00.00",
            "LastAuthorizationDateTime": "2024-05-31 12.00.00"
        },
        "Country": {
            "Name": "China"        
        }    
    }'
)


call usp_RegistrationNewClient(N'
    {
        "Client": {
            "Name": "qwerty",
            "Login": "Client_6",
            "PasswordHash": "aklsdhfldfkjhg",
            "PhoneNumber": "+357689767",
            "Email": "client6@gmail.com",
            "PurchaseLevel": "Gold",
            "BonusPoints": "667",
            "RegistrationDateTime": "2024-05-31 12.00.00",
            "LastAuthorizationDateTime": "2024-05-31 12.00.00"
        },
        "Country": {
            "Name": "USA"        
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
            "Brand": "Motorola",
            "Code": "H40",
            "Name": "H",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Color",
                    "Value": "Gray"
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
            "Brand": "Home wire phone",
            "Code": "HW01",
            "Name": "Electronika",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Color",
                    "Value": "White"
                },
                {
                    "Name": "Volume",
                    "Value": "90"
                }
            ]           
        },    
        "CatalogSection": {
            "Name": "Old fashion phones"
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
            "Code": "I-0003",
            "Name": "11",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Color",
                    "Value": "White"
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
            "Code": "I-0004",
            "Name": "12",
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
            "Code": "I-0005",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "250"
                },
                {
                    "Name": "Height",
                    "Value": "350"
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
            "Brand": "Motorola",
            "Code": "M-0045",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Height",
                    "Value": "300"
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
            "Brand": "Motorola",
            "Code": "M-0048",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Height",
                    "Value": "300"
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
            "Brand": "Motorola",
            "Code": "M-0050",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Height",
                    "Value": "300"
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
            "Brand": "Nokia",
            "Code": "N-0005",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Height",
                    "Value": "300"
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
            "Brand": "Nokia",
            "Code": "N-0006",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "150"
                },
                {
                    "Name": "Height",
                    "Value": "300"
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
            "Brand": "Nokia",
            "Code": "N-0010",
            "Name": "13",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "200"
                },
                {
                    "Name": "Height",
                    "Value": "300"
                }
            ]           
        },    
        "CatalogSection": {
            "Name": "Cell phones"
        }
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "N-0010", 
            "Brand": "Nokia",
            "Price": "200",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "N-0006", 
            "Brand": "Nokia",
            "Price": "130",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "N-0005", 
            "Brand": "Nokia",
            "Price": "100",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "M-0050", 
            "Brand": "Motorola",
            "Price": "450",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "M-0048", 
            "Brand": "Motorola",
            "Price": "410",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "M-0045", 
            "Brand": "Motorola",
            "Price": "320",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "I-0005", 
            "Brand": "Iphone",
            "Price": "680",
            "ChangeDate": "2024-06-13 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "I-0004", 
            "Brand": "Iphone",
            "Price": "540",
            "ChangeDate": "2024-06-05 12.00.00"
        }    
    }'
)



call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "N-0002", 
            "Brand": "Nokia",
            "Price": "240",
            "ChangeDate": "2024-06-05 12.00.00"
        }    
    }'
)


call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "I-0003", 
            "Brand": "Iphone",
            "Price": "500",
            "ChangeDate": "2024-06-19 12.00.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "N-0010",
            "Brand": "Nokia",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "N-0006",
            "Brand": "Nokia",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "N-0005",
            "Brand": "Nokia",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "M-0050",
            "Brand": "Motorola",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "M-0048",
            "Brand": "Motorola",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)



call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "M-0045",
            "Brand": "Motorola",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "I-0005",
            "Brand": "Iphone",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)



call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "N-0002",
            "Brand": "Nokia",
            "State": "not available",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "I-0004",
            "Brand": "Iphone",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)


call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "I-0003",
            "Brand": "Iphone",
            "State": "in stock",
            "ChangeDate": "2024-06-18 12.22.00"
        }    
    }'
)



call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "I-0020",
            "Brand": "Iphone",
            "State": "not available",
            "ChangeDate": "2024-06-04 12.32.00"
        }    
    }'
)



call usp_EditProductDescription(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Brand": "Nokia",
            "Code": "N-0002"
        },
        "NewDescription": {
            "Name": "3200",
            "MinAge": "16",
            "Active": "1",
            "Characteristics": 
            [
                {
                    "Name": "Color",
                    "Value": "Red"
                },
                {
                    "Name": "Width",
                    "Value": "500"
                }
            ]     
        }    
    }'
)


call usp_SetProductQuantity(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "N-0002", 
            "Brand": "Nokia"
        },    
        "Warehouse": {
            "Name": "Central warehouse"        
        },
        "ProductQuantity": "24"    
    }'
)



call usp_SetProductQuantity(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "H40", 
            "Brand": "Motorola"
        },    
        "Warehouse": {
            "Name": "Warehouse Druzhba"        
        },
        "ProductQuantity": "100"    
    }'
)



call usp_AddProductToBasket(N'
    {
        "Client": {
            "Login": "Client_1"
        },
        "Product": {
            "Code": "N-0002",
            "Brand": "Nokia",
            "ProductQuantity": 5
        }        
    }'
)


call usp_RemoveProductFromBasket(N'
    {
        "Client": {
            "Login": "Client_1"
        },
        "Product": {
            "Code": "N-0002",
            "Brand": "Nokia"
        }
    }'
)


call usp_CreateOrder(N'
    {
        "Order": {
            "Code": "CP-0001",
            "CreatedDate": "2024-05-27 12.00.00",        
            "Status": "created",
            "ShelfLife": "2024-05-29 12.00.00",
            "VAT": 13
        },
        "Client": {
            "Login": "Client_1"
        },
        "Product": [
            {
                "Code": "I-0002",
                "Brand": "Iphone"
            },
            {
                "Code": "N-0002",
                "Brand": "Nokia"
            }
        ],
        "Warehouse": {
            "Name": "Central warehouse"
        },
        "PickUpPoint": {
            "Name": null
        }    
    }'
)


call usp_ChangeOrderStatus(N'
    {
        "Order": {
            "Code": "CP-0001",
            "Status": "created"
        },
        "NewStatus": "ready for delivery",
        "ChangeDateTime": "2024-05-20 12.00.00",
        "Employee": "belyaevvi"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_2"
        },
        "Product": {
            "Brand": "Nokia",
            "Code": "N-0002"
        },
        "Comment": "Nice product!",
        "Rating": 5,
        "ReviewDate": "2023-01-01"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_1"
        },
        "Product": {
            "Brand": "Nokia",
            "Code": "N-0002"
        },
        "Comment": "So-so!",
        "Rating": 3,
        "ReviewDate": "2024-06-18"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_3"
        },
        "Product": {
            "Brand": "Nokia",
            "Code": "N-0002"
        },
        "Comment": "Nice to have!",
        "Rating": 4,
        "ReviewDate": "2024-01-01"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_3"
        },
        "Product": {
            "Brand": "Iphone",
            "Code": "I-0002"
        },
        "Comment": "Super!",
        "Rating": 5,
        "ReviewDate": "2024-02-02"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_4"
        },
        "Product": {
            "Brand": "Iphone",
            "Code": "I-0002"
        },
        "Comment": "The worst one!",
        "Rating": 2,
        "ReviewDate": "2023-12-12"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_4"
        },
        "Product": {
            "Brand": "Motorola",
            "Code": "M-0040"
        },
        "Comment": "The worst one!",
        "Rating": 2,
        "ReviewDate": "2023-06-12"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_4"
        },
        "Product": {
            "Brand": "Electronika",
            "Code": "HW-0001"
        },
        "Comment": "The worst one!",
        "Rating": 2,
        "ReviewDate": "2023-05-10"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_5"
        },
        "Product": {
            "Brand": "Electronika",
            "Code": "HW-0001"
        },
        "Comment": "Ideal!",
        "Rating": 5,
        "ReviewDate": "2024-05-10"
    }'
)


call usp_AddProductReview(N'
    {
        "Client": {
            "Login": "Client_6"
        },
        "Product": {
            "Brand": "Iphone",
            "Code": "I-0001"
        },
        "Comment": "Cool",
        "Rating": 4,
        "ReviewDate": "2023-01-10"
    }'
)