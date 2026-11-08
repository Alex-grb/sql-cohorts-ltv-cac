-- Шаг 1. Создание таблиц

DROP TABLE IF EXISTS port_orders;
DROP TABLE IF EXISTS port_customers;
DROP TABLE IF EXISTS port_costs;

CREATE TABLE port_customers (
    customer_id INT PRIMARY KEY,
    registration_date DATE,
    channel VARCHAR(20)
);

CREATE TABLE port_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES port_customers(customer_id),
    order_date DATE,
    amount DECIMAL(10, 2)
);

CREATE TABLE port_costs (
    channel VARCHAR(20) PRIMARY KEY,
    cost DECIMAL(10, 2)
);