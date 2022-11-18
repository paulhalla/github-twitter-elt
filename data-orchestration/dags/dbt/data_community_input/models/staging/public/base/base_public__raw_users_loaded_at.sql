with loaded_at as (
    select * 
    from table(information_schema.copy_history(
        table_name => 'public.raw_twitter_users',
        start_time => dateadd(month, -1, current_timestamp())
    ))
),

most_recent_load as (
    select *,
        last_value(last_load_time) over (
            partition by file_name
            order by last_load_time asc
            rows between unbounded preceding
            and unbounded following 
        ) as most_recent_date
    from loaded_at
),

most_recent_record as (
    select *
    from most_recent_load
    where last_load_time = most_recent_date
)
select 
    lower(split(file_name, '.json')[0]::varchar) as username,
    last_load_time
from most_recent_record
order by file_name