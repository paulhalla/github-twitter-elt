with raw_source as (

    select *
    from {{ source('github_orchest', 'pull_request_commits_commit_author') }}

),

final as (

    select
        "_AIRBYTE_COMMIT_HASHID"::VARCHAR as airbyte_commit_hashid,
        "DATE"::VARCHAR as date,
        "NAME"::VARCHAR as name,
        "EMAIL"::VARCHAR as email,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_AUTHOR_HASHID"::VARCHAR as airbyte_author_hashid

    from raw_source

)

select * from final
