with raw_source as (

    select *
    from {{ source('github_prefect', 'pull_requests_requested_teams') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "NAME"::VARCHAR as name,
        "SLUG"::VARCHAR as slug,
        "PARENT"::VARIANT as parent,
        "NODE_ID"::VARCHAR as node_id,
        "PRIVACY"::VARCHAR as privacy,
        "HTML_URL"::VARCHAR as html_url,
        "PERMISSION"::VARCHAR as permission,
        "DESCRIPTION"::VARCHAR as description,
        "MEMBERS_URL"::VARCHAR as members_url,
        "REPOSITORIES_URL"::VARCHAR as repositories_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_REQUESTED_TEAMS_HASHID"::VARCHAR as airbyte_requested_teams_hashid

    from raw_source

)

select * from final
