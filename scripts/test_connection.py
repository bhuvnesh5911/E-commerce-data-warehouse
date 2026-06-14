from sqlalchemy import create_engine

engine = create_engine(
    "postgresql://postgres:1007@localhost:5432/olist_dw"
)

try:
    conn = engine.connect()
    print("✅ Connection SUCCESS bhuvii!")
    conn.close()
except Exception as e:
    print("❌ Error:", e)