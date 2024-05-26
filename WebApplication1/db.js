
$(document).ready(function () {
    $.get("http://127.0.0.1:8000/rates", function (data) {
        var a = [["Time", "Temp"]];
        for (var i of data.data) {
            var time = i.time;
            var value = parseInt(i.value);
            a.push([time, value]);
        }
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable(a);

            var options = {
                title: 'Lịch sử',
                hAxis: { title: 'Hours', titleTextStyle: { color: '#333' } },
                vAxis: { minValue: 0 }
            };

            var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        }
    });
})