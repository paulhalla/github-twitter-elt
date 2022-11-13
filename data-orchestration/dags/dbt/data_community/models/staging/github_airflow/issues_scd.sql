with raw_source as (

    select *
    from {{ source('github_airflow', 'issues_scd') }}

),

final as (

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "_AIRBYTE_UNIQUE_KEY_SCD"::VARCHAR as airbyte_unique_key_scd,
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "BODY"::VARCHAR as body,
        "USER"::VARIANT as user,
        "STATE"::VARCHAR as state,
        "TITLE"::VARCHAR as title,
        "LABELS"::VARIANT as labels,
        "LOCKED"::BOOLEAN as locked,
        "NUMBER"::NUMBER as number,
        "NODE_ID"::VARCHAR as node_id,
        "USER_ID"::NUMBER as user_id,
        "ASSIGNEE"::VARIANT as assignee,
        "COMMENTS"::NUMBER as comments,
        "HTML_URL"::VARCHAR as html_url,
        "ASSIGNEES"::VARIANT as assignees,
        "CLOSED_AT"::TIMESTAMP_TZ as closed_at,
        "MILESTONE"::VARIANT as milestone,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "EVENTS_URL"::VARCHAR as events_url,
        "LABELS_URL"::VARCHAR as labels_url,
        "REPOSITORY"::VARCHAR as repository,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "COMMENTS_URL"::VARCHAR as comments_url,
        "PULL_REQUEST"::VARIANT as pull_request,
        "REPOSITORY_URL"::VARCHAR as repository_url,
        "ACTIVE_LOCK_REASON"::VARCHAR as active_lock_reason,
        "AUTHOR_ASSOCIATION"::VARCHAR as author_association,
        "_AIRBYTE_START_AT"::TIMESTAMP_TZ as airbyte_start_at,
        "_AIRBYTE_END_AT"::TIMESTAMP_TZ as airbyte_end_at,
        "_AIRBYTE_ACTIVE_ROW"::NUMBER as airbyte_active_row,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_ISSUES_HASHID"::VARCHAR as airbyte_issues_hashid

    from raw_source

)

select * from final
