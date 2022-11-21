{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_pull_requests as (
    
    {% for schema in schema_names %}

    select
        "ID"::NUMBER as id,
        -- "URL"::VARCHAR as url,
        -- "BASE"::VARIANT as base,
        "BODY"::VARCHAR as body,
        -- "HEAD"::VARIANT as head,
        "USER"::VARIANT as user,
        -- "DRAFT"::BOOLEAN as draft,
        "STATE"::VARCHAR as state,
        "TITLE"::VARCHAR as title,
        -- "_LINKS"::VARIANT as links,
        -- "LABELS"::VARIANT as labels,
        -- "LOCKED"::BOOLEAN as locked,
        -- "NUMBER"::NUMBER as number,
        -- "NODE_ID"::VARCHAR as node_id,
        "ASSIGNEE"::VARIANT as assignee,
        -- "DIFF_URL"::VARCHAR as diff_url,
        -- "HTML_URL"::VARCHAR as html_url,
        -- "ASSIGNEES"::VARIANT as assignees,
        "CLOSED_AT"::TIMESTAMP_TZ as closed_at,
        -- "ISSUE_URL"::VARCHAR as issue_url,
        "MERGED_AT"::TIMESTAMP_TZ as merged_at,
        "MILESTONE"::VARIANT as milestone,
        "PATCH_URL"::VARCHAR as patch_url,
        -- "AUTO_MERGE"::VARIANT as auto_merge,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "REPOSITORY"::VARCHAR as repository,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        -- "COMMITS_URL"::VARCHAR as commits_url,
        -- "COMMENTS_URL"::VARCHAR as comments_url,
        -- "STATUSES_URL"::VARCHAR as statuses_url,
        -- "REQUESTED_TEAMS"::VARIANT as requested_teams,
        -- "MERGE_COMMIT_SHA"::VARCHAR as merge_commit_sha,
        -- "ACTIVE_LOCK_REASON"::VARCHAR as active_lock_reason,
        "AUTHOR_ASSOCIATION"::VARCHAR as author_association
        -- "REVIEW_COMMENT_URL"::VARCHAR as review_comment_url,
        -- "REQUESTED_REVIEWERS"::VARIANT as requested_reviewers,
        -- "REVIEW_COMMENTS_URL"::VARCHAR as review_comments_url,
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid

    from {{ source(schema|string, 'pull_requests') }}

    {% if not loop.last %}

    union all

    {% endif %}
    {% endfor %}

)

select * from stg_pull_requests
