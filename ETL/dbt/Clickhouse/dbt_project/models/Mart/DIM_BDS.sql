{{ config(order_by='(bds_id)', engine='MergeTree()', materialized='table') }}
SELECT 
    ROW_NUMBER() OVER () AS bds_id,
    Category,
    Legal
FROM (
    SELECT DISTINCT Category,Legal
    FROM DBT_STAGING.Combine_Data
)