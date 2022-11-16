with raw_source as (

    select *
    from {{ source('github_orchest', 'issues_pull_request') }}

),

final as (

    select
        "_AIRBYTE_ISSUES_HASHID"::VARCHAR as airbyte_issues_hashid,
        "URL"::VARCHAR as url,
        "DIFF_URL"::VARCHAR as diff_url,
        "HTML_URL"::VARCHAR as html_url,
        "PATCH_URL"::VARCHAR as patch_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PULL_REQUEST_HASHID"::VARCHAR as airbyte_pull_request_hashid

    from raw_source

)

select * from final
