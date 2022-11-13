with raw_source as (

    select *
    from {{ source('github_airflow', 'commits_parents') }}

),

final as (

    select
        "_AIRBYTE_COMMITS_HASHID"::VARCHAR as airbyte_commits_hashid,
        "SHA"::VARCHAR as sha,
        "URL"::VARCHAR as url,
        "HTML_URL"::VARCHAR as html_url,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_PARENTS_HASHID"::VARCHAR as airbyte_parents_hashid

    from raw_source

)

select * from final
