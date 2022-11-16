with raw_source as (

    select *
    from {{ source('github_prefect', 'tags') }}

),

final as (

    select
        "NAME"::VARCHAR as name,
        "COMMIT"::VARIANT as commit,
        "NODE_ID"::VARCHAR as node_id,
        "REPOSITORY"::VARCHAR as repository,
        "TARBALL_URL"::VARCHAR as tarball_url,
        "ZIPBALL_URL"::VARCHAR as zipball_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_TAGS_HASHID"::VARCHAR as airbyte_tags_hashid

    from raw_source

)

select * from final
