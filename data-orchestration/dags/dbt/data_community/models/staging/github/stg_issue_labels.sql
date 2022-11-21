{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_issue_labels as (

    {% for schema in schema_names %}

    select
        "ID"::NUMBER as id,
        -- "URL"::VARCHAR as url,
        "NAME"::VARCHAR as name,
        -- "COLOR"::VARCHAR as color,
        -- "default"::BOOLEAN as default,
        -- "NODE_ID"::VARCHAR as node_id,
        "REPOSITORY"::VARCHAR as repository,
        "DESCRIPTION"::VARCHAR as description
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_ISSUE_LABELS_HASHID"::VARCHAR as airbyte_issue_labels_hashid

    from {{ source(schema|string, 'issue_labels') }}

    {% if not loop.last %}

    union all

    {% endif %}
    {% endfor %}

)

select * from stg_issue_labels
