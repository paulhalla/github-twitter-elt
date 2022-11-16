with raw_source as (

    select *
    from {{ source('github_orchest', 'issue_reactions_scd') }}

),

final as (

    select
        "_AIRBYTE_UNIQUE_KEY"::VARCHAR as airbyte_unique_key,
        "_AIRBYTE_UNIQUE_KEY_SCD"::VARCHAR as airbyte_unique_key_scd,
        "ID"::NUMBER as id,
        "USER"::VARIANT as user,
        "CONTENT"::VARCHAR as content,
        "NODE_ID"::VARCHAR as node_id,
        "CREATED_AT"::TIMESTAMP_TZ as created_at,
        "REPOSITORY"::VARCHAR as repository,
        "ISSUE_NUMBER"::NUMBER as issue_number,
        "_AIRBYTE_START_AT"::TIMESTAMP_TZ as airbyte_start_at,
        "_AIRBYTE_END_AT"::TIMESTAMP_TZ as airbyte_end_at,
        "_AIRBYTE_ACTIVE_ROW"::NUMBER as airbyte_active_row,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_ISSUE_REACTIONS_HASHID"::VARCHAR as airbyte_issue_reactions_hashid

    from raw_source

)

select * from final
