-- check products and characteristics
SELECT ProductID, Brand, Code, Name, MinAge, Active, CatalogID, EmployeeID, State, Price
FROM estore.product;

SELECT ProductID, CharacteristicsID, Value
FROM estore.productcharacteristicslink;

-- start testing - delete all products and related records

delete from estore.productpricehistory;
delete from estore.productstatehistory;
delete from estore.productwarehouselink;
delete from estore.productcharacteristicslink;
delete from estore.product;

-- add new products

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
            "Code": "M-0040",
            "Name": "Glazer",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "90"
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
            "Code": "I-0001",
            "Name": "5S",
            "MinAge": "21",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "100"
                },
                {
                    "Name": "Height",
                    "Value": "200"
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
            "Code": "I-0002",
            "Name": "X",
            "MinAge": "21",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "90"
                },
                {
                    "Name": "Height",
                    "Value": "170"
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
            "Brand": "Electronika",
            "Code": "HW-0001",
            "Name": "X",
            "MinAge": "18",
            "Characteristics": 
            [
                {
                    "Name": "Width",
                    "Value": "300"
                },
                {
                    "Name": "Height",
                    "Value": "400"
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
            "Brand": "Used Nokia",
            "Code": "U-0005",
            "Name": "Lumia",
            "MinAge": "18",
            "Characteristics": null                   
        },    
        "CatalogSection": {
            "Name": "Phones"
        }
    }'
)

-- add product state

call usp_SetProductState(N'
    {
        "Employee": {
            "Login": "bachtiyarovbb"
        },
        "Product": {
            "Code": "N-0002",
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
            "Code": "M-0040",
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
            "Code": "I-0001",
            "Brand": "Iphone",
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
            "Code": "I-0002",
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
            "Code": "HW-0001",
            "Brand": "Electronika",
            "State": "on demand",
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
            "Code": "U-0005",
            "Brand": "Used Nokia",
            "State": "in stock",
            "ChangeDate": "2024-06-04 12.22.00"
        }    
    }'
)

-- add product price

call usp_SetProductPrice(N'
    {
        "Employee": {
            "Login": "belyaevvi"
        },
        "Product": {
            "Code": "N-0002", 
            "Brand": "Nokia",
            "Price": "40",
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
            "Code": "M-0040", 
            "Brand": "Motorola",
            "Price": "45",
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
            "Code": "I-0001", 
            "Brand": "Iphone",
            "Price": "230",
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
            "Code": "I-0002", 
            "Brand": "Iphone",
            "Price": "470",
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
            "Code": "HW-0001", 
            "Brand": "Electronika",
            "Price": "23",
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
            "Code": "U-0005", 
            "Brand": "Used Nokia",
            "Price": "15",
            "ChangeDate": "2024-06-05 12.00.00"
        }    
    }'
)

-- set product quantity



