# Incremental Extraction of tweets from Twitter 

## Todos
1. Extract user and tweet data.
2. Set up an RDS to store the tweets.

	- The users will be stored in a `user` table
	- The tweets of the users will be stored in a `tweet` table 
	- The metrics of a tweet will be stored in a `tweet_metrics` table.
	- Tweet watermarks are stored in the `tweet_watermarks` table.

3. Create raw and serving schemas
4. Team members can then use airbyte to replicate the data in snowflake. 

