{{ config(order_by='(info_id)', engine='MergeTree()', materialized='table') }}
SELECT 
    ROW_NUMBER() OVER () AS info_id,
    Title,
    News_ID,
    News_Type
FROM (
    SELECT DISTINCT News_ID,News_Type,Title
    FROM DBT_STAGING.Combine_Data
)