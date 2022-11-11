-- top tweets per user

with top_liked_tweets as (
    select
        username,
        tweet,
        max(number_of_likes)
    from {{ ref('stg_tweets') }}
    group by username
)

select *
from top_liked_tweets
