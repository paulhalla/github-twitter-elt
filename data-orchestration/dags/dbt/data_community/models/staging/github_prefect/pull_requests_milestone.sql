with raw_source as (

    select *
    from {{ source('github_prefect', 'pull_requests_milestone') }}

),

final as (

    select
        "_AIRBYTE_PULL_REQUESTS_HASHID"::VARCHAR as airbyte_pull_requests_hashid,
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "STATE"::VARCHAR as state,
        "TITLE"::VARCHAR as title,
        "DUE_ON"::TIMESTAMP_TZ as due_on,
        "NUMBER"::NUMBER as number,
        "CREATOR"::VARIANT as creator,
        "NODE_ID"::VARCHAR as node_id,
        "HTML_URL"::VARCHAR as html_url,
        "CLOSED_AT"::TIMESTAMP_TZ as closed_at,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "LABELS_URL"::VARCHAR as labels_url,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "DESCRIPTION"::VARCHAR as description,
        "OPEN_ISSUES"::NUMBER as open_issues,
        "CLOSED_ISSUES"::NUMBER as closed_issues,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_MILESTONE_HASHID"::VARCHAR as airbyte_milestone_hashid

    from raw_source

)

select * from final
