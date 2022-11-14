with source as (
    select distinct
        split(file_name,'-')[0]::varchar as username,
        last_load_time::timestamp as last_load_time
    from table(information_schema.copy_history(
        table_name=>'public.raw_tweets_full', 
        start_time=> dateadd(day, -1, current_timestamp()))
    )
)

select * 
from source 