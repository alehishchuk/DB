call usp_ViewProductRatingByCountriesAvg(N'
    {
        "Countries": [
            {
                "Name": "Belarus"
            },
            {
                "Name": "USA"
            },
            {
                "Name": "China"
            },
            {
                "Name": "Bulgaria"
            },
            {
                "Name": "Canada"
            },
            {
                "Name": "Congo"
            },
            {
                "Name": "Lybia"
            },
            {
                "Name": "Russia"
            },
            {
                "Name": "Zimbabwe"
            }
        ],
        "Products": [
            {
                "Brand": "Iphone",
                "Code": "I-0002"
            },
            {
                "Brand": "Motorola",
                "Code": "M-0040"
            },
            {
                "Brand": "Iphone",
                "Code": "I-0001"
            },
            {
                "Brand": "Nokia",
                "Code": "N-0002"
            },
            {
                "Brand": "Electronika",
                "Code": "HW-0001"
            },
            {
                "Brand": "Used Nokia",
                "Code": "U-0005"
            }
        ],
        "Period" : {
            "StartDate": "2023-01-01",
            "FinishDate": "2024-06-18"
        },
        "ShowNullCols": 1,
        "ShowNullRows": 1
    }'
)



call usp_ViewProductRatingByCountriesAvg(N'
    {
        "Countries": [
            {
                "Name": "Belarus"
            },
            {
                "Name": "USA"
            },
            {
                "Name": "China"
            },
            {
                "Name": "Bulgaria"
            },
            {
                "Name": "Canada"
            },
            {
                "Name": "Congo"
            },
            {
                "Name": "Lybia"
            },
            {
                "Name": "Russia"
            },
            {
                "Name": "Zimbabwe"
            }
        ],
        "Products": [
            {
                "Brand": "Iphone",
                "Code": "I-0002"
            },
            {
                "Brand": "Motorola",
                "Code": "M-0040"
            },
            {
                "Brand": "Iphone",
                "Code": "I-0001"
            },
            {
                "Brand": "Nokia",
                "Code": "N-0002"
            },
            {
                "Brand": "Electronika",
                "Code": "HW-0001"
            },
            {
                "Brand": "Used Nokia",
                "Code": "U-0005"
            }
        ],
        "Period" : {
            "StartDate": "2024-01-01",
            "FinishDate": "2024-06-18"
        },
        "ShowNullCols": 1,
        "ShowNullRows": 1
    }'
)