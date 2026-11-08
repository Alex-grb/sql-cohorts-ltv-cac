-- Шаг 6. LTV — средняя выручка с клиента за всё время

SELECT
    ROUND(AVG(total_revenue), 2) AS ltv
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM port_orders
    GROUP BY customer_id
) AS revenue_per_customer;