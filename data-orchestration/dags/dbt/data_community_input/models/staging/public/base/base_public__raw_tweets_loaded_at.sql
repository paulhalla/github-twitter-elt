with loaded_at as (
    select * 
    from table(information_schema.copy_history(
        table_name => 'public.raw_tweets_full',
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
),

first_val as (
    select 
        regexp_replace(split(file_name,'-')[0]::varchar, '.json', '') as username,
        last_load_time
    from most_recent_record
    qualify row_number() over (partition by username order by last_load_time) = 1
)

select * from first_val