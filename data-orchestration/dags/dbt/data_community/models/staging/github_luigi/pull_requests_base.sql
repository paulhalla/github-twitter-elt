with raw_source as (

    select *
    from {{ source('github_luigi', 'pull_requests_base') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        "REF"::VARCHAR as ref,
        "SHA"::VARCHAR as sha,
        "LABEL"::VARCHAR as label,
        "REPO_ID"::NUMBER as repo_id,
        "USER_ID"::NUMBER as user_id,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_BASE_HASHID"::VARCHAR as airbyte_base_hashid

    from raw_source

)

select * from final
