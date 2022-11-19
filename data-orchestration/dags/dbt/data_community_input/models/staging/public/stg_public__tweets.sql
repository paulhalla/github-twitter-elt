with load_times as (
    select * 
    from {{ ref('base_public__raw_tweets_loaded_at') }}
),

raw_tweets as (
    select *
    from {{ ref('base_public__raw_tweets') }}
),

transformed as (
    select 
        raw_tweets.username,
        tweet_created_at,
        edit_history_tweet_ids,
        id,
        tweet,
        number_of_likes,
        number_of_quotes,
        number_of_replies,
        number_of_retweets,
        coalesce(load_times.last_load_time, current_timestamp())::timestamp as last_load_time
    from raw_tweets
    left join load_times 
        on raw_tweets.username = load_times.username
)

select * from transformed
