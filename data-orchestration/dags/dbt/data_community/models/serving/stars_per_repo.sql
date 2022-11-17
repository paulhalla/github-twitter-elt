with stars_per_repo as (
    select 
        repository,
        count(user_id)
    from
        stg_stargazers
    group by repository
)

select * from stars_per_repo