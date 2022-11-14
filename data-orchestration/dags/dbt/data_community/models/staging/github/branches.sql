{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_branches as (
    
    {% for schema in schema_names %}
        select 
            "NAME"::VARCHAR as name,
            "COMMIT"::VARIANT as commit,
            "PROTECTED"::BOOLEAN as protected,
            -- "PROTECTION"::VARIANT as protection, -- unnecessary column
            "REPOSITORY"::VARCHAR as repository
            -- "PROTECTION_URL"::VARCHAR as protection_url, -- unnecessary column
            -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,  -- unnecessary column
            -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,  -- unnecessary column
            -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,  -- unnecessary column
            -- "_AIRBYTE_BRANCHES_HASHID"::VARCHAR as airbyte_branches_hashid  -- unnecessary column
        from {{ schema }}.branches
        {% if not loop.last %}
            union all
        {% endif %}
    {% endfor %}
)

select * from stg_branches

