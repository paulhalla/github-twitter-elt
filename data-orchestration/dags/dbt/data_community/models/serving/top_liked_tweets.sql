select 
    username,
    text,
    number_of_likes
from airbyte_database.model.stg_tweets
qualify row_number() over(partition by username order by number_of_likes desc) = 1;