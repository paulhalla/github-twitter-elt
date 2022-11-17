with source as (
      select * from {{ source('github_airflow', 'branches_protection') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  