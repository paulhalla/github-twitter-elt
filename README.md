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

  

---  

<br>
SQL code for ingesting JSON data from S3 bucket into Snowflake tables   

<br>

1. Create tables for tweet and twitter user data 

```sql
create or replace table raw_tweets_full(
    username varchar(16777216),
    data variant,
    metadata variant
);
```

```sql
create or replace table raw_twitter_users(
    username varchar(16777216),
    name varchar(16777216),
    id integer, 
    public_metrics variant,
    pinned_tweet_id integer,
    description varchar(16777216),
    created_at timestamp_ntz,
    verified varchar(16777216)
);
```
<br>

2. Create the stage integration

```sql
create or replace storage integration twitter_integration
    type = external_stage
    storage_provider = S3
    enabled = TRUE
    storage_aws_role_arn = '[role value here]'
    storage_allowed_locations = ('*');
```    
<br>

3. Create stages using the storage integration

```sql
create or replace stage airbyte_database.public.twitter_data_stage
    url = '[tweets json files S3 URI here]'
    storage_integration = TWITTER_INTEGRATION
    file_format = (type = JSON);
```


```sql
create or replace stage airbyte_database.public.twitter_users_stage
    url = '[twitter users json files S3 URI here]'
    storage_integration = TWITTER_INTEGRATION
    file_format = (type = JSON);
```
<br>

4. Copy data from stages into target tables

```sql
 copy into airbyte_database.public.raw_tweets_full
 from (select 
    split_part(split_part(split_part(metadata$filename, '/', 3), '-', 0), '.json', 0),
    $1:data, 
    $1:meta
from @airbyte_database.public.twitter_data_stage);
```

```sql
  copy into airbyte_database.public.raw_twitter_users
 from (
     select 
        $1:data[0].username,
        $1:data[0].name,
        $1:data[0].id,
        $1:data[0].public_metrics,
        $1:data[0].pinned_tweet_id,
        $1:data[0].description,
        $1:data[0].created_at,
        $1:data[0].verified
    from @airbyte_database.public.twitter_users_stage);
```