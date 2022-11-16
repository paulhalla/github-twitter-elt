with raw_source as (

    select *
    from {{ source('github_dagster', 'branches') }}

),

final as (

    select
        "NAME"::VARCHAR as name,
        "COMMIT"::VARIANT as commit,
        "PROTECTED"::BOOLEAN as protected,
        "PROTECTION"::VARIANT as protection,
        "REPOSITORY"::VARCHAR as repository,
        "PROTECTION_URL"::VARCHAR as protection_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_BRANCHES_HASHID"::VARCHAR as airbyte_branches_hashid

    from raw_source

)

select * from final
