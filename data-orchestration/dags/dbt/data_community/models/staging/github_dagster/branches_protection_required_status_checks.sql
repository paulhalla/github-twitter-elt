with raw_source as (

    select *
    from {{ source('github_dagster', 'branches_protection_required_status_checks') }}

),

final as (

    select
        "_AIRBYTE_PROTECTION_HASHID"::VARCHAR as airbyte_protection_hashid,
        "CONTEXTS"::VARIANT as contexts,
        "ENFORCEMENT_LEVEL"::VARCHAR as enforcement_level,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_REQUIRED_STATUS_CHECKS_HASHID"::VARCHAR as airbyte_required_status_checks_hashid

    from raw_source

)

select * from final
