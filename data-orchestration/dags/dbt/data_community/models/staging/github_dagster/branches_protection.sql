with raw_source as (

    select *
    from {{ source('github_dagster', 'branches_protection') }}

),

final as (

    select
        "_AIRBYTE_BRANCHES_HASHID"::VARCHAR as airbyte_branches_hashid,
        "REQUIRED_STATUS_CHECKS"::VARIANT as required_status_checks,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PROTECTION_HASHID"::VARCHAR as airbyte_protection_hashid

    from raw_source

)

select * from final
