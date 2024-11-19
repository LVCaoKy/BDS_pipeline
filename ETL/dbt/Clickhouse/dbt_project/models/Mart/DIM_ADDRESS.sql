{{ config(order_by='(address_id)', engine='MergeTree()', materialized='table') }}
SELECT 
    ROW_NUMBER() OVER () AS address_id,
    City,
    District,
    Street,
    Ward,
    More
FROM (
    SELECT DISTINCT City,District,Street,Ward,More
    FROM DBT_STAGING.Combine_Data
)