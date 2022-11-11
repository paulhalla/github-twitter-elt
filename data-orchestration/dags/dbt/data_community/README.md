# Helpful Queries 

- Find users with an incomplete tweet extraction

	```sql 
	with tokens as (
	    select 
		username,
		metadata['next_token'] as next_token
	    from airbyte_schema.stg_tweets
	),

	completed_users as (
	    select 
		distinct username
	    from tokens
	    where next_token is null

	)

	select * 
	from airbyte_schema.stg_tweets 
	where username not in (select username from completed_users)
	order by data['created_at'] asc;
	```

<br/>

- Normalise tweets and tweet engagement 

	```sql 
	-- tweet details
	select 
	    cast(data['id'] as varchar) as tweet_id,
	    username,
	    cast(data['text'] as varchar) as tweet,
	    cast(data['created_at'] as varchar) as tweet_created_at
	from public.raw_tweets_full
	limit 10;

	-- stg_tweet_engagement
	select 
	    cast(data['id'] as varchar) as tweet_id,
	    data['public_metrics']['like_count'] as number_of_likes,
	    data['public_metrics']['quote_count'] as number_of_quotes,
	    data['public_metrics']['reply_count'] as number_of_replies,
	    data['public_metrics']['retweet_count'] as number_of_retweets
	from public.raw_tweets_full
	limit 10;

	```

<br/>

# How to structure DBT projects
- https://docs.getdbt.com/guides/best-practices/how-we-structure/1-guide-overview
