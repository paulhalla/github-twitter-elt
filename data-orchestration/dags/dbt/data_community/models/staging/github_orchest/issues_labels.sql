with raw_source as (

    select *
    from {{ source('github_orchest', 'issues_labels') }}

),

final as (

    select
        "_AIRBYTE_ISSUES_HASHID"::VARCHAR as airbyte_issues_hashid,
        "ID"::NUMBER as id,
        "URL"::VARCHAR as url,
        "NAME"::VARCHAR as name,
        "COLOR"::VARCHAR as color,
        "default"::BOOLEAN as default,
        "NODE_ID"::VARCHAR as node_id,
        "DESCRIPTION"::VARCHAR as description,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_LABELS_HASHID"::VARCHAR as airbyte_labels_hashid

    from raw_source

)

select * from final
