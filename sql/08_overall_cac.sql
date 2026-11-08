-- Шаг 8. Общий CAC

SELECT
    ROUND(SUM(cost) / (SELECT COUNT(*) FROM port_customers), 2) AS overall_cac
FROM port_costs;