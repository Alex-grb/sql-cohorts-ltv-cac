-- Шаг 9. LTV по каналам привлечения

SELECT
    cu.channel,
    ROUND(AVG(o.total_revenue), 2) AS ltv_by_channel
FROM port_customers cu
JOIN (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM port_orders
    GROUP BY customer_id
) o
    ON cu.customer_id = o.customer_id
GROUP BY cu.channel;