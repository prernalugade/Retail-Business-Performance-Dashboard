CREATE TABLE sales_data (
    Order_Priority VARCHAR(50),
    Discount_offered DECIMAL(5, 2),
    Unit_Price DECIMAL(10, 2),
    Freight_Expenses DECIMAL(10, 2),
    Freight_Mode VARCHAR(50),
    Segment VARCHAR(50),
    Product_Type VARCHAR(100),
    Product_Sub_Category VARCHAR(100),
    Product_Container VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Profit DECIMAL(10, 2),
    Qty_Ordered INT,
    Sales DECIMAL(10, 2)
);

-- Remove rows with nulls in essential fields
DELETE FROM sales_data
WHERE Sales IS NULL 
   OR Profit IS NULL 
   OR Order_Date IS NULL 
   OR Product_Type IS NULL;


-- Check for duplicate entries by Order Priority + Order Date + City
SELECT 
    Order_Priority, Order_Date, City, COUNT(*) 
FROM sales_data
GROUP BY Order_Priority, Order_Date, City
HAVING COUNT(*) > 1;


-- Overall performance KPIs
SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Qty_Ordered) AS Total_Quantity
FROM sales_data;


-- Regional breakdown
SELECT 
    Region,
    SUM(Sales) AS Region_Sales,
    SUM(Profit) AS Region_Profit
FROM sales_data
GROUP BY Region
ORDER BY Region_Sales DESC;


-- Product category performance
SELECT 
    Product_Type,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Type
ORDER BY Total_Profit DESC;


-- Monthly sales trend
SELECT 
    TO_CHAR(Order_Date, 'YYYY-MM') AS Month,
    SUM(Sales) AS Monthly_Sales
FROM sales_data
GROUP BY TO_CHAR(Order_Date, 'YYYY-MM')
ORDER BY Month;


-- Profit margin = Profit / Sales * 100
SELECT 
    Product_Type,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2) AS Profit_Margin_Percentage
FROM sales_data
GROUP BY Product_Type
ORDER BY Profit_Margin_Percentage DESC;


-- Freight expenses vs sales by region
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Freight_Expenses) AS Total_Freight,
    ROUND((SUM(Freight_Expenses) / NULLIF(SUM(Sales), 0)) * 100, 2) AS Freight_As_Percentage_Of_Sales
FROM sales_data
GROUP BY Region
ORDER BY Freight_As_Percentage_Of_Sales DESC;


-- Top 5 most profitable sub-categories
SELECT 
    Product_Sub_Category,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Sub_Category
ORDER BY Total_Profit DESC
LIMIT 5;


-- Bottom 5 (loss-making) sub-categories
SELECT 
    Product_Sub_Category,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Sub_Category
ORDER BY Total_Profit ASC
LIMIT 5;















