WITH order_metrics AS (
    SELECT 
        order_id,
        customer_id, -- Added this so we can link to the customers table!
        order_purchase_timestamp,
        order_estimated_delivery_date,
        order_delivered_customer_date,
        EXTRACT(EPOCH FROM (order_delivered_customer_date::TIMESTAMP - order_purchase_timestamp::TIMESTAMP)) / 86400 AS actual_days_to_deliver,
        CASE 
            WHEN order_delivered_customer_date::TIMESTAMP > order_estimated_delivery_date::TIMESTAMP THEN 'Delayed'
            WHEN order_delivered_customer_date::TIMESTAMP <= order_estimated_delivery_date::TIMESTAMP THEN 'On Time'
            ELSE 'Unknown'
        END AS delivery_status
    FROM orders
    WHERE order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
)

SELECT 
    om.order_id,
    c.customer_state, -- THE MISSING PIECE!
    c.customer_city,  -- THE MISSING PIECE!
    om.order_purchase_timestamp,
    om.actual_days_to_deliver,
    om.delivery_status,
    r.review_score,
    p.product_category_name,
    oi.price,
    oi.freight_value
FROM order_metrics om
-- Join the customers table using the customer_id we just added
LEFT JOIN customers c ON om.customer_id = c.customer_id
LEFT JOIN order_reviews r ON om.order_id = r.order_id
LEFT JOIN order_items oi ON om.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id;