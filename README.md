# Project plan 

## Objective

Our dataset shows trends for what is happening in the data community, in Twitter and Github.

## Consumers

The data would be useful for anyone that is interested in trends in the data space, including data practitioners and investors.

## Questions

Twitter data:
1. Keyword frequency analysis: How often do data practicioners mention cloud data warehouses and which ones? How often and since when do they mention data space trends such as "data mesh" and "data vault"?
2. Sentiment analysis with regard to data warehouse tools

Github data:
1. How much activity there is in each of the repositories (counted by, for example trendline for no. of commits in the repository)
2. What languages are mainly used in the each of the repos (Python vs. SQL vs. Java etc)
3. Top contributors in the repos?
4. Many contributors, few commits vs. few contributors, many commits?
5. Location of users etc.


## Source datasets
What datasets are you sourcing from? 

- Twitter dataset via Twitter API. We have extracted the tweets from various data influencers and people who are part of Data Twitter as it's sometimes called colloquially. The list of Twitter users was scraped from Twitter handles featured in the [Data Creators Club site](https://datacreators.club/) by [Mehdi Ouazza](https://github.com/mehd-io), to which other influencers active in the data space were added manually.
- Github repo activity dataset via official Airbyte Github source. The dataset includes the Github repos of 6 prominent open-source data orchestration tools: Airflow, Dagster, Prefect, Argo, Luigi and Orchesto.



## Solution architecutre
TBD

## Breakdown of tasks
How is your project broken down? Who is doing what?

Each of us has a primary responsibility based on the architecture component

Ingestion: Rashid  
Orchestration: Oliver  
Storage (incl. transformation, data quality tests): Paul

However, all 3 of us own the project, so we will jump in to help each other as we can.
