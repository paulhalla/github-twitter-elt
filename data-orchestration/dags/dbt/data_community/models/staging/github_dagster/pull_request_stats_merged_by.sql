with raw_source as (

    select *
    from {{ source('github_dagster', 'pull_request_stats_merged_by') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUEST_STATS_HASHID"::VARCHAR as airbyte_pull_request_stats_hashid,
        "ID"::NUMBER as id,
        "TYPE"::VARCHAR as type,
        "LOGIN"::VARCHAR as login,
        "NODE_ID"::VARCHAR as node_id,
        "HTML_URL"::VARCHAR as html_url,
        "AVATAR_URL"::VARCHAR as avatar_url,
        "SITE_ADMIN"::BOOLEAN as site_admin,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_MERGED_BY_HASHID"::VARCHAR as airbyte_merged_by_hashid

    from raw_source

)

select * from final
