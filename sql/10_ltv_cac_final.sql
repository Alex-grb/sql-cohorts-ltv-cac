WITH ltv_by_channel AS (
    SELECT
        cu.channel,
        ROUND(AVG(o.total_revenue), 2) AS ltv
    FROM port_customers cu
    JOIN (
        SELECT
            customer_id,
            SUM(amount) AS total_revenue
        FROM port_orders
        GROUP BY customer_id
    ) o
        ON cu.customer_id = o.customer_id
    GROUP BY cu.channel
),
cac_by_channel AS (
    SELECT
        cu.channel,
        ROUND(MAX(c.cost) / COUNT(cu.customer_id), 2) AS cac
    FROM port_customers cu
    JOIN port_costs c
        ON c.channel = cu.channel
    GROUP BY cu.channel
)
SELECT
    l.channel,
    l.ltv,
    c.cac,
    ROUND(l.ltv / c.cac, 2) AS ltv_cac_ratio
FROM ltv_by_channel l
JOIN cac_by_channel c
    ON l.channel = c.channel
ORDER BY ltv_cac_ratio DESC;