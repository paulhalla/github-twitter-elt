{{ config(materialized='table') }}

with transformed as (
    select 
        username,
        to_date(tweet_created_at::timestamp) as tweet_date,
        edit_history_tweet_ids,
        id,
        tweet,
        number_of_likes,
        number_of_quotes,
        number_of_replies,
        number_of_retweets
    from {{ source('public', 'input_tweets') }}
)

select * from transformed
