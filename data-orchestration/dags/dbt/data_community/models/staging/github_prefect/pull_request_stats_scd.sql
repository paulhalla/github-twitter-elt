with raw_source as (

    select *
    from {{ source('github_prefect', 'pull_request_stats_scd') }}

),

final as (

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "_AIRBYTE_UNIQUE_KEY_SCD"::VARCHAR as airbyte_unique_key_scd,
        "ID"::NUMBER as id,
        "MERGED"::BOOLEAN as merged,
        "NUMBER"::NUMBER as number,
        "COMMITS"::NUMBER as commits,
        "NODE_ID"::VARCHAR as node_id,
        "COMMENTS"::NUMBER as comments,
        "ADDITIONS"::NUMBER as additions,
        "DELETIONS"::NUMBER as deletions,
        "MERGEABLE"::VARCHAR as mergeable,
        "MERGED_BY"::VARIANT as merged_by,
        "REPOSITORY"::VARCHAR as repository,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "CHANGED_FILES"::NUMBER as changed_files,
        "CAN_BE_REBASED"::BOOLEAN as can_be_rebased,
        "REVIEW_COMMENTS"::NUMBER as review_comments,
        "MERGE_STATE_STATUS"::VARCHAR as merge_state_status,
        "MAINTAINER_CAN_MODIFY"::BOOLEAN as maintainer_can_modify,
        "_AIRBYTE_START_AT"::TIMESTAMP_TZ as airbyte_start_at,
        "_AIRBYTE_END_AT"::TIMESTAMP_TZ as airbyte_end_at,
        "_AIRBYTE_ACTIVE_ROW"::NUMBER as airbyte_active_row,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PULL_REQUEST_STATS_HASHID"::VARCHAR as airbyte_pull_request_stats_hashid

    from raw_source

)

select * from final
