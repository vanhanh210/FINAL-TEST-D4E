# Retail-SuperMart

## :computer: Project Overview

### Situation
In a retail company named "Retail SuperMart," sales data is collected and stored in a table called sales.csv. This table contains information about orders, products, and customers that the business has recorded over a specific period.
### Objectives
1. Retrieve information about Order ID, Product ID, Customer ID, and Quantity of the rows that meet the condition where Ship Mode is "Standard Class."
2. Retrieve information about the Order IDs of the rows that meet the condition where the Product ID belongs to the "Office Supplies" category and has a quantity greater than 3.
3. Perform a statistical analysis that includes the count of Order IDs, the count of unique product IDs, the total sales, and the total profit for each product Category, sorted in descending order of total sales.
4. For each Ship mode, retrieve customer information (Customer ID) and the number of orders for each customer, considering the Ship mode in question, such that the customer has the highest number of orders in that Ship mode.
5. Write a query that returns a table with an additional column named "totalSaleBefore." This column represents the total sales of all previous orders made by the same customer (including the current order). The previous orders are those orders with an Order Date earlier than or equal to the Order Date of the current order being considered.
