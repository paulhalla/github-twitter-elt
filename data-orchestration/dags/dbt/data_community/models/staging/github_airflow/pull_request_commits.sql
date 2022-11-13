with raw_source as (

    select *
    from {{ source('github_airflow', 'pull_request_commits') }}

),

final as (

    select
        "SHA"::VARCHAR as sha,
        "URL"::VARCHAR as url,
        "AUTHOR"::VARIANT as author,
        "COMMIT"::VARIANT as commit,
        "NODE_ID"::VARCHAR as node_id,
        "PARENTS"::VARIANT as parents,
        "HTML_URL"::VARCHAR as html_url,
        "COMMITTER"::VARIANT as committer,
        "REPOSITORY"::VARCHAR as repository,
        "PULL_NUMBER"::NUMBER as pull_number,
        "COMMENTS_URL"::VARCHAR as comments_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PULL_REQUEST_COMMITS_HASHID"::VARCHAR as airbyte_pull_request_commits_hashid

    from raw_source

)

select * from final
