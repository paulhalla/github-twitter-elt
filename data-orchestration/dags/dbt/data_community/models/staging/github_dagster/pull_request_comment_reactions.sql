with raw_source as (

    select *
    from {{ source('github_dagster', 'pull_request_comment_reactions') }}

),

final as (

    select
        "ID"::NUMBER as id,
        "USER"::VARIANT as user,
        "CONTENT"::VARCHAR as content,
        "NODE_ID"::VARCHAR as node_id,
        "COMMENT_ID"::NUMBER as comment_id,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "REPOSITORY"::VARCHAR as repository,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PULL_REQUEST_COMMENT_REACTIONS_HASHID"::VARCHAR as airbyte_pull_request_comment_reactions_hashid,
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key

    from raw_source

)

select * from final
