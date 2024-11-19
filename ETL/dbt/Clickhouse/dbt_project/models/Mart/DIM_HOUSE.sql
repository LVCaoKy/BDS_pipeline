{{ config(order_by='(house_id)', engine='MergeTree()', materialized='table') }}
SELECT 
    ROW_NUMBER() OVER () AS house_id,
    Floor,
    Entrance_Length,
    Bed,
    Facing_Dir
FROM (
    SELECT DISTINCT Floor,Bed,Entrance_Length,Facing_Dir
    FROM DBT_STAGING.Combine_Data
)