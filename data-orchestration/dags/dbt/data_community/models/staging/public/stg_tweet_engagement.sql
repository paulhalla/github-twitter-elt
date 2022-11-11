with source as (
    select
        cast(data['id'] as varchar) as tweet_id,
        data['public_metrics']['like_count'] as number_of_likes,
        data['public_metrics']['quote_count'] as number_of_quotes,
        data['public_metrics']['reply_count'] as number_of_replies,
        data['public_metrics']['retweet_count'] as number_of_retweets
    from {{ source('public', 'raw_tweets_full') }}
)

select *
from source
