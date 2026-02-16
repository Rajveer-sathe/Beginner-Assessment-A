
import pandas as pd
url='https://raw.githubusercontent.com/supreme-leader-de/Beginner-Assessment-A/refs/heads/main/Python-Challenge/sales_data.csv'
df=pd.read_csv(url,index_col=False)
df=df.dropna(subset=['Order ID','Product'])
df['Price Each']=df['Price Each'].fillna(df.groupby('Product')['Price Each'].transform('mean'))
df['Order Date']=pd.to_datetime(df['Order Date'])
df['total_sales']=df['Quantity Ordered']*df['Price Each']
df['Month']=df['Order Date'].dt.month
monthly_product_sales = df.groupby(['Month', 'Product'])['Quantity Ordered'].count()
monthly_product_sales_df = monthly_product_sales.reset_index()
best_selling_products_per_month = monthly_product_sales_df.loc[monthly_product_sales_df.groupby('Month')['Quantity Ordered'].idxmax()]
print(best_selling_products_per_month)
monthly_revenue = df.groupby('Month')['total_sales'].sum()
print(monthly_revenue)