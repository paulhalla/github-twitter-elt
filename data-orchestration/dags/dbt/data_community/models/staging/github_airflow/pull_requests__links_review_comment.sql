with raw_source as (

    select *
    from {{ source('github_airflow', 'pull_requests__links_review_comment') }}

),

final as (

    select
        "_AIRBYTE__LINKS_HASHID"::VARCHAR as airbyte_links_hashid,
        "HREF"::VARCHAR as href,
        "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        "_AIRBYTE_REVIEW_COMMENT_HASHID"::VARCHAR as airbyte_review_comment_hashid

    from raw_source

)

select * from final
