// Area Chart
let optionsAreaChart = {
    series: [
        {
            name: "Visit",
            data: [
                10877, 29334, 33233, 36439, 32675, 32333, 33457, 38345, 36783, 30457,
                28459, 29840,
            ],
        },
        {
            name: "Click",
            data: [
                8753, 21313, 24623, 28935, 27345, 23465, 27813, 29125, 26256, 24356,
                20233, 24570,
            ],
        },
        {
            name: "Sales",
            data: [
                6000, 11313, 14623, 18935, 17345, 13465, 17813, 19125, 16256, 20356,
                16233, 14570,
            ],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "area",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    labels: {
        style: {
            fontSize: "14px",
        },
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
        row: {
            opacity: 0.5,
        },
    },
    fill: {
        opacity: 1,
        type: "solid",
    },
    stroke: {
        show: true,
        width: 4,
        curve: "straight",
        colors: ["transparent"],
    },
    xaxis: {
        axisTicks: {
            show: false,
            borderType: "solid",
            color: "#78909C",
            height: 6,
            offsetX: 0,
            offsetY: 0,
        },

        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
        categories: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
        ],
    },
    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
        markers: {
            radius: 12,
        },
    },
    colors: ["#EBFAFA", "#55B1F3", "#0010F7"],

    yaxis: {
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
            formatter: (value) => {
                return value / 1000 + "K";
            },
        },

        min: 0,
        max: 40000,
        tickAmount: 4,
    },
};

if (document.querySelector("#area-chart")) {
    let chart = new ApexCharts(document.querySelector("#area-chart"), optionsAreaChart);
    chart.render();
}

// Bar Chart
let optionsBarChart = {
    series: [
        {
            name: "Expenses",
            data: [4477, 7834, 8233, 6039, 5575, 6933, 6357],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "bar",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    plotOptions: {
        bar: {
            borderRadius: 4,
            horizontal: true,
        },
    },
    labels: {
        style: {
            fontSize: "14px",
        },
    },
    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
        row: {
            opacity: 0.5,
        },
    },
    fill: {
        opacity: 1,
        type: "solid",
    },
    stroke: {
        show: true,
        width: 4,
        curve: "straight",
        colors: ["transparent"],
    },
    xaxis: {
        axisTicks: {
            show: false,
        },
        tickAmount: 5,
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
        categories: [
            "Sun, 23",
            "Sat, 22",
            "Fri, 21",
            "Thu, 20",
            "Wed, 19",
            "Tue, 18",
            "Mon, 17",
        ],
    },
    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
        markers: {
            radius: 12,
        },
    },
    colors: ["#0063F7"],

    yaxis: {
        reversed: $("body").hasClass("direction-end") ? true : false,
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
    },
};

if (document.querySelector("#bar-chart")) {
    setTimeout(() => {
        let chart = new ApexCharts(document.querySelector("#bar-chart"), optionsBarChart);
        chart.render();
    }, 300);
}

// Candlestick Chart
let optionsCandlestickChart = {
    series: [
        {
            data: [
                {
                    x: new Date(1538778600000),
                    y: [6629.81, 6650.5, 6623.04, 6633.33],
                },
                {
                    x: new Date(1538780400000),
                    y: [6632.01, 6643.59, 6620, 6630.11],
                },
                {
                    x: new Date(1538782200000),
                    y: [6630.71, 6648.95, 6623.34, 6635.65],
                },
                {
                    x: new Date(1538784000000),
                    y: [6635.65, 6651, 6629.67, 6638.24],
                },
                {
                    x: new Date(1538785800000),
                    y: [6638.24, 6640, 6620, 6624.47],
                },
                {
                    x: new Date(1538787600000),
                    y: [6624.53, 6636.03, 6621.68, 6624.31],
                },
                {
                    x: new Date(1538789400000),
                    y: [6624.61, 6632.2, 6617, 6626.02],
                },
                {
                    x: new Date(1538791200000),
                    y: [6627, 6627.62, 6584.22, 6603.02],
                },
                {
                    x: new Date(1538793000000),
                    y: [6605, 6608.03, 6598.95, 6604.01],
                },
                {
                    x: new Date(1538794800000),
                    y: [6604.5, 6614.4, 6602.26, 6608.02],
                },
                {
                    x: new Date(1538796600000),
                    y: [6608.02, 6610.68, 6601.99, 6608.91],
                },
                {
                    x: new Date(1538798400000),
                    y: [6608.91, 6618.99, 6608.01, 6612],
                },
                {
                    x: new Date(1538800200000),
                    y: [6612, 6615.13, 6605.09, 6612],
                },
                {
                    x: new Date(1538802000000),
                    y: [6612, 6624.12, 6608.43, 6622.95],
                },
                {
                    x: new Date(1538803800000),
                    y: [6623.91, 6623.91, 6615, 6615.67],
                },
                {
                    x: new Date(1538805600000),
                    y: [6618.69, 6618.74, 6610, 6610.4],
                },
                {
                    x: new Date(1538807400000),
                    y: [6611, 6622.78, 6610.4, 6614.9],
                },
                {
                    x: new Date(1538809200000),
                    y: [6614.9, 6626.2, 6613.33, 6623.45],
                },
                {
                    x: new Date(1538811000000),
                    y: [6623.48, 6627, 6618.38, 6620.35],
                },
                {
                    x: new Date(1538812800000),
                    y: [6619.43, 6620.35, 6610.05, 6615.53],
                },
                {
                    x: new Date(1538814600000),
                    y: [6615.53, 6617.93, 6610, 6615.19],
                },
                {
                    x: new Date(1538816400000),
                    y: [6615.19, 6621.6, 6608.2, 6620],
                },
                {
                    x: new Date(1538818200000),
                    y: [6619.54, 6625.17, 6614.15, 6620],
                },
                {
                    x: new Date(1538820000000),
                    y: [6620.33, 6634.15, 6617.24, 6624.61],
                },
                {
                    x: new Date(1538821800000),
                    y: [6625.95, 6626, 6611.66, 6617.58],
                },
                {
                    x: new Date(1538823600000),
                    y: [6619, 6625.97, 6595.27, 6598.86],
                },
                {
                    x: new Date(1538825400000),
                    y: [6598.86, 6598.88, 6570, 6587.16],
                },
                {
                    x: new Date(1538827200000),
                    y: [6588.86, 6600, 6580, 6593.4],
                },
            ],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "candlestick",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: true,
        },
    },
    plotOptions: {
        candlestick: {
            colors: {
                upward: "#00F7BF",
                downward: "#FF0022",
            },
            wick: {
                useFillColor: true,
            },
        },
    },

    labels: {
        style: {
            fontSize: "14px",
        },
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
    },
    fill: {
        opacity: 1,
        type: "solid",
    },

    xaxis: {
        type: "datetime",
        axisTicks: {
            show: false,
        },

        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
    },
    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
        markers: {
            radius: 12,
        },
    },
    yaxis: {
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
    },
};

if (document.querySelector("#candlestick-chart")) {
    let chart = new ApexCharts(document.querySelector("#candlestick-chart"), optionsCandlestickChart);
    chart.render();
}

// Column Chart
let optionsColumnChart = {
    series: [
        {
            name: "Earning",
            data: [
                28877, 29334, 33233, 36439, 32675, 32333, 33457, 38345, 36783, 39457,
                22459, 39840,
            ],
        },
        {
            name: "Expense",
            data: [
                12010, 11313, 14623, 18935, 17345, 13465, 17813, 19125, 16256, 20356,
                12233, 14570,
            ],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "bar",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    labels: {
        style: {
            fontSize: "14px",
        },
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
        row: {
            opacity: 0.5,
        },
    },
    plotOptions: {
        bar: {
            horizontal: false,
            borderRadius: 2,
            columnWidth: "45%",
            endingShape: "rounded",
        },
        colors: {
            backgroundBarColors: ["#0063F7", "#00F7BF"],
        },
    },

    stroke: {
        show: true,
        width: 4,
        colors: ["transparent"],
    },
    xaxis: {
        axisTicks: {
            show: false,
            borderType: "solid",
            color: "#78909C",
            height: 6,
            offsetX: 0,
            offsetY: 0,
        },

        tickPlacement: "between",
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
        categories: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
        ],
    },
    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
        markers: {
            radius: 12,
        },
    },
    yaxis: {
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
            formatter: (value) => {
                return value / 1000 + "K";
            },
        },

        min: 0,
        max: 40000,
        tickAmount: 4,
    },
};

if (document.querySelector("#column-chart")) {
    let chart = new ApexCharts(document.querySelector("#column-chart"), optionsColumnChart);
    chart.render();
}

// Donut Chart
let optionsDonutChart = {
    series: [1244, 2155, 1541],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "donut",
        height: 398,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#0010F7", "#55B1F3", "#1BE7FF"],

    labels: ["Marketing", "Payments", "Bills"],

    dataLabels: {
        enabled: false,
    },
    plotOptions: {
        pie: {
            donut: {
                size: "85%",
                labels: {
                    show: true,
                    name: {
                        fontSize: "2rem",
                    },
                    value: {
                        fontSize: "16px",
                        formatter(val) {
                            return `$ ${val}`;
                        },
                    },
                    total: {
                        show: true,
                        fontSize: "16px",
                        label: "Total",
                        formatter: function (w) {
                            return `$ ${w.globals.seriesTotals.reduce((a, b) => {
                                return a + b;
                            }, 0)}`;
                        },
                    },
                },
            },
        },
    },

    legend: {
        itemMargin: {
            horizontal: 24,
            vertical: 0,
        },
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "14px",

        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#donut-chart")) {
    let chart = new ApexCharts(document.querySelector("#donut-chart"), optionsDonutChart);
    chart.render();
}

// Heatmap Chart
function generateData(count, yrange) {
    let i = 0;
    const series = [];
    while (i < count) {
        const x = `w${(i + 1).toString()}`;
        const y =
            Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;

        series.push({
            x,
            y,
        });
        i++;
    }
    return series;
}

let optionsHeatmapChart = {
    series: [
        {
            name: "SUN",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
        {
            name: "MON",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
        {
            name: "TUE",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
        {
            name: "WED",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
        {
            name: "THU",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
        {
            name: "FRI",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
        {
            name: "SAT",
            data: generateData(24, {
                min: 0,
                max: 40,
            }),
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "heatmap",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: true,
        },
    },
    plotOptions: {
        heatmap: {
            enableShades: false,
            colorScale: {
                ranges: [
                    {
                        from: 0,
                        to: 10,
                        name: "0-10",
                        color: "#EBFAFA",
                    },
                    {
                        from: 11,
                        to: 20,
                        name: "10-20",
                        color: "#55B1F3",
                    },
                    {
                        from: 21,
                        to: 30,
                        name: "20-30",
                        color: "#0063F7",
                    },
                    {
                        from: 31,
                        to: 40,
                        name: "30-40",
                        color: "#0010F7",
                    },
                ],
            },
        },
    },

    labels: {
        style: {
            fontSize: "14px",
        },
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
    },
    fill: {
        opacity: 1,
        type: "solid",
    },

    xaxis: {
        labels: {
            show: false,
        },
        axisBorder: {
            show: false,
        },
        axisTicks: {
            show: false,
        },
    },
    legend: {
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "14px",
        markers: {
            radius: 12,
        },
    },
    yaxis: {
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
    },
};

if (document.querySelector("#heatmap-chart")) {
    let chart = new ApexCharts(document.querySelector("#heatmap-chart"), optionsHeatmapChart);
    chart.render();
}

// Line Chart
let optionsLineChart = {
    series: [
        {
            name: "Ads",
            data: [
                28877, 29334, 33233, 36439, 32675, 32333, 33457, 38345, 36783, 39457,
                22459, 39840,
            ],
        },
        {
            name: "Organic",
            data: [
                12010, 11313, 14623, 18935, 17345, 13465, 17813, 19125, 16256, 20356,
                12233, 14570,
            ],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "line",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#0063F7", "#1BE7FF"],
    labels: {
        style: {
            fontSize: "14px",
        },
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
        row: {
            opacity: 0.5,
        },
    },

    markers: {
        strokeWidth: 0,
        size: 6,
        colors: ["#0063F7", "#1BE7FF"],
        hover: {
            sizeOffset: 1,
        },
    },
    xaxis: {
        axisTicks: {
            show: false,
            borderType: "solid",
            color: "#78909C",
            height: 6,
            offsetX: 0,
            offsetY: 0,
        },

        tickPlacement: "between",
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
        categories: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
        ],
    },
    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
    },
    yaxis: {
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
            formatter: (value) => {
                return value / 1000 + "K";
            },
        },

        min: 0,
        max: 40000,
        tickAmount: 4,
    },
};

if (document.querySelector("#line-chart")) {
    let chart = new ApexCharts(document.querySelector("#line-chart"), optionsLineChart);
    chart.render();
}

// Radar Chart
let optionsRadarChart = {
    series: [
        {
            name: "Sales",
            data: [80, 50, 30, 40, 100, 20],
        },
        {
            name: "Expense",
            data: [20, 30, 40, 80, 20, 80],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        height: 350,
        type: "radar",
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
        dropShadow: {
            enabled: true,
            blur: 4,
            left: 1,
            top: 1,
            opacity: 0.1,
        },
    },
    fill: {
        opacity: [1, 1],
    },
    stroke: {
        show: false,
        width: 0,
    },
    markers: {
        size: 0,
    },

    colors: ["#0010F7", "#1BE7FF"],

    labels: ["Marketing", "Payments", "Bills"],

    dataLabels: {
        enabled: false,
    },
    yaxis: {
        show: false,
    },
    xaxis: {
        categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
    },

    plotOptions: {
        radar: {
            polygons: {
                connectorColors: "#fff",
            },
        },
    },

    legend: {
        itemMargin: {
            horizontal: 24,
            vertical: 0,
        },
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "16px",

        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#radar-chart")) {
    let chart = new ApexCharts(document.querySelector("#radar-chart"), optionsRadarChart);
    chart.render();
}

// Radialbar Chart
let optionsRadialbarChart = {
    series: [61, 82, 65],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "radialBar",
        height: 398,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#00F7BF", "#0010F7", "#FFC700"],

    labels: ["Ebay", "Amazon", "Web"],

    dataLabels: {
        enabled: false,
    },
    stroke: {
        lineCap: "round",
    },

    plotOptions: {
        radialBar: {
            size: 185,
            hollow: {
                size: "25%",
            },

            track: {
                margin: 16,
            },
            dataLabels: {
                show: true,
                name: {
                    fontSize: "16px",
                },
                value: {
                    fontSize: "16px",
                },
                total: {
                    show: true,
                    fontSize: "16px",
                    label: "Total",
                    formatter: function (w) {
                        return 7400;
                    },
                },
            },
        },
    },

    legend: {
        show: true,
        itemMargin: {
            horizontal: 24,
            vertical: 0,
        },
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "16px",

        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#radialbar-chart")) {
    let chart = new ApexCharts(document.querySelector("#radialbar-chart"), optionsRadialbarChart);
    chart.render();
}

// Scatter Chart
let optionsScatterChart = {
    series: [
        {
            name: "Nike",
            data: [
                [16.4, 5.4],
                [21.7, 2],
                [25.4, 3],
                [19, 2],
                [10.9, 1],
                [13.6, 3.2],
                [10.9, 7.4],
                [10.9, 0],
                [10.9, 8.2],
                [16.4, 0],
                [16.4, 1.8],
                [13.6, 0.3],
                [13.6, 0],
                [29.9, 0],
                [27.1, 2.3],
                [16.4, 0],
                [13.6, 3.7],
                [10.9, 5.2],
                [16.4, 6.5],
                [10.9, 0],
                [24.5, 7.1],
                [10.9, 0],
                [8.1, 4.7],
                [19, 0],
                [21.7, 1.8],
                [27.1, 0],
                [24.5, 0],
                [27.1, 0],
                [29.9, 1.5],
                [27.1, 0.8],
                [22.1, 2],
            ],
        },
        {
            name: "Adidas",
            data: [
                [36.4, 13.4],
                [1.7, 11],
                [5.4, 8],
                [9, 17],
                [1.9, 4],
                [3.6, 12.2],
                [1.9, 14.4],
                [1.9, 9],
                [1.9, 13.2],
                [1.4, 7],
                [6.4, 8.8],
                [3.6, 4.3],
                [1.6, 10],
                [9.9, 2],
                [7.1, 15],
                [1.4, 0],
                [3.6, 13.7],
                [1.9, 15.2],
                [6.4, 16.5],
                [0.9, 10],
                [4.5, 17.1],
                [10.9, 10],
                [0.1, 14.7],
                [9, 10],
                [12.7, 11.8],
                [2.1, 10],
                [2.5, 10],
                [27.1, 10],
                [2.9, 11.5],
                [7.1, 10.8],
                [2.1, 12],
            ],
        },
        {
            name: "Puma",
            data: [
                [21.7, 3],
                [23.6, 3.5],
                [24.6, 3],
                [29.9, 3],
                [21.7, 20],
                [23, 2],
                [10.9, 3],
                [28, 4],
                [27.1, 0.3],
                [16.4, 4],
                [13.6, 0],
                [19, 5],
                [22.4, 3],
                [24.5, 3],
                [32.6, 3],
                [27.1, 4],
                [29.6, 6],
                [31.6, 8],
                [21.6, 5],
                [20.9, 4],
                [22.4, 0],
                [32.6, 10.3],
                [29.7, 20.8],
                [24.5, 0.8],
                [21.4, 0],
                [21.7, 6.9],
                [28.6, 7.7],
                [15.4, 0],
                [18.1, 0],
                [33.4, 0],
                [16.4, 0],
            ],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "scatter",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: true,
        },
    },
    labels: {
        style: {
            fontSize: "14px",
        },
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        borderColor: "#DFE6E9",
        row: {
            opacity: 0.5,
        },
    },
    fill: {
        opacity: 1,
        type: "solid",
    },
    stroke: {
        show: true,
        width: 4,
        curve: "straight",
        colors: ["transparent"],
    },
    xaxis: {
        axisTicks: {
            show: false,
        },

        tickAmount: 10,
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
            formatter: function (val) {
                return parseFloat(val).toFixed(1);
            },
        },
    },

    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
        markers: {
            radius: 12,
        },
    },
    colors: ["#00F7BF", "#55B1F3", "#0010F7"],

    yaxis: {
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },

        tickAmount: 7,
    },
};

if (document.querySelector("#scatter-chart")) {
    let chart = new ApexCharts(document.querySelector("#scatter-chart"), optionsScatterChart);
    chart.render();
}

// Dashboard Ecommerce Earning Donut Card
let optionsEcommerceEarningDonutCard = {
    series: [1244, 2155, 1541],
    chart: {
        id: "earnings-donut-card",
        fontFamily: "Manrope, sans-serif",
        type: "donut",
        height: 350,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#0063F7", "#98FFE0", "#1BE7FF"],

    labels: ["Online", "Offline", "Marketing"],

    dataLabels: {
        enabled: false,
    },

    plotOptions: {
        pie: {
            donut: {
                size: "90%",
                labels: {
                    show: true,
                    name: {
                        fontSize: "2rem",
                    },
                    value: {
                        fontSize: "24px",
                        fontWeight: "regular",
                        color: "B2BEC3",
                        formatter(val) {
                            return `%${Math.round(val / 100)}`;
                        },
                    },
                    total: {
                        show: true,
                        fontSize: "24px",
                        fontWeight: "regular",
                        label: "Kitchen",
                        color: "#636E72",

                        formatter: function (w) {
                            return `%${w.globals.seriesTotals.reduce((a, b) => {
                                return Math.round((a + b) / 100);
                            }, 0)}`;
                        },
                    },
                },
            },
        },
    },
    responsive: [
        {
            breakpoint: 426,
            options: {
                legend: {
                    itemMargin: {
                        horizontal: 16,
                        vertical: 8,
                    },
                },
            },
        },
    ],

    legend: {
        itemMargin: {
            horizontal: 12,
            vertical: 24,
        },
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "12px",
        inverseOrder: true,
        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#earnings-donut-card")) {
    let chart = new ApexCharts(document.querySelector("#earnings-donut-card"), optionsEcommerceEarningDonutCard);
    chart.render();
}

// Dashboard Analytics
let optionsAnalyticsBalanceChart = {
    series: [
        {
            name: "Balance",
            data: [
                28877, 29334, 33233, 36439, 32675, 32333, 33457, 38345, 36783,
                39457, 22459, 39840,
            ],
        },
    ],
    fill: {
        opacity: 1,
        colors: [
            document.body.classList.contains("dark") ? "#ffffff" : "#2D3436"
        ],
    },
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "bar",
        height: "250",
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    labels: {
        style: {
            fontSize: "14px",
        },
    },
    dataLabels: {
        enabled: false,
    },
    grid: {
        borderColor: "#B2BEC3",
        opacity: 1,
    },
    plotOptions: {
        bar: {
            horizontal: false,
            borderRadius: 2,
            columnWidth: "60%",
            colors: {
                backgroundBarColors: ["#B2BEC3"],
                backgroundBarOpacity: 0.2,
            },
        },
    },
    stroke: {
        show: true,
        width: 4,
        colors: ["transparent"],
    },
    xaxis: {
        axisTicks: {
            show: false,
            borderType: "solid",
            height: 6,
            offsetX: 0,
            offsetY: 0,
        },
        tickPlacement: "between",
        labels: {
            style: {
                colors: [
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                    "#B2BEC3",
                ],
                fontSize: "12px",
            },
        },
        categories: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
        ],
    },
    legend: {
        horizontalAlign: "right",
        offsetX: 40,
        position: "top",
        markers: {
            radius: 12,
        },
    },
    yaxis: {
        labels: {
            style: {
                colors: ["#636E72"],
                fontSize: "14px",
            },
            formatter: (value) => {
                return value == "0" ? value / 1000 : value / 1000 + "K";
            },
        },
        min: 0,
        max: 60000,
        tickAmount: 4,
    }
};

if (document.querySelector("#dashboard-analytics-balance-chart")) {
    let chart = new ApexCharts(document.querySelector("#dashboard-analytics-balance-chart"), optionsAnalyticsBalanceChart);
    chart.render();
}
