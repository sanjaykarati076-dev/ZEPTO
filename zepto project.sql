DROP TABLE IF EXISTS zepto_v2;

CREATE TABLE zepto_v2 (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(10,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(10,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
COPY zepto_v2 (category, name, mrp, discountPercent, availableQuantity,
               discountedSellingPrice, weightInGms, outOfStock, quantity)
FROM 'C:/Users/Sanjay/OneDrive/Documents/ZEPTO/zepto_v2.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'LATIN1'
);
--data exploration 
--count of rows
SELECT count (*) FROM zepto_v2


SELECT * FROM zepto_v2
LIMIT 10;
--null values

SELECT * FROM zepto_v2
WHERE name is NULL
OR
category is NULL
OR
mrp is NULL
OR
discountpercent is NULL
OR
discountedsellingprice is NULL
OR
weightingms is NULL
OR
outofstock is NULL
OR
quantity is NULL
OR
availablequantity is NULL;


--different product category

SELECT DISTINCT category
FROM zepto_v2
ORDER BY category;


--product in stock vs out of stock


SELECT outofstock, count(sku_id)
FROM zepto_v2
GROUP BY outofstock;
--product name present in multiple times
SELECT NAME, count (sku_id) AS "no of SKUs"
FROM zepto_v2
GROUP BY name
HAVING count (sku_id)>1
ORDER BY count(sku_id) DESC;


--Data Cleaning

SELECT * FROM zepto_v2
WHERE mrp = 0 OR discountedSellingPrice = 0;

delete FROM zepto_v2
WHERE mrp =0;

--convert paise to rupees
UPDATE zepto_v2
SET mrp = mrp/100,
discountedsellingprice = discountedsellingprice/100.00;
SELECT  mrp,discountedSellingPrice FROM zepto_v2;

--Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC
LIMIT 10;


-- Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name,mrp
FROM zepto_v2
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;


-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue;



-- Q4. Find all products where MRP is greater than <500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;


--5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram;
--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
WHEN weightInGms < 5000 THEN 'Medium'
ELSE 'Bulk'
END AS weight_category
FROM zepto_v2;
-- Q8.What is the Total Inventory Weight Per Category
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight;

DROP TABLE IF EXISTS zepto_v2;

CREATE TABLE zepto_v2 (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
COPY zepto_v2 (category, name, mrp, discountPercent, availableQuantity,
               discountedSellingPrice, weightInGms, outOfStock, quantity)
FROM 'C:/Users/Sanjay/OneDrive/Documents/ZEPTO/zepto_v2.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'LATIN1'
);
--data exploration 
--count of rows
SELECT count (*) FROM zepto_v2


SELECT * FROM zepto_v2
LIMIT 10;
--null values

SELECT * FROM zepto_v2
WHERE name is NULL
OR
category is NULL
OR
mrp is NULL
OR
discountpercent is NULL
OR
discountedsellingprice is NULL
OR
weightingms is NULL
OR
outofstock is NULL
OR
quantity is NULL
OR
availablequantity is NULL;


--different product category

SELECT DISTINCT category
FROM zepto_v2
ORDER BY category;


--product in stock vs out of stock


SELECT outofstock, count(sku_id)
FROM zepto_v2
GROUP BY outofstock;
--product name present in multiple times
SELECT NAME, count (sku_id) AS "no of SKUs"
FROM zepto_v2
GROUP BY name
HAVING count (sku_id)>1
ORDER BY count(sku_id) DESC;


--Data Cleaning

SELECT * FROM zepto_v2
WHERE mrp = 0 OR discountedSellingPrice = 0;

delete FROM zepto_v2
WHERE mrp =0;

--convert paise to rupees
UPDATE zepto_v2
SET mrp = mrp/100.00,
discountedsellingprice = discountedsellingprice/100.00;
SELECT  mrp,discountedSellingPrice FROM zepto_v2;

--Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC
LIMIT 10;


-- Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name,mrp
FROM zepto_v2
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;


-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue;



-- Q4. Find all products where MRP is greater than <500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;


--5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram;
--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
WHEN weightInGms < 5000 THEN 'Medium'
ELSE 'Bulk'
END AS weight_category
FROM zepto_v2;
-- Q8.What is the Total Inventory Weight Per Category
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight;
