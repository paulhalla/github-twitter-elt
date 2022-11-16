with raw_source as (

    select *
    from {{ source('github_orchest', 'releases_assets') }}

),

final as (

    select
        "_AIRBYTE_RELEASES_HASHID"::VARCHAR as airbyte_releases_hashid,
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "NAME"::VARCHAR as name,
        "SIZE"::NUMBER as size,
        "LABEL"::VARCHAR as label,
        "STATE"::VARCHAR as state,
        "NODE_ID"::VARCHAR as node_id,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "UPDATED_AT"::TIMESTAMP_TZ as updated_at,
        "UPLOADER_ID"::NUMBER as uploader_id,
        "CONTENT_TYPE"::VARCHAR as content_type,
        "DOWNLOAD_COUNT"::NUMBER as download_count,
        "BROWSER_DOWNLOAD_URL"::VARCHAR as browser_download_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_ASSETS_HASHID"::VARCHAR as airbyte_assets_hashid

    from raw_source

)

select * from final
