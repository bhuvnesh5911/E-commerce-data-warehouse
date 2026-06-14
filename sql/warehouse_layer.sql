--create warehouse
--1.for customers
CREATE TABLE warehouse.dim_customers AS
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM staging.stg_customers;
--2.for products
CREATE TABLE warehouse.dim_products AS
SELECT DISTINCT
    product_id,
    product_category_name,
    product_category_name_english,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM staging.stg_products;
--3.for sellers
CREATE TABLE warehouse.dim_sellers AS
SELECT DISTINCT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM staging.stg_sellers;
--4.for dim_date
CREATE TABLE warehouse.dim_date AS
SELECT DISTINCT
    DATE(order_purchase_timestamp::timestamp) AS order_date,
    EXTRACT(YEAR FROM order_purchase_timestamp::timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp::timestamp) AS month,
    EXTRACT(DAY FROM order_purchase_timestamp::timestamp) AS day,
    EXTRACT(QUARTER FROM order_purchase_timestamp::timestamp) AS quarter,
    EXTRACT(DOW FROM order_purchase_timestamp::timestamp) AS day_of_week
FROM staging.stg_orders
WHERE order_purchase_timestamp IS NOT NULL;
--5.for fact_sales
CREATE TABLE warehouse.fact_sales AS
SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date
FROM staging.stg_order_items oi
JOIN staging.stg_orders o
    ON oi.order_id = o.order_id;
--6.for fact_payments
CREATE TABLE warehouse.fact_payments AS
SELECT DISTINCT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM staging.stg_order_payments;
--7.for fact_reviews
CREATE TABLE warehouse.fact_reviews AS
SELECT DISTINCT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM staging.stg_order_reviews;
--8.for dim_geolocation
CREATE TABLE warehouse.dim_geolocation AS
SELECT
    geolocation_zip_code_prefix,
    MIN(geolocation_city) AS geolocation_city,
    MIN(geolocation_state) AS geolocation_state,
    AVG(geolocation_lat) AS geolocation_lat,
    AVG(geolocation_lng) AS geolocation_lng
FROM staging.stg_geolocation
GROUP BY geolocation_zip_code_prefix;