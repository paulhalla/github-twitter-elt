with tweets as (
    select * 
    from {{ ref('stg_tweets') }}
),

users as (
    select * 
    from {{ ref('stg_users') }}
),

joined as (
    select 
        user_id,
        users.user_full_name,
        user_description,
        users.created_at as user_joined_at,
        tweets.username,
        tweet_created_at,
        edit_history_tweet_ids,
        id,
        tweet,
        number_of_likes,
        number_of_followers,
        number_of_quotes,
        number_of_replies,
        number_of_retweets,
        number_of_following,
        number_of_tweets,
        number_of_twitter_lists,
        pinned_tweet_id,
        tweets.last_load_time
    from tweets 
    left join users 
        on tweets.username = users.username
),

deduped as (
    select *
    from joined 
    qualify row_number() over (partition by id order by id) = 1
)

select * from deduped