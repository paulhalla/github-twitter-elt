with raw_source as (

    select *
    from {{ source('github_airflow', 'pull_request_commits_commit_verification') }}

),

final as (

    select
        "_AIRBYTE_COMMIT_HASHID"::VARCHAR as airbyte_commit_hashid,
        "REASON"::VARCHAR as reason,
        "PAYLOAD"::VARCHAR as payload,
        "VERIFIED"::BOOLEAN as verified,
        "SIGNATURE"::VARCHAR as signature,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_VERIFICATION_HASHID"::VARCHAR as airbyte_verification_hashid

    from raw_source

)

select * from final
