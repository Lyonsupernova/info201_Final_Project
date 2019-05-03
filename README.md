# info 201 Final Project Brainstorm

## Topic: _**Housing**_

-------------
### Summary

*Why are you interested in this field/domain?*

> We are interested in housing because buying and renting a house is relative to everyone, especially in Seattle when housing and rental prices are extremely high (for broken college students who are trying to find a cheap rental price in Seattle.)

*What other examples of data driven project have you found related to this domain (share at least 3)?*

 >- The first project that I found is “Seattle House Price Predictions”. The dataset contains specified  information, including numbers of bathroom/bedroom, size, conditions and most importantly, the price. Then it combined all the information to predict the future price of Seattle houses.
https://www.kaggle.com/stephanedc/seattle-house-price-predictions/notebook

>- The second project is “US Housing Market Trends from Zillow Data”. The contributor used R to slice and dice the data provided by Zillow to better understand the trends of the housing market. And this project is aimed at finding the trend of sales and listing price to make better investment decision. https://rpubs.com/msmirabel/zillowdata

>- The third project is  “EDA of Ames house prices.” The contributor try to use the dataset to evaluate the prices of a house by taking many factors into consideration. The question she/she try to solve is the year that had the highest price house sold and  the factor that had the biggest impact on sale price.
https://www.kaggle.com/lsaa2014/eda-of-ames-house-prices

*What data-driven questions do you hope to answer about this domain (share at least 3)?*

>- How do crime rate, age, income level, race etc. affect housing in each area?
>- How does the house price change over time?
>- What the ratio between rental and selling in different area (near school, downtown, suburbs area)?
>- How the specification of the house affect the price of the house in Seattle area?
-------------
### Finding Data
#### 1.Median Household Income Data
- *Where did you download the data (e.g., a web URL)?*
> https://data.world/zillow-data/median-household-income
>
- *How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?*
> Zillow is in the process of transitioning some data sources with the goal of producing published data. Zillow receives information about property sales from the municipal office responsible for recording real estate transactions in different area. The information Zillow provide is public information, gathered from county records. The data is about the household affordability which Zillow uses its own index to estimate the affordability index.
>
- *How many observations (rows) are in your data?*
> 917
>
- *How many features (columns) are in the data?*
>  157
>
- *What questions (from above) can be answered using the data in this dataset?*
> The affordability estimated by Zillow's affordability index indicates the income level of householder. This datasets vary regionally which is helpful to answer the second question.

#### 2.Washington State HDMA Data
- *Where did you download the data (e.g., a web URL)?*
> https://www.kaggle.com/miker400/washington-state-home-mortgage-hdma2016/version/1
>
- *How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?*
> The Home Mortgage Disclosure Act (HMDA) requires many financial institutions to maintain, report, and publicly disclose information about mortgages. These public data are important because they help show whether lenders are serving the housing needs of their communities; they give public officials information that helps them make decisions and policies; and they shed light on lending patterns that could be discriminatory.
>
- *How many observations (rows) are in your data?*
> 466567
>
- *How many features (columns) are in the data?*
> 47
>
- *What questions (from above) can be answered using the data in this dataset?*
> The dataset provide variety of information about home loans such as demographic information, area specific data, loan status, property type, loan type, loan purpose and originating agency. According to those information we can analysis what is the race, age, income of the people who bought house in Washington state, which can answer question 1 from above

#### 3.House Sales in King County
- *Where did you download the data (e.g., a web URL)?*
> https://www.kaggle.com/harlfoxem/housesalesprediction
>
- *How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?*
> This datasets contains the house sale prices for King County between May 2014 to May 2015. It includes 19 house features as well as the price and id columns. It is generated by Harlfoxem from public record.
>
- *How many observations (rows) are in your data?*
> 21613
>
- *How many features (columns) are in the data?*
>  19
>
- *What questions (from above) can be answered using the data in this dataset?*
> The data includes a variety of features related to property details. It answers the question about how numbers of bedrooms, sqft, build years etc affect housing price in King county.
