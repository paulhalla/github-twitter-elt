with top_liked_tweets as
(
    select
        username,
        tweet,
        max(number_of_likes)
    from
    {{ ref('stg_tweets') }}
    GROUP BY username) 

SELECT * FROM   top_liked_tweets