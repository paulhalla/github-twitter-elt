{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_pull_requests_labels as (
    
    {% for schema in schema_names %}


    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        "ID"::NUMBER as id,
        -- "URL"::VARCHAR as url,
        "NAME"::VARCHAR as name,
        -- "COLOR"::VARCHAR as color,
        -- "default"::BOOLEAN as default,
        -- "NODE_ID"::VARCHAR as node_id,
        "DESCRIPTION"::VARCHAR as description
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_LABELS_HASHID"::VARCHAR as airbyte_labels_hashid

    from {{ source(schema|string, 'pull_requests_labels') }}

    {% if not loop.last %}

    union all

    {% endif %}
    {% endfor %}

)

select * from stg_pull_requests_labels
