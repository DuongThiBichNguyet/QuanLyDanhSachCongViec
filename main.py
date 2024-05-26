from fastapi import FastAPI
from fastapi.responses import FileResponse
import pyodbc

app = FastAPI()

# Cấu hình kết nối MSSQL
server = '127.0.0.1,1443'
database = 'ExchangeRatesDB'
username = 'sa'
password = '123'
connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'

@app.get("/")
async def read_root():
    return {"message": "Welcome to the Exchange Rates API"}

@app.get("/rates")
def read_rates():
    with pyodbc.connect(connection_string) as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM ExchangeRates ORDER BY Timestamp DESC")
        rows = cursor.fetchall()
        return [{"CurrencyPair": row.CurrencyPair, "Rate": row.Rate, "Timestamp": row.Timestamp} for row in rows]

@app.get("/favicon.ico", include_in_schema=False)
async def favicon():
    return FileResponse("path/to/your/favicon.ico")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=8000)
