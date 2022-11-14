with top_liked_tweets as (
select 
    username,
    tweet,
    number_of_likes
from {{ ref('stg_tweets') }}
qualify row_number() over(partition by username order by number_of_likes desc) = 1
),

top_quoted_tweets as (
select 
    username,
    tweet,
    number_of_quotes
from {{ ref('stg_tweets') }}
qualify row_number() over(partition by username order by number_of_quotes desc) = 1
),

top_replied_tweets as (
select 
    username,
    tweet,
    number_of_replies
from {{ ref('stg_tweets') }}
qualify row_number() over(partition by username order by number_of_replies desc) = 1
),

top_retweeted_tweets as (
select 
    username,
    tweet,
    number_of_retweets
from {{ ref('stg_tweets') }}
qualify row_number() over(partition by username order by number_of_retweets desc) = 1
),

transformed as
(select 
    top_liked_tweets.username,
    top_liked_tweets.tweet as most_liked_tweet,
    top_liked_tweets.number_of_likes,
    top_quoted_tweets.tweet as most_quoted_tweet,
    top_quoted_tweets.number_of_quotes,
    top_replied_tweets.tweet as most_replied_tweet,
    top_replied_tweets.number_of_replies,
    top_retweeted_tweets.tweet as most_retweeted_tweet,
    top_retweeted_tweets.number_of_retweets
    from top_liked_tweets
    left join top_quoted_tweets
    on top_liked_tweets.username = top_quoted_tweets.username
    left join top_replied_tweets 
    on top_liked_tweets.username = top_replied_tweets.username
    left join top_retweeted_tweets 
    on top_liked_tweets.username = top_retweeted_tweets.username
    
 ) 


select * 
from transformed