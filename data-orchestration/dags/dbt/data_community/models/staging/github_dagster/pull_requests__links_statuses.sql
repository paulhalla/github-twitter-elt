with raw_source as (

    select *
    from {{ source('github_dagster', 'pull_requests__links_statuses') }}

),

final as (

    select
        "_AIRBYTE__LINKS_HASHID"::VARCHAR as airbyte_links_hashid,
        "HREF"::VARCHAR as href,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_STATUSES_HASHID"::VARCHAR as airbyte_statuses_hashid

    from raw_source

)

select * from final
