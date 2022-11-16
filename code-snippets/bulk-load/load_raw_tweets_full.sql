use warehouse ETL;
use role accountadmin;
use database airbyte_database;

copy into airbyte_database.public.raw_tweets_full
 from (select 
    split_part(split_part(split_part(metadata$filename, '/', 3), '-', 0), '.json', 0),
    $1:data, 
    $1:meta
from @airbyte_database.public.twitter_data_stage);