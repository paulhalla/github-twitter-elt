with raw_source as (

    select *
    from {{ source('github_prefect', 'pull_requests__links_issue') }}

),

final as (

    select
        "_AIRBYTE__LINKS_HASHID"::VARCHAR as airbyte_links_hashid,
        "HREF"::VARCHAR as href,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_ISSUE_HASHID"::VARCHAR as airbyte_issue_hashid

    from raw_source

)

select * from final
