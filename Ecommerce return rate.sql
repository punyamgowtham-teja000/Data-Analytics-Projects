CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;
CREATE TABLE orders_with_risk (
  Order_ID            VARCHAR(50),
  Product_ID          VARCHAR(50),
  User_ID             VARCHAR(50),
  Order_Date          VARCHAR(10),   
  Return_Date         VARCHAR(10), 
  Product_Category    VARCHAR(50),
  Product_Price       DECIMAL(10,2),
  Order_Quantity      INT,
  Return_Reason       VARCHAR(100),
  Return_Status       VARCHAR(20),
  Days_to_Return      INT,
  User_Age            INT,
  User_Gender         VARCHAR(10),
  User_Location       VARCHAR(50),
  Payment_Method      VARCHAR(20),
  Shipping_Method     VARCHAR(20),
  Discount_Applied    DECIMAL(10,2),
  return_risk         FLOAT
);

select * from orders_with_risk;

SELECT 
  Product_Category,
  COUNT(*) AS Total_Orders,
  SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returned_Orders,
  ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Return_Percentage
FROM orders_with_risk
GROUP BY Product_Category
ORDER BY Return_Percentage DESC;

SELECT Return_Reason, COUNT(*) AS Total_Returns
FROM orders_with_risk
WHERE Return_Status = 'Returned'
GROUP BY Return_Reason
ORDER BY Total_Returns DESC;

SELECT Product_Category, AVG(Days_to_Return) AS Avg_Days
FROM orders_with_risk
WHERE Return_Status = 'Returned'
GROUP BY Product_Category;