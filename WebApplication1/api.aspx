<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exchange Rates</title>
    <script>
        async function fetchRates() {
            try {
                const response = await fetch('http://localhost:8000/rates');
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const data = await response.json();
                const ratesDiv = document.getElementById('rates');
                ratesDiv.innerHTML = ''; // Clear previous data
                data.forEach(rate => {
                    const rateElement = document.createElement('p');
                    rateElement.textContent = `${rate.CurrencyPair}: ${rate.Rate} (Timestamp: ${rate.Timestamp})`;
                    ratesDiv.appendChild(rateElement);
                });
            } catch (error) {
                console.error('Error fetching rates:', error);
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            fetchRates();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Exchange Rates</h1>
            <div id="rates"></div>
        </div>
    </form>
</body>
</html>
