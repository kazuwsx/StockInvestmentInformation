# README

##stocks

|--column                     |Type      |Options       |
|-----------------------------|----------|--------------|
|securities_code              |integer   |unique: true  |
|corp_name                    |string    |unique: true  |            


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

|next_fiscal_operating_income    |float     |              |
|the_last_operating_income       |float     |              |
|the_second_last_operating_income|float     |              |
|the_third_last_operating_income |float     |              |
|the_fourth_last_operating_income|float     |              |
|stock       |references|foreign_key: true, index: true|


##termSales

|next_fiscal_term_sales          |float     |              |
|the_last_term_sales             |float     |              |
|the_second_last_term_sales      |float     |              |
|the_third_last_term_sales       |float     |              |
|the_fourth_last_term_sales      |float     |              |
|stock       |references|foreign_key: true, index: true|


##variousIndex
|--column                    |Type      |Options       |
|----------------------------|----------|--------------|     
|per                         |float     |              |
|pbr                         |float     |              |
|roe                         |float     |              |
|index_by_peter_lynch           |float     |              |
|mix_coefficient_by_benjamin_graham |float  |              |
|sales_growth_rate             |float     |              |
|operating_income_growth_rate   |float     |              |
|stock       |references|foreign_key: true, index: true|
