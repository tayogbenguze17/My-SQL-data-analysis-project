SELECT *
FROM [Superstore_DB].[dbo].[Superstore Database]
ORDER BY Row_ID
OFFSET 0 ROWS
FETCH NEXT 100 ROWS ONLY;  -- Page size

USE Superstore_DB;
GO
EXEC sp_help 'Superstore Database';

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Superstore Database';

SELECT 
    c.name AS ColumnName,
    t.name AS DataType,
    c.max_length,
    c.is_nullable
FROM sys.columns AS c
JOIN sys.types AS t
    ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID('Superstore Database');
