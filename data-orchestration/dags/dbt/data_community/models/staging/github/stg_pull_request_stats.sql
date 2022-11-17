{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_pull_request_stats as (
    
    {% for schema in schema_names %}

    select
        "ID"::NUMBER as id,
        "MERGED"::BOOLEAN as merged,
        "NUMBER"::NUMBER as number,
        "COMMITS"::NUMBER as commits,
        -- "NODE_ID"::VARCHAR as node_id,
        "COMMENTS"::NUMBER as comments,
        "ADDITIONS"::NUMBER as additions,
        "DELETIONS"::NUMBER as deletions,
        "MERGEABLE"::VARCHAR as mergeable,
        "MERGED_BY"::VARIANT as merged_by,
        "REPOSITORY"::VARCHAR as repository,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "CHANGED_FILES"::NUMBER as changed_files,
        -- "CAN_BE_REBASED"::BOOLEAN as can_be_rebased,
        "REVIEW_COMMENTS"::NUMBER as review_comments,
        "MERGE_STATE_STATUS"::VARCHAR as merge_state_status
        -- "MAINTAINER_CAN_MODIFY"::BOOLEAN as maintainer_can_modify,
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_PULL_REQUEST_STATS_HASHID"::VARCHAR as airbyte_pull_request_stats_hashid

    from {{ source(schema|string, 'pull_request_stats') }}

    {% if not loop.last %}

    union all

    {% endif %}
    {% endfor %}

)

select * from stg_pull_request_stats
