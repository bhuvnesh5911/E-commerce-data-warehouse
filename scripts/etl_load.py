import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "postgresql://postgres:1007@localhost:5432/olist_dw"
)

files = {
    "raw_customers": "../raw_data/olist_customers_dataset.csv",
    "raw_geolocation": "../raw_data/olist_geolocation_dataset.csv",
    "raw_order_items": "../raw_data/olist_order_items_dataset.csv",
    "raw_order_payments": "../raw_data/olist_order_payments_dataset.csv",
    "raw_order_reviews": "../raw_data/olist_order_reviews_dataset.csv",
    "raw_orders": "../raw_data/olist_orders_dataset.csv",
    "raw_products": "../raw_data/olist_products_dataset.csv",
    "raw_sellers": "../raw_data/olist_sellers_dataset.csv",
    "raw_product_category_translation": "../raw_data/product_category_name_translation.csv"
}

for table, file in files.items():
    df = pd.read_csv(file)

    df.to_sql(
        table,
        engine,
        schema="raw",
        if_exists="append",
        index=False
    )

    print(f"{table} loaded successfully 🚀")