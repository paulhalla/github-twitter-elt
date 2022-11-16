with raw_source as (

    select *
    from {{ source('github_luigi', 'commits_commit_committer') }}

),

final as (

    select
        "_AIRBYTE_COMMIT_HASHID"::VARCHAR as airbyte_commit_hashid,
        "DATE"::TIMESTAMP_TZ as date,
        "NAME"::VARCHAR as name,
        "EMAIL"::VARCHAR as email,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_COMMITTER_HASHID"::VARCHAR as airbyte_committer_hashid

    from raw_source

)

select * from final
