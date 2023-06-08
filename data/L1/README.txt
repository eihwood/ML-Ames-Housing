data subdir for cleaned, encoded, and dummified Ames house price and feature data

Instructions for importing with pandas read_csv:

# import csv with na_filter = False to prevent NaNs in the dataframe
df = pd.read_csv('<file path>', na_filter=False)

# convert 'numeric' categories to strings
df['ms_sub_class'] = df['ms_sub_class'].astype(str)
df['yr_sold'] = df['yr_sold'].astype(str)
df['mo_sold'] = df['mo_sold'].astype(str)

X = df.drop(columns=['pid', 'sale_price', 'log_sale_price'])
y = df['sale_price']
log_y = df['log_sale_price']