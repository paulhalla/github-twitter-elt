with source_data as (
    select 
        username,
        data[0].created_at::varchar as tweet_created_at,
        data[0].edit_history_tweet_ids[0]::varchar as edit_history_tweet_ids,
        data[0].id::varchar as id,
        data[0].text::varchar as tweet,
        data[0].public_metrics:like_count::integer as number_of_likes,
        data[0].public_metrics:quote_count::integer as number_of_quotes,
        data[0].public_metrics:reply_count::integer as number_of_replies,
        data[0].public_metrics:retweet_count::integer as number_of_retweets
    from {{ source('public', 'raw_tweets_full') }}
)

select *
from source_data
