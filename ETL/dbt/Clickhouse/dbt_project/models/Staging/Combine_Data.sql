SELECT 
  CAST(Bed AS Nullable(Float64)) AS Bed, 
  Category, 
  City, 
  District, 
  CAST(Entrance_Length AS Nullable(Float32)) AS Entrance_Length, 
  Facing_Dir, 
  CAST(Floor AS Nullable(Float64)) AS Floor, 
  Legal, 
  More, 
  News_ID, 
  News_Type, 
  Price, 
  Square, 
  Street, 
  Title, 
  Ward 
FROM {{ ref('batdongsan_com_vn') }} 
UNION ALL 
SELECT 
  CAST(Bed AS Nullable(Float64)) AS Bed, 
  Category, 
  City, 
  District, 
  Entrance_Length, 
  Facing_Dir, 
  CAST(Floor AS Nullable(Float64)) AS Floor, 
  Legal, 
  More, 
  News_ID, 
  News_Type, 
  Price, 
  Square, 
  Street, 
  Title, 
  Ward 
FROM {{ ref('nhadat123') }}
UNION ALL 
SELECT 
  Bed, 
  Category, 
  City, 
  District, 
  Entrance_Length, 
  Facing_Dir, 
  Floor, 
  Legal, 
  More, 
  News_ID, 
  News_Type, 
  Price, 
  Square, 
  Street, 
  Title, 
  Ward 
FROM {{ ref('alonhadat') }}