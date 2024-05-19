import pandas as pd
from datetime import datetime
import matplotlib.pyplot as plt
from statsmodels.tsa.arima.model import ARIMA
import warnings
import psycopg2
import csv
warnings.filterwarnings('ignore')



# Подключение к базе данных
conn = psycopg2.connect(
    dbname='postgres',
    user='postgres',
    password='12345',
    host='localhost',
    port='5432'
)
cur = conn.cursor()

# Выполнение SQL запроса
cur.execute("SELECT * FROM manufactured_products")

# Получение результатов
rows = cur.fetchall()
column_names = [desc[0] for desc in cur.description]

# Запись в CSV файл
with open('file.csv', 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(column_names)
    csvwriter.writerows(rows)

# Закрытие соединения
cur.close()
conn.close()

# 1. Загрузка данных из CSV файла
df = pd.read_csv('file.csv')

# 2. Преобразование столбца DateOfManufact в формат даты
df['DateOfManufact'] = pd.to_datetime(df['DateOfManufact'])

# 3. Агрегирование данных по типу продукта и месяцу
df['Month'] = df['DateOfManufact'].dt.to_period('M')
grouped_df = df.groupby(['idProduct', 'Month']).size().reset_index(name='sales_count')
grouped_df['Month'] = grouped_df['Month'].dt.to_timestamp()

print(grouped_df)


def forecast_sales(product_type, steps=1):
    product_df = grouped_df[grouped_df['idProduct'] == product_type]
    product_df = product_df.set_index('Month').asfreq('MS').fillna(0)  # MS = Month Start

    if product_df.empty:
        raise ValueError(f"Продукт не продовали {product_type}")

    
    # Построение модели ARIMA
    model = ARIMA(product_df['sales_count'], order=(1, 1, 1))
    model_fit = model.fit()

    # Прогнозирование
    forecast = model_fit.forecast(steps=steps)
    
    plt.figure(figsize=(10, 5))
    plt.plot(product_df.index, product_df['sales_count'], label='База')
    plt.plot(forecast.index, forecast, label='Прогноз', linestyle='--')
    plt.title(f'Прогно показателя продаж продукта {product_type}')
    plt.xlabel('Дата')
    plt.ylabel('Кол-во продаж')
    plt.legend()
    plt.grid(True)
    plt.xticks(pd.date_range(start=product_df.index.min(), end=(forecast.index.max() + pd.DateOffset(months=1)), freq='MS'), rotation=45)
    plt.show()

    return forecast


content = ""

with open('producttype.txt', 'r', encoding='utf-8') as file:
    content = file.read()


next_month_forecast = forecast_sales(int(content), steps=2)
print("Next Month Forecast:", next_month_forecast)


