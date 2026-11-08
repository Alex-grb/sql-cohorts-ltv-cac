-- Шаг 7. CAC по каналам привлечения

SELECT
    cu.channel,
    COUNT(cu.customer_id) AS customers,
    MAX(c.cost) AS total_cost,
    ROUND(MAX(c.cost) / COUNT(cu.customer_id), 2) AS cac_by_channel
FROM port_customers cu
JOIN port_costs c
    ON c.channel = cu.channel
GROUP BY cu.channel;