CREATE INDEX IX_Product_NameAndColor
ON SalesLT.Product (Name, Color)

SELECT *
FROM sys.indexes
WHERE name = 'IX_Product_NameAndColor'

SELECT *
FROM SalesLT.vProductAndDescription

ALTER VIEW SalesLT.vProductAndDescription
        AS
        SELECT
            p.ProductID
            ,p.ProductNumber
            ,p.Name
            ,pm.Name AS ProductModel
            ,pmx.Culture
            ,pd.Description
        FROM SalesLT.Product p
            INNER JOIN SalesLT.ProductModel pm
            ON p.ProductModelID = pm.ProductModelID
            INNER JOIN SalesLT.ProductModelProductDescription pmx
            ON pm.ProductModelID = pmx.ProductModelID
            INNER JOIN SalesLT.ProductDescription pd
            ON pmx.ProductDescriptionID = pd.ProductDescriptionID;

        GO

SELECT * FROM dbo.ErrorLog

DROP TABLE dbo.ErrorLog

SELECT * from sys.tables

-- ALTER VIEW SalesLT.vProductAndDescription
--     AS
--     SELECT
--         p.ProductID,
--         p.ProductNumber,
--         p.Name,
--         pm.Name as ProductModel,
--         pmx.Culture,
--         pd.Description 
--     FROM SalesLT.Product p 
--         INNER JOIN SalesLT.ProductModel pm 
--         ON p.ProductModelID = pm.ProductModelID 
--         INNER JOIN SalesLT.ProductModelProductDescription pmx
--         ON pm.ProductModelID = pmx.ProductModelID
--         INNER JOIN SalesLT.ProductDescription pd 
--         ON pmx.ProductDescriptionID = pd.ProductDescriptionID;
--     GO



-- select * 
-- from sys.tables

-- SELECT t.name as TableName, s.name as SchemaName
-- from sys.tables t 
-- INNER JOIN sys.schemas s 
-- on t.schema_id = s.schema_id

-- SELECT *
-- from salesLT.product p 
-- left join salesLT.ProductCategory c 
-- on p.productcategoryid = c.productcategoryid 
-- where c.productcategoryid = 5 
-- and p.color = 'Silver'
-- and p.listprice < 1000
-- order by p.listprice ASCñ


-- select name, standardcost, "Price comment" = 
--     Case 
--         when StandardCost > 1000 then 'Too Expensive'
--         else 'Just right'
--     END
-- from SalesLT.Product

-- SELECT c.firstname, c.lastname, cu.AddressID
-- from salesLT.customer c
-- INNER JOIN SalesLT.CustomerAddress cu
-- on c.CustomerID = cu.CustomerID

-- select * from saleslt.product

-- SELECT * FROM saleslt.PRODUCT
-- WHERE COLOR = 'RED'

-- SELECT ProductID, Name, Color, Standardcost
-- From saleslt.product
-- Where Standardcost > 1000 And Standardcost < 2000
-- Order by Standardcost Desc

-- SELECT count(name), color
-- from saleslt.product
-- where color is not null
-- group by color
-- having count(name) > 30 and count(color) <50

-- select count(name), color
-- from saleslt.product
-- group by color
-- having count(name) > 50

-- select name, productid, standardcost
-- from saleslt.product
-- order by standardcost DESC

-- select * from saleslt.product
-- where color is null

