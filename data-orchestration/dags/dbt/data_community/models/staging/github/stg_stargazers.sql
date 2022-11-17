{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_stargazers as (
    
    {% for schema in schema_names %}

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "USER"::VARIANT as user,
        "USER_ID"::NUMBER as user_id,
        "REPOSITORY"::VARCHAR as repository,
        "STARRED_AT"::TIMESTAMP_TZ as starred_at
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_STARGAZERS_HASHID"::VARCHAR as airbyte_stargazers_hashid

    from {{ source(schema|string, 'stargazers') }}


    {% if not loop.last %}

    union all
    {% endif %}
    {% endfor %}
)

select * from stg_stargazers
