with raw_source as (

    select *
    from {{ source('github_airflow', '_airbyte_raw_pull_request_stats') }}

),

final as (

    select
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_DATA"::VARIANT as airbyte_data,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at

    from raw_source

)

select * from final
