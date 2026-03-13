import pandas as pd
from sqlalchemy import create_engine

# 1. Set up the database connection

db_url = 'postgresql://postgres:admin@localhost:5432/olist_ecommerce'
engine = create_engine(db_url)

# 2. Map your SQL table names to the CSV file names

files_to_load = {
    'customers': 'olist_customers_dataset.csv',
    'orders': 'olist_orders_dataset.csv',
    'order_items': 'olist_order_items_dataset.csv',
    'products': 'olist_products_dataset.csv',
    'order_reviews': 'olist_order_reviews_dataset.csv',
    'order_payments': 'olist_order_payments_dataset.csv',
    'geolocation': 'olist_geolocation_dataset.csv',
    'sellers': 'olist_sellers_dataset.csv',
    'product_category_name_translation': 'olist_product_category_name_translation.csv',
}

# 3. Loop through the files, read them, and send them to Postgres
for table_name, file_path in files_to_load.items():
    print(f"Reading {file_path}...")
    
    # Read the CSV into a Pandas DataFrame
    df = pd.read_csv(file_path)
    
    print(f"Pushing data to the '{table_name}' table in Postgres...")
    
    # Send the data to SQL
    # if_exists='replace' means if the table already exists, it drops it and makes a fresh one
    # index=False prevents Pandas from writing its own row numbers into the database
    df.to_sql(table_name, engine, if_exists='replace', index=False)
    
    print(f"Successfully loaded {len(df)} rows into '{table_name}'!\n")

print("All datasets have been successfully loaded into the database.")