with raw_source as (

    select *
    from {{ source('github_luigi', 'stargazers') }}

),

final as (

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "USER"::VARIANT as user,
        "USER_ID"::NUMBER as user_id,
        "REPOSITORY"::VARCHAR as repository,
        "STARRED_AT"::TIMESTAMP_TZ as starred_at,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_STARGAZERS_HASHID"::VARCHAR as airbyte_stargazers_hashid

    from raw_source

)

select * from final
