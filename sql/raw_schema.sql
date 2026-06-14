SELECT schema_name
FROM information_schema.schemata;


CREATE TABLE raw_customers (
	customer_id TEXT,
	customer_unique_id TEXT,
	customer_zip_code_prefix TEXT,
	customer_city TEXT,
	customer_state TEXT
	
);

CREATE TABLE raw_geolocation (
	geolocation_zip_code_prefix TEXT,
	geolocation_lat NUMERIC(8,6),
	geolocation_lng NUMERIC(9,6),
	geolocation_city TEXT,
	geolocation_state TEXT
	
);


CREATE TABLE raw_orders_items (
	order_id TEXT,
	order_item_id TEXT,
	product_id TEXT,
	seller_id TEXT,
	shipping_limit_date DATE,
	price NUMERIC(10,2),
	freight_value NUMERIC(10,2)
	
);

CREATE TABLE raw_orders_payments (
	order_id TEXT,
	payment_sequential INT,
	payment_type TEXT,
	payment_installments INT,
	payment_value NUMERIC(10,2)
);

CREATE TABLE raw_orders_reviews (
	review_id TEXT,
	order_id TEXT,
	review_score INT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date DATE,
	review_answer_timestamp TIMESTAMPTZ
	
);


CREATE TABLE raw_orders (
	order_id TEXT,
	customer_id TEXT,
	order_status TEXT,
	order_purchase_timestamp TIMESTAMPTZ,
	order_approved_at TIMESTAMPTZ,
	order_delivered_carrier_date TIMESTAMPTZ,
	order_delivered_customer_date TIMESTAMPTZ,
	order_estimated_delivery_date TIMESTAMPTZ
	
);

CREATE TABLE raw_products (
	product_id TEXT,
	product_category_name TEXT,
	product_name_lenght INT,
	product_description_lenght INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
);

CREATE TABLE raw_sellers (
	seller_id TEXT,
	seller_zip_code_prefix TEXT,
	seller_city TEXT,
	seller_state TEXT
);

CREATE TABLE raw_product_category_translation (
	product_category_name TEXT,
	product_category_name_english TEXT
);