with raw_source as (

    select *
    from {{ source('github_airflow', 'organizations') }}

),

final as (

    select
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "BLOG"::VARCHAR as blog,
        "NAME"::VARCHAR as name,
        "PLAN"::VARIANT as plan,
        "TYPE"::VARCHAR as type,
        "EMAIL"::VARCHAR as email,
        "LOGIN"::VARCHAR as login,
        "COMPANY"::VARCHAR as company,
        "NODE_ID"::VARCHAR as node_id,
        "HTML_URL"::VARCHAR as html_url,
        "LOCATION"::VARCHAR as location,
        "FOLLOWERS"::NUMBER as followers,
        "following"::NUMBER as following,
        "HOOKS_URL"::VARCHAR as hooks_url,
        "REPOS_URL"::VARCHAR as repos_url,
        "AVATAR_URL"::VARCHAR as avatar_url,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "DISK_USAGE"::NUMBER as disk_usage,
        "EVENTS_URL"::VARCHAR as events_url,
        "ISSUES_URL"::VARCHAR as issues_url,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "DESCRIPTION"::VARCHAR as description,
        "IS_VERIFIED"::BOOLEAN as is_verified,
        "MEMBERS_URL"::VARCHAR as members_url,
        "PUBLIC_GISTS"::NUMBER as public_gists,
        "PUBLIC_REPOS"::NUMBER as public_repos,
        "BILLING_EMAIL"::VARCHAR as billing_email,
        "COLLABORATORS"::NUMBER as collaborators,
        "PRIVATE_GISTS"::NUMBER as private_gists,
        "TWITTER_USERNAME"::VARCHAR as twitter_username,
        "PUBLIC_MEMBERS_URL"::VARCHAR as public_members_url,
        "OWNED_PRIVATE_REPOS"::NUMBER as owned_private_repos,
        "TOTAL_PRIVATE_REPOS"::NUMBER as total_private_repos,
        "HAS_REPOSITORY_PROJECTS"::BOOLEAN as has_repository_projects,
        "MEMBERS_CAN_CREATE_PAGES"::BOOLEAN as members_can_create_pages,
        "HAS_ORGANIZATION_PROJECTS"::BOOLEAN as has_organization_projects,
        "DEFAULT_REPOSITORY_PERMISSION"::VARCHAR as default_repository_permission,
        "TWO_FACTOR_REQUIREMENT_ENABLED"::BOOLEAN as two_factor_requirement_enabled,
        "MEMBERS_CAN_CREATE_PUBLIC_PAGES"::BOOLEAN as members_can_create_public_pages,
        "MEMBERS_CAN_CREATE_REPOSITORIES"::BOOLEAN as members_can_create_repositories,
        "MEMBERS_CAN_CREATE_PRIVATE_PAGES"::BOOLEAN as members_can_create_private_pages,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_ORGANIZATIONS_HASHID"::VARCHAR as airbyte_organizations_hashid

    from raw_source

)

select * from final
