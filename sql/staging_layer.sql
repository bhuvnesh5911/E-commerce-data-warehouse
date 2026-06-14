CREATE SCHEMA IF NOT EXISTS staging;
--1.for customers
CREATE TABLE staging.stg_customers AS
SELECT DISTINCT
    TRIM(customer_id) AS customer_id,
    TRIM(customer_unique_id) AS customer_unique_id,
    customer_zip_code_prefix,
    INITCAP(customer_city) AS customer_city,
    UPPER(customer_state) AS customer_state
FROM raw.raw_customers
WHERE customer_id IS NOT NULL;

--2.for orders
CREATE TABLE staging.stg_orders AS
SELECT DISTINCT *
FROM raw.raw_orders
WHERE order_id IS NOT NULL;

--3.for order items
CREATE TABLE staging.stg_order_items AS
SELECT DISTINCT *
FROM raw.raw_order_items
WHERE order_id IS NOT NULL;

--4.for order payments
CREATE TABLE staging.stg_order_payments AS
SELECT DISTINCT *
FROM raw.raw_order_payments
WHERE order_id IS NOT NULL;

--5.for order reviews
CREATE TABLE staging.stg_order_reviews AS
SELECT DISTINCT *
FROM raw.raw_order_reviews
WHERE review_id IS NOT NULL;

--6.for porducts
CREATE TABLE staging.stg_products AS
SELECT DISTINCT
    p.*,
    t.product_category_name_english
FROM raw.raw_products p
LEFT JOIN raw.raw_product_category_translation t
ON p.product_category_name = t.product_category_name
WHERE p.product_id IS NOT NULL;

--7. for sellers
CREATE TABLE staging.stg_sellers AS
SELECT DISTINCT
    TRIM(seller_id) AS seller_id,
    seller_zip_code_prefix,
    INITCAP(TRIM(seller_city)) AS seller_city,
    UPPER(TRIM(seller_state)) AS seller_state
FROM raw.raw_sellers
WHERE seller_id IS NOT NULL;


--8.for geolocation
CREATE TABLE staging.stg_geolocation AS
SELECT DISTINCT
    *
FROM raw.raw_geolocation;
