with raw_source as (

    select *
    from {{ source('github_luigi', 'stargazers_scd') }}

),

final as (

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "_AIRBYTE_UNIQUE_KEY_SCD"::VARCHAR as airbyte_unique_key_scd,
        "USER"::VARIANT as user,
        "USER_ID"::NUMBER as user_id,
        "REPOSITORY"::VARCHAR as repository,
        "STARRED_AT"::TIMESTAMP_TZ as starred_at,
        "_AIRBYTE_START_AT"::TIMESTAMP_TZ as airbyte_start_at,
        "_AIRBYTE_END_AT"::TIMESTAMP_TZ as airbyte_end_at,
        "_AIRBYTE_ACTIVE_ROW"::NUMBER as airbyte_active_row,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_STARGAZERS_HASHID"::VARCHAR as airbyte_stargazers_hashid

    from raw_source

)

select * from final
