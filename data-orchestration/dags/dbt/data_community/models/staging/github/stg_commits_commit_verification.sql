{% set schema_names=('github_airflow', 'github_argo', 'github_dagster', 'github_luigi', 'github_orchest', 'github_prefect') %}

with stg_commit_verification as (

    {% for schema in schema_names %}
    select
        "_AIRBYTE_COMMIT_HASHID"::VARCHAR as airbyte_commit_hashid,
        "REASON"::VARCHAR as reason,
        -- "PAYLOAD"::VARCHAR as payload,
        "VERIFIED"::BOOLEAN as verified,
        "SIGNATURE"::VARCHAR as signature
        -- "_AIRBYTE_AB_ID"::VARCHAR as airbyte_ab_id,
        -- "_AIRBYTE_EMITTED_AT"::TIMESTAMP_TZ as airbyte_emitted_at,
        -- "_AIRBYTE_NORMALIZED_AT"::TIMESTAMP_TZ as airbyte_normalized_at,
        -- "_AIRBYTE_VERIFICATION_HASHID"::VARCHAR as airbyte_verification_hashid

    from {{ source(schema|string, 'commits_commit_verification')}}

    {% if not loop.last %}

    union all
    {% endif %}
    {% endfor %}

)

select * from stg_commit_verification
