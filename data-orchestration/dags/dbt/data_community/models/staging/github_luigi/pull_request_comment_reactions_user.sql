with raw_source as (

    select *
    from {{ source('github_luigi', 'pull_request_comment_reactions_user') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUEST_COMMENT_REACTIONS_HASHID"::VARCHAR as airbyte_pull_request_comment_reactions_hashid,
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
        "_AIRBYTE_USER_HASHID"::VARCHAR as airbyte_user_hashid

    from raw_source

)

select * from final
