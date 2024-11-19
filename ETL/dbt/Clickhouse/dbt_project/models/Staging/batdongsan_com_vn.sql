WITH batdongsan_com_vn AS (
    Select
        Facing_Dir,
        IF(position(Legal, 'sổ') > 0, 'có sổ', 
        IF(position(Legal, 'Hợp') > 0 OR position(Legal, 'HĐMB') > 0, 'hợp đồng', 'không có')) AS Legal,
        News_Type,
        News_ID,
        Title,
        Category,





        -- Xử lý tiền
        CASE
            WHEN Price LIKE '%triệu/m²%' THEN 
                replaceRegexpAll(Price, '[^0-9.]', '')::FLOAT * Square * 1_000_000
            WHEN Price LIKE '%nghìn/tháng%' THEN 
                replaceRegexpAll(Price, '[^0-9.]', '')::FLOAT * 1_000
            WHEN Price LIKE '%nghìn/m²%' THEN 
                replaceRegexpAll(Price, '[^0-9.]', '')::FLOAT * Square * 1_000
            WHEN Price LIKE '%tỷ%' THEN 
                replaceRegexpAll(Price, '[^0-9.]', '')::FLOAT * 1_000_000_000
            WHEN Price LIKE '%triệu%' THEN 
                replaceRegexpAll(Price, '[^0-9.]', '')::FLOAT * 1_000_000
            WHEN Price LIKE '%Thỏa%' THEN NULL
            ELSE 
                CAST(Price AS FLOAT) -- Giá trị đã là VND
        END AS Price,




        -- Xử lí diện tích
        CASE
            WHEN Square = '' THEN NULL
            ELSE 
                CAST(
                    replaceRegexpAll(
                        replaceRegexpAll(
                            replaceRegexpAll(Square,'[^0-9,.]',''), ',', '.'
                        ), '\\.', ''
                    ) AS Float32
                ) 
        END AS Square,


        -- Xử lí phòng ngủ
        COALESCE(replaceRegexpAll(replaceRegexpAll(Bed, '\\s+', ''), '\\D+', ''), '0') AS Bed,
        Floor,



        -- Xử lí địa chỉ
        splitByString(',', Address)[-1] AS City,
        splitByString(',', Address)[-2] AS District,
        splitByString(',', Address)[-3] AS Ward,
        CASE
            WHEN splitByString(',', Address)[-4] LIKE '%Dự án%' THEN NULL
            ELSE splitByString(',', Address)[-4]
        END AS Street,
        CASE
            WHEN splitByString(',', Address)[-4] LIKE '%Dự án%' THEN splitByString(',', Address)[-4]
            ELSE splitByString(',', Address)[-5]
        END AS More,
        Entrance_Length
    FROM
        {{ source('RAW', 'batdongsan_com_vn') }}
)   
SELECT * FROM batdongsan_com_vn