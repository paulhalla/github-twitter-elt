with raw_source as (

    select *
    from {{ source('github_argo', 'organizations_plan') }}

),

final as (

    select
        "_AIRBYTE_ORGANIZATIONS_HASHID"::VARCHAR as airbyte_organizations_hashid,
        "NAME"::VARCHAR as name,
        "SEATS"::NUMBER as seats,
        "SPACE"::NUMBER as space,
        "FILLED_SEATS"::NUMBER as filled_seats,
        "PRIVATE_REPOS"::NUMBER as private_repos,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PLAN_HASHID"::VARCHAR as airbyte_plan_hashid

    from raw_source

)

select * from final
