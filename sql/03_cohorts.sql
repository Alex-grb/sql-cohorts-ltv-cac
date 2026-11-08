-- Шаг 3. Когорты по месяцу первого заказа

WITH first_orders AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_date))::date AS cohort_month
    FROM port_orders
    GROUP BY customer_id
)
SELECT
    cohort_month,
    COUNT(customer_id) AS customers
FROM first_orders
GROUP BY cohort_month
ORDER BY cohort_month;