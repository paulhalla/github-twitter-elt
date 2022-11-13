with raw_source as (

    select *
    from {{ source('github_airflow', 'releases') }}

),

final as (

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "BODY"::VARCHAR as body,
        "NAME"::VARCHAR as name,
        "DRAFT"::BOOLEAN as draft,
        "ASSETS"::VARIANT as assets,
        "AUTHOR"::VARIANT as author,
        "NODE_ID"::VARCHAR as node_id,
        "HTML_URL"::VARCHAR as html_url,
        "TAG_NAME"::VARCHAR as tag_name,
        "ASSETS_URL"::VARCHAR as assets_url,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "PRERELEASE"::BOOLEAN as prerelease,
        "REPOSITORY"::VARCHAR as repository,
        "UPLOAD_URL"::VARCHAR as upload_url,
        "TARBALL_URL"::VARCHAR as tarball_url,
        "ZIPBALL_URL"::VARCHAR as zipball_url,
        "PUBLISHED_AT"::TIMESTAMP_TZ as published_at,
        "TARGET_COMMITISH"::VARCHAR as target_commitish,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_RELEASES_HASHID"::VARCHAR as airbyte_releases_hashid

    from raw_source

)

select * from final
