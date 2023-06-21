 -- Lấy thông tin về Mã đơn hàng, mã sản phẩm, mã khách hàng, số lượng sản phẩm của những dòng dữ liệu thỏa điều kiện Ship Mode là Standard Class
SELECT 
    Order_ID, Product_ID, Customer_ID, Quantity
FROM `personal-project-374607.sales.sales`
WHERE 
    Ship_Mode = 'Standard Class';
-- Lấy thông tin về những mã đơn hàng (orderID) của những dòng dữ liệu thỏa mãn điều kiện sản phẩm (Product ID) thuộc category là Office Supplies và có quantity > 3
SELECT Order_ID
FROM `personal-project-374607.sales.sales`
WHERE  Category = 'Office Supplies' AND Quantity > 3;
-- Thống kê số lượng mã đơn hàng, số lượng các loại sản phẩm (product ID),tổng doanh thu và tổng lợi nhuận theo từng Category, sắp xếp theo thứ tự giảm dần của doanh thu
SELECT 
    Category,
    COUNT(DISTINCT(Order_ID)) AS Number_of_Orders,
    COUNT(DISTINCT (Product_ID)) AS Number_of_Products,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM `personal-project-374607.sales.sales`
GROUP BY Category
ORDER BY SUM(Sales) DESC;
-- Với mỗi loại Ship mode, lấy ra thông tin khách hàng (Customer ID), số lượng đơn hàng sao cho có số lượng đơn hàng của khách hàng đó theo hình thức Ship mode đang xét là nhiều nhất.
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
-- Viết 1 câu query trả về 1 table với điều kiện như sau: với mỗi dòng dữ liệu, thêm 1 column có tên là totalSaleBefore: Tổng số doanh thu của các đơn hàng mà trước đó customer đó thực hiện (Bao gồm cả đơn hàng hiện tại). Những đơn hàng trước đó chính là những đơn hàng có Order Date <= Ngày của đơn hàng đang xét.
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