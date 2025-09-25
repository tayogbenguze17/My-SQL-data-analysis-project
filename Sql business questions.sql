
use Testing;

-- Question 1 : List all suppliers in the UK

SELECT Id, CompanyName, City, Country, Phone
FROM Supplier
WHERE Country = 'UK'; -- shows only supplier in UK


-- Question 2: List the first name, last name, and city for all customers. Concatenate the
-- first and last name separated by a space and a comma as a single column
SELECT 
    FirstName,
    LastName,
    City,
    FirstName + ' ' + LastName AS FullName  -- for space only
FROM Customer; -- this returns customers details


-- Question 3: List all customers in Sweden
SELECT 
    Id,
    FirstName,
    LastName,
    City,
    Country,
    Phone
FROM Customer
WHERE Country = 'Sweden'; -- this only return customers in sweden

-- Question 4: List all suppliers in alphabetical order
SELECT 
    Id,
    CompanyName,
    City,
    Country,
    Phone
FROM Supplier
ORDER BY CompanyName ASC; -- this shows all the company name in ascending order

-- Question 5: List all suppliers with their products

SELECT 
    s.Id AS SupplierID,
    s.CompanyName AS SupplierName,
    p.Id AS ProductID,
    p.ProductName
FROM Supplier s
JOIN Product p ON s.Id = p.SupplierId
ORDER BY s.CompanyName, p.ProductName; -- this return all the company and the product they supplied


-- Question 6: List all orders with customers information

SELECT 
    o.Id AS OrderID,
    o.OrderDate,
    o.OrderNumber,
    o.TotalAmount,
    c.FirstName,
    c.LastName,
    c.City,
    c.Country,
    c.Phone,
    c.FirstName + ' ' + c.LastName AS FullName
FROM "Order" o
JOIN Customer c ON o.CustomerId = c.Id
ORDER BY o.OrderDate;-- this return order details and customers details


-- Question 7: List all orders with product name, quantity, and price, sorted by order number

SELECT 
    o.OrderNumber,
    o.OrderDate,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice,
    (oi.Quantity * oi.UnitPrice) AS LineTotal
FROM "Order" o
JOIN OrderItem oi ON o.Id = oi.OrderId
JOIN Product p   ON oi.ProductId = p.Id
ORDER BY o.OrderNumber, p.ProductName; -- This will show each order, its products, quantity, unit price, and total for that line item.


-- Question 8: Using a case statement, list all the availability of products. When 0 then not available,
-- else available
SELECT 
    Id AS ProductID,
    ProductName,
    IsDiscontinued,
    CASE 
        WHEN IsDiscontinued = 0 THEN 'Not Available'
        ELSE 'Available'
    END AS Availability
FROM Product
ORDER BY ProductName; -- this shows wether the product is available or not


-- Question 9: Using case statement, list all the suppliers and the language they speak. 
-- The language they speak should be their country E.g if UK, then English

select
country from Supplier; -- show all the country

SELECT 
    Id AS SupplierID,
    CompanyName,
    Country,
    CASE 
        WHEN Country = 'UK' THEN 'English'
        WHEN Country = 'USA' THEN 'English'
        WHEN Country = 'Germany' THEN 'German'
        WHEN Country = 'Sweden' THEN 'Swedish'
        WHEN Country = 'France' THEN 'French'
        WHEN Country = 'Spain' THEN 'Spanish'
        WHEN Country = 'Italy' THEN 'Italian'
        WHEN Country = 'Canada' THEN 'Canadians'
        ELSE 'Unknown'
    END AS Language
FROM Supplier
ORDER BY CompanyName; -- this return individual country languages



-- Question 10: List all products that are packaged in Jars
select Package from Product;
SELECT 
    Id AS ProductID,
    ProductName,
    Package,
    UnitPrice
FROM Product
WHERE Package LIKE '%jar%'
ORDER BY ProductName; -- this return products where package contain jar


-- Question 11: List procucts name, unitprice and packages for products that starts with Ca
SELECT
    ProductName,
    Package,
    UnitPrice
FROM Product
WHERE ProductName LIKE 'Ca%'
ORDER BY ProductName; -- this return only productname that start with Ca


-- Question 12: List the number of products for each supplier, sorted high to low
SELECT 
    s.Id AS SupplierID,
    s.CompanyName AS SupplierName,
    COUNT(p.Id) AS ProductCount
FROM Supplier s
LEFT JOIN Product p ON s.Id = p.SupplierId
GROUP BY s.Id, s.CompanyName
ORDER BY ProductCount DESC; -- This will show each supplier and how many products they supply


-- Question 13: List the number of customers in each country
SELECT 
    Country,
    COUNT(Id) AS CustomerCount
FROM Customer
GROUP BY Country
ORDER BY CustomerCount;-- This will list each country with their customers



-- Question 14: List the number of customers in each country, sorted high to low
SELECT 
    Country,
    COUNT(Id) AS CustomerCount
FROM Customer
GROUP BY Country
ORDER BY CustomerCount DESC; -- This will list each country with how many customers it has, sorted from highest to lowest


-- Question 15: List the total order amount for each customer, sorted high to low
SELECT 
    c.Id AS CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Country,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customer c
JOIN "Order" o ON c.Id = o.CustomerId
GROUP BY c.Id, c.FirstName, c.LastName, c.Country
ORDER BY TotalSpent DESC; -- This will give each customer, their country, and how much they have spent in total, 
                          --sorted from highest spender to lowest.



-- Question 16: List all countries with more than 2 suppliers
SELECT 
    Country,
    COUNT(Id) AS SupplierCount
FROM Supplier
GROUP BY Country
HAVING COUNT(Id) > 2
ORDER BY SupplierCount; -- This shows only the countries where supplier count is greater than 2


-- Question 17: List the number of customers in each country. Only include countries with more than 10 customers.
SELECT 
    Country,
    COUNT(Id) AS CustomerCount
FROM Customer
GROUP BY Country
HAVING COUNT(Id) > 10
ORDER BY CustomerCount DESC; -- only countries with 11 or more customers will appear in descending order


-- Question 18: List the number of customers in each country, except the USA, sorted high to low. Only include
-- countries with 9 or more customers.
SELECT 
    Country,
    COUNT(Id) AS CustomerCount
FROM Customer
WHERE Country <> 'USA'
GROUP BY Country
HAVING COUNT(Id) >= 9
ORDER BY CustomerCount DESC; -- This will return only non-USA countries with at least 9 customers, sorted by customer count.


-- Question 19: List customer with average orders between $1000 and $1200
SELECT 
    c.Id AS CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    AVG(o.TotalAmount) AS AvgOrderAmount
FROM Customer c
JOIN "Order" o ON c.Id = o.CustomerId
GROUP BY c.Id, c.FirstName, c.LastName
HAVING AVG(o.TotalAmount) BETWEEN 1000 AND 1200
ORDER BY AvgOrderAmount; -- This gives only customers whose average order size is between $1000 and $1200.


-- Question 20: Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013
SELECT 
    COUNT(Id) AS NumberOfOrders,
    SUM(TotalAmount) AS TotalSales
FROM "Order"
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31';
