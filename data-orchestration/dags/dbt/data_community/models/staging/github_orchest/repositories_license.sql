with raw_source as (

    select *
    from {{ source('github_orchest', 'repositories_license') }}

),

final as (

    select
        "_AIRBYTE_REPOSITORIES_HASHID"::VARCHAR as airbyte_repositories_hashid,
        "KEY"::VARCHAR as key,
        "URL"::VARCHAR as url,
        "NAME"::VARCHAR as name,
        "NODE_ID"::VARCHAR as node_id,
        "SPDX_ID"::VARCHAR as spdx_id,
        "HTML_URL"::VARCHAR as html_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_LICENSE_HASHID"::VARCHAR as airbyte_license_hashid

    from raw_source

)

select * from final
