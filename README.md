# README

##stocks

|--column                     |Type      |Options       |
|-----------------------------|----------|--------------|
|securities_code              |integer   |unique: true  |
|corp_name                    |string    |unique: true  |
|favorite                     |integer   |null: false   |          


##basicInformation

|--column                     |Type      |Options       |
|-----------------------------|----------|--------------|     
|market_capitalization        |float     |              |
|dividend_yield               |float     |              |
|stock_price                  |float     |              |
|overview                     |String    |              |
|stock_market                 |String    |              |
|url                          |String    |              |
|kind_of_industry             |String    |              |
|stock       |references|foreign_key: true, index: true|


##operatingIncome

|--column                    |Type      |Options       |
|----------------------------|----------|--------------|     
|next_fiscal_operating_income           |float |       |
|operating_income_for_this_fiscal_year  |float |       |
|privious_year_operating_income         |float |       |
|operating_income_two_fiscal_year_before|float |       |
|stock       |references|foreign_key: true, index: true|


##Sales

|--column                    |Type      |Options       |
|----------------------------|----------|--------------|     
|next_fiscal_sales               |float |              |
|sales_for_this_fiscal_year      |float |              |
|privious_year_sales             |float |              |
|sales_two_fiscal_year_before    |float |              |
|stock       |references|foreign_key: true, index: true|


|--column                    |Type      |Options       |
|----------------------------|----------|--------------|     
|per                         |float     |              |
|pbr                         |float     |              |


##variousIndex
|--column                    |Type      |Options       |
|----------------------------|----------|--------------|     
|roe                         |float     |              |
|roa                         |float     |              |
|stock       |references|foreign_key: true, index: true|
