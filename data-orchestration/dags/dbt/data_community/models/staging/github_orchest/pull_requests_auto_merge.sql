with raw_source as (

    select *
    from {{ source('github_orchest', 'pull_requests_auto_merge') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        "ENABLED_BY"::VARIANT as enabled_by,
        "COMMIT_TITLE"::VARCHAR as commit_title,
        "MERGE_METHOD"::VARCHAR as merge_method,
        "COMMIT_MESSAGE"::VARCHAR as commit_message,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_AUTO_MERGE_HASHID"::VARCHAR as airbyte_auto_merge_hashid

    from raw_source

)

select * from final
