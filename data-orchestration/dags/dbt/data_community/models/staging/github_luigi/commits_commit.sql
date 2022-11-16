with raw_source as (

    select *
    from {{ source('github_luigi', 'commits_commit') }}

),

final as (

    select
        "_AIRBYTE_COMMITS_HASHID"::VARCHAR as airbyte_commits_hashid,
        "URL"::VARCHAR as url,
        "TREE"::VARIANT as tree,
        "AUTHOR"::VARIANT as author,
        "MESSAGE"::VARCHAR as message,
        "COMMITTER"::VARIANT as committer,
        "VERIFICATION"::VARIANT as verification,
        "COMMENT_COUNT"::NUMBER as comment_count,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_COMMIT_HASHID"::VARCHAR as airbyte_commit_hashid

    from raw_source

)

select * from final
