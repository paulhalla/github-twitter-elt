{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_issues_milestone as (

    {% for schema in schema_names %}

    select
        "_AIRBYTE_ISSUES_HASHID"::VARCHAR as airbyte_issues_hashid,
        "ID"::NUMBER as id,
        -- "URL"::VARCHAR as url,
        "STATE"::VARCHAR as state,
        "TITLE"::VARCHAR as title,
        "DUE_ON"::TIMESTAMP_TZ as due_on,
        "NUMBER"::NUMBER as number,
        "CREATOR"::VARIANT as creator,
        -- "NODE_ID"::VARCHAR as node_id,
        -- "HTML_URL"::VARCHAR as html_url,
        "CLOSED_AT"::TIMESTAMP_TZ as closed_at,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        -- "LABELS_URL"::VARCHAR as labels_url,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "DESCRIPTION"::VARCHAR as description,
        "OPEN_ISSUES"::NUMBER as open_issues,
        "CLOSED_ISSUES"::NUMBER as closed_issues
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_MILESTONE_HASHID"::VARCHAR as airbyte_milestone_hashid

    from {{ source(schema|string, 'issues_milestone') }}

    {% if not loop.last %}

    union all

    {% endif %}
    {% endfor %}

)

select * from stg_issues_milestone
