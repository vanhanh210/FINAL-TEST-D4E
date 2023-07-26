# Retail-SuperMart

## :computer: Project Overview

### Situation
In a retail company named "Retail SuperMart," sales data is collected and stored in a table called sales.csv. This table contains information about orders, products, and customers that the business has recorded over a specific period.

The data includes the following main columns:

- Order ID: Order identifier - This is a unique code assigned to each order when a customer purchases a product.
- Order Date (dd/MM/yyyy): Order date - This is the date when the customer placed the order.
- Ship Date: Shipping date - This is the date when the product is delivered to the customer's address.
- Ship Mode: Shipping method - It represents the transportation mode used to deliver the product to the customer (e.g., Standard Class, Express, Second Day, Overnight).
- Customer ID: Customer identifier - This is a unique code assigned to each customer.
- Product ID: Product identifier - This is a unique code assigned to each product sold in the store.
- Category: Product category - This is the main group that classifies the products (e.g., Electronics, Office Supplies, Home Appliances).
- Sub-category: Product sub-category - This provides further classification of products within each main category (e.g., Laptops, Pens, Lighting).
- Quantity: Product quantity - The quantity of the product ordered by the customer in each order.
- Sale: Sales revenue - The total value of the order based on the selling price of the product and the quantity purchased.
- Profit: Profit - The profit obtained from each order after deducting related costs (e.g., production costs, shipping costs).

This data table allows Retail SuperMart to analyze and generate insights into their business operations, understand customer buying trends, identify product categories that generate the highest revenue and profit, and make informed and effective business decisions.
### Objectives
1. Retrieve information about Order ID, Product ID, Customer ID, and Quantity of the rows that meet the condition where Ship Mode is "Standard Class."
````sql
SELECT 
    Order_ID, Product_ID, Customer_ID, Quantity
FROM `sales`
WHERE 
    Ship_Mode = 'Standard Class';
````
2. Retrieve information about the Order IDs of the rows that meet the condition where the Product ID belongs to the "Office Supplies" category and has a quantity greater than 3.
````sql
FROM `personal-project-374607.sales.sales`
WHERE  Category = 'Office Supplies' AND Quantity > 3;
````
3. Perform a statistical analysis that includes the count of Order IDs, the count of unique product IDs, the total sales, and the total profit for each product Category, sorted in descending order of total sales.
````sql
SELECT 
    Category,
    COUNT(DISTINCT(Order_ID)) AS Number_of_Orders,
    COUNT(DISTINCT (Product_ID)) AS Number_of_Products,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM `sales`
GROUP BY Category
ORDER BY SUM(Sales) DESC;
````
4. For each Ship mode, retrieve customer information (Customer ID) and the number of orders for each customer, considering the Ship mode in question, such that the customer has the highest number of orders in that Ship mode.
````sql
WITH t1 AS (
  SELECT 
    Ship_Mode, 
    Customer_ID, 
    COUNT(DISTINCT Order_ID) AS num_orders,
    RANK() OVER (PARTITION BY Ship_Mode ORDER BY COUNT(DISTINCT Order_ID) DESC) AS rk
  FROM `personal-project-374607.sales.sales`
  GROUP BY 
    Ship_Mode, 
    Customer_ID
)
SELECT 
  Ship_Mode, 
  Customer_ID, 
  num_orders
FROM 
  t1
WHERE 
  rk = 1
ORDER BY Ship_Mode;
````
5. Write a query that returns a table with an additional column named "totalSaleBefore." This column represents the total sales of all previous orders made by the same customer (including the current order). The previous orders are those orders with an Order Date earlier than or equal to the Order Date of the current order being considered.
````sql
SELECT 
    Order_Line,
    Order_ID,
    Order_Date,
    Customer_ID,
    Product_ID,
    Sales,
    Quantity,
  (SELECT SUM(Sales) FROM `personal-project-374607.sales.sales` s2 
   WHERE s2.Customer_ID = s1.Customer_ID AND s2.Order_Date <= s1.Order_Date) AS totalSaleBefore
FROM 
  `personal-project-374607.sales.sales` s1
ORDER BY 
  Order_Line ASC
````

