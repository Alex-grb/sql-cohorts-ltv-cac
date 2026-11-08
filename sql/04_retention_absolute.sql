-- Шаг 4. Retention по когортам в абсолютных числах

WITH first_orders AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_date))::date AS cohort_month
    FROM port_orders
    GROUP BY customer_id
),
orders_with_months AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date)::date AS order_month
    FROM port_orders
)
SELECT
    f.cohort_month,
    COUNT(DISTINCT f.customer_id) AS cohort_size,
    COUNT(DISTINCT CASE WHEN o.order_month = f.cohort_month + INTERVAL '1 month' THEN o.customer_id END) AS month_1,
    COUNT(DISTINCT CASE WHEN o.order_month = f.cohort_month + INTERVAL '2 months' THEN o.customer_id END) AS month_2,
    COUNT(DISTINCT CASE WHEN o.order_month = f.cohort_month + INTERVAL '3 months' THEN o.customer_id END) AS month_3
FROM first_orders f
JOIN orders_with_months o
    ON f.customer_id = o.customer_id
GROUP BY f.cohort_month
ORDER BY f.cohort_month;