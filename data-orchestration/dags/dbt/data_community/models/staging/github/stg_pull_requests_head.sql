{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_pull_requests_head as (
    
    {% for schema in schema_names %}


    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        -- "REF"::VARCHAR as ref,
        -- "SHA"::VARCHAR as sha,
        "LABEL"::VARCHAR as label,
        "REPO_ID"::NUMBER as repo_id,
        "USER_ID"::NUMBER as user_id
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_HEAD_HASHID"::VARCHAR as airbyte_head_hashid

    from {{ source(schema|string, 'pull_requests_head') }}

    {% if not loop.last %}

    union all

    {% endif %}
    {% endfor %}

)

select * from stg_pull_requests_head
