IF OBJECT_ID('sales.daily_sales', 'V') IS NOT NULL
BEGIN
    DROP VIEW sales.daily_sales;
END
GO

CREATE VIEW sales.daily_sales AS
SELECT
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    DAY(o.order_date) AS day,
    c.city AS city,
    c.state AS state,
    p.product_id AS product_id,
    p.product_name AS product_name,
    pc.category_name AS category_name,
	pb.brand_name AS brand_name,
    SUM(i.quantity * i.list_price) AS sales
FROM
    sales.orders AS o
    INNER JOIN sales.order_items AS i ON o.order_id = i.order_id
    INNER JOIN production.products AS p ON p.product_id = i.product_id
    INNER JOIN sales.customers AS c ON c.customer_id = o.customer_id
    INNER JOIN production.categories AS pc ON pc.category_id = p.category_id
	INNER JOIN production.brands AS pb ON pb.brand_id = p.brand_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date),
    DAY(o.order_date),
    c.city,
    c.state,
    p.product_id,
    p.product_name,
    pc.category_name,
	pb.brand_name;
