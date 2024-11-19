{{ config(order_by='fact_id', engine='MergeTree()', materialized='table') }}
SELECT 
    ROW_NUMBER() OVER () AS fact_id,
    add.address_id,
    house.house_id,
    info.info_id,
    bds.bds_id,
    fact.Price,
    fact.Square
FROM    DBT_STAGING.Combine_Data AS fact
LEFT JOIN   {{ ref('DIM_ADDRESS') }} AS add ON fact.City = add.City AND fact.District = add.District 
AND fact.Street = add.Street AND fact.Ward = add.Ward AND fact.More = add.More
LEFT JOIN   {{ ref('DIM_HOUSE') }} AS house ON fact.Facing_Dir = house.Facing_Dir AND fact.Floor = house.Floor 
AND fact.Bed = house.Bed AND fact.Entrance_Length = house.Entrance_Length
LEFT JOIN   {{ ref('DIM_INFO') }} AS info ON fact.Title=info.Title AND fact.News_ID = info.News_ID 
AND fact.News_Type = info.News_Type
LEFT JOIN   {{ ref('DIM_BDS') }} AS bds ON fact.Category = bds.Category AND fact.Legal = bds.Legal