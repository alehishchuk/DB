call usp_ViewProducts(N'
    {
        "CatalogSection": "Cell phones",
        "Brands": ["Nokia", "Motorola"],
        "State": "in stock",
        "CharValueRanges": [
            {
                "CharacteristicName": "Width",
                "Min": 20,
                "Max": 100
            },
            {
                "CharacteristicName": "Height",
                "Min": 200,
                "Max": 150
            }
        ],
        "SortingMode": 1,
        "Offset": 0,
        "Limit": 10
    }'
)


call usp_ViewProducts(N'
    {
        "CatalogSection": "Cell phones",
        "Brands": ["Nokia", "Motorola", "Iphone"],
        "State": "in stock",
        "CharValueRanges": [
            {
                "CharacteristicName": "Width",
                "Min": 20,
                "Max": 100
            },
            {
                "CharacteristicName": "Height",
                "Min": 200,
                "Max": 150
            }
        ],
        "SortingMode": 1,
        "Offset": 0,
        "Limit": 10
    }'
)