-- {{ dbt_utils.union_relations(
--     relations=[ref('my_model'), source('my_source', 'my_table')],
--     exclude=["_loaded_at"]
-- ) }}

with raw_source as (

    select *
    from {{ source('github_airflow', 'branches') }}

),

final as (

    select
        "NAME"::VARCHAR as name,
        "COMMIT"::VARIANT as commit,
        "PROTECTED"::BOOLEAN as protected,
        -- "PROTECTION"::VARIANT as protection, -- unnecessary column
        "REPOSITORY"::VARCHAR as repository
        -- "PROTECTION_URL"::VARCHAR as protection_url, -- unnecessary column
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,  -- unnecessary column
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,  -- unnecessary column
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,  -- unnecessary column
        -- "_AIRBYTE_BRANCHES_HASHID"::VARCHAR as airbyte_branches_hashid  -- unnecessary column

    from raw_source

)

select * from final
