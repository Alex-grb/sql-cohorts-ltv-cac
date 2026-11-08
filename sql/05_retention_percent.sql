-- Шаг 5. Retention по когортам в процентах

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
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN o.order_month = f.cohort_month + INTERVAL '1 month' THEN o.customer_id END) / COUNT(DISTINCT f.customer_id), 1) AS month_1_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN o.order_month = f.cohort_month + INTERVAL '2 months' THEN o.customer_id END) / COUNT(DISTINCT f.customer_id), 1) AS month_2_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN o.order_month = f.cohort_month + INTERVAL '3 months' THEN o.customer_id END) / COUNT(DISTINCT f.customer_id), 1) AS month_3_pct
FROM first_orders f
JOIN orders_with_months o
    ON f.customer_id = o.customer_id
GROUP BY f.cohort_month
ORDER BY f.cohort_month;