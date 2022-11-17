{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_commits as (

    {% for schema in schema_names %}
    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        -- "SHA"::VARCHAR as sha,
        -- "URL"::VARCHAR as url,
        "AUTHOR"::VARIANT as author,
        "COMMIT"::VARIANT as commit,
        -- "NODE_ID"::VARCHAR as node_id,  -- unnecessary column
        -- "PARENTS"::VARIANT as parents,  -- unnecessary column
        -- "HTML_URL"::VARCHAR as html_url,  -- unnecessary column
        "COMMITTER"::VARIANT as committer,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "REPOSITORY"::VARCHAR as repository
        -- "COMMENTS_URL"::VARCHAR as comments_url,  -- unnecessary column
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,  -- unnecessary column
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,  -- unnecessary column
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,  -- unnecessary column
        -- "_AIRBYTE_COMMITS_HASHID"::VARCHAR as airbyte_commits_hashid  -- unnecessary column

    from {{ source(schema|string, 'commits') }}


    {% if not loop.last %}

    union all
    {% endif %}
    {% endfor %}

)

select * from stg_commits
