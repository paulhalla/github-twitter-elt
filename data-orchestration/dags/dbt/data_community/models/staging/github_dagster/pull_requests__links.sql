with raw_source as (

    select *
    from {{ source('github_dagster', 'pull_requests__links') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        "HTML"::VARIANT as html,
        "SELF"::VARIANT as self,
        "issue"::VARIANT as issue,
        "COMMITS"::VARIANT as commits,
        "COMMENTS"::VARIANT as comments,
        "STATUSES"::VARIANT as statuses,
        "REVIEW_COMMENT"::VARIANT as review_comment,
        "REVIEW_COMMENTS"::VARIANT as review_comments,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE__LINKS_HASHID"::VARCHAR as airbyte_links_hashid

    from raw_source

)

select * from final
