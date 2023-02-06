// Analytics Energy
let optionsAnalyticsEnergy = {
    series: [91],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "radialBar",
        id: "analytics-energy-chart",
        height: 335,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },

    plotOptions: {
        radialBar: {
            startAngle: -135,
            endAngle: 135,
            track: {
                background: "transparent",
            },
            dataLabels: {
                name: {
                    show: true,
                    fontSize: "12px",
                    fontWeight: "400",
                    color: "#636E72",
                },
                value: {
                    fontSize: "24px",
                    fontWeight: "500",
                    color: undefined,
                    formatter: function (val) {
                        return val + "%";
                    },
                },
            },
        },
    },

    stroke: {
        dashArray: 6,
    },
    labels: ["Completed"],

    fill: {
        type: "gradient",
        gradient: {
            shade: "dark",
            type: "horizontal",
            shadeIntensity: 1,
            gradientToColors: ["#0010F7", "#1BE7FF"],
            inverseColors: true,
            opacityFrom: 1,
            opacityTo: 1,
            stops: [0, 50, 100],
        },
    },
};

if (document.querySelector("#analytics-energy-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-energy-chart"), optionsAnalyticsEnergy);
    chart.render();
}

// Analytics Expenses
let optionsAnalyticsExpenses = {
    series: [1244, 2155, 1541],
    chart: {
        id: "analytics-expenses-chart",
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
                        fontSize: "24px",
                        fontWeight: "medium",
                        color: "#2D3436",
                        formatter(val) {
                            return `$${val}`;
                        },
                    },
                    total: {
                        show: true,
                        fontSize: "24px",
                        fontWeight: "medium",
                        label: "Total",
                        color: "#636E72",

                        formatter: function (w) {
                            return `$${w.globals.seriesTotals.reduce((a, b) => {
                                return a + b;
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
        fontSize: "14px",

        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#analytics-expenses-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-expenses-chart"), optionsAnalyticsExpenses);
    chart.render();
}

// Analytics Marketplace
let optionsAnalyticsMarketplace = {
    series: [61, 82, 65],
    chart: {
        height: 184,
        id: "analytics-marketplace-chart",
        fontFamily: "Manrope, sans-serif",
        type: "radialBar",
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#00F7BF", "#0010F7", "#FFC700"],

    labels: ["Ebay", "Web", "Amazon"],

    dataLabels: {
        enabled: false,
    },
    stroke: {
        lineCap: "round",
    },

    plotOptions: {
        radialBar: {
            dataLabels: {
                show: true,
                name: {
                    fontSize: "10px",
                },
                value: {
                    fontSize: "10px",
                    offsetY: 0,
                },
                total: {
                    show: true,
                    fontSize: "10px",
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
            horizontal: 0,
            vertical: 6,
        },

        horizontalAlign: "center",
        position: "left",
        fontSize: "14px",

        markers: {
            radius: 12,
        },
    },

    responsive: [
        {
            breakpoint: 325,
            options: {
                legend: {
                    itemMargin: {
                        horizontal: 8,
                        vertical: 0,
                    },
                    horizontalAlign: "center",
                    position: "bottom",
                    fontSize: "14px",
                },
            },
        },
    ],
};

if (document.querySelector("#analytics-marketplace-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-marketplace-chart"), optionsAnalyticsMarketplace);
    chart.render();
}

// Analytics Revenue 1
let optionsAnalyticsRevenue1 = {
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
        id: "analytics-revenue-chart",
        fontFamily: "Manrope, sans-serif",
        type: "bar",
        height: 300,
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

if (document.querySelector("#analytics-revenue-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-revenue-chart"), optionsAnalyticsRevenue1);
    chart.render();
}

// Analytics Revenue 2
let optionsAnalyticsRevenue2 = {
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
        id: "analytics-revenue-2-chart",
        fontFamily: "Manrope, sans-serif",
        height: "85%",

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

    colors: ["rgba(85, 177, 243, 0.8)", "rgba(0, 247, 191, 0.8)"],

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
            horizontal: 12,
            vertical: 16,
        },
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "12px",
        fontWeight: "medium",

        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#analytics-revenue-2-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-revenue-2-chart"), optionsAnalyticsRevenue2);
    chart.render();
}

// Analytics Revenue 3
let optionsAnalyticsRevenue3 = {
    series: [
        {
            data: [0, 20, 10, 40, 50, 30],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "line",
        id: "analytics-revenue-3-chart",

        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#0063F7"],
    labels: {
        style: {
            fontSize: "14px",
        },
    },
    stroke: {
        curve: "smooth",
        lineCap: "round",
    },

    tooltip: {
        enabled: false,
    },

    dataLabels: {
        enabled: false,
    },

    grid: {
        show: false,
    },

    markers: {
        strokeWidth: 0,
        size: 0,
        colors: ["#0063F7", "#1BE7FF"],
        hover: {
            sizeOffset: 1,
        },
    },
    xaxis: {
        axisTicks: {
            show: false,
        },
        labels: {
            show: false,
        },
        axisBorder: {
            show: false,
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

    yaxis: {
        show: false,
    },
};

document.querySelectorAll("*[data-chart-id]").forEach((e) => {
    if (e.getAttribute("data-chart-id") === "analytics-revenue-3-chart") {
        let chart = new ApexCharts(e, optionsAnalyticsRevenue3);
        chart.render();
    }
});

// Analytics Traffic
let optionsAnalyticsTraffic = {
    series: [
        {
            name: "SEO Visits",
            data: [20, 50, 60, 80, 90, 55],
        },
        {
            name: "Organic",
            data: [35, 35, 35, 15, 35, 15],
        },
        {
            name: "Sponsored",
            data: [100, 15, 60, 40, 50, 80],
        },
    ],
    chart: {
        id: "analytics-Traffic-chart",
        fontFamily: "Manrope, sans-serif",
        type: "radar",
        height: "100%",
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    fill: {
        opacity: [0.2, 0.2, 0.2],
    },
    stroke: {
        show: true,
        width: 3,
    },
    markers: {
        size: 0,
    },

    colors: ["#0063F7", "#FF0022", "#00F7BF"],

    labels: ["Marketing", "Payments", "Bills"],

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
            horizontal: 32,
            vertical: 16,
        },
        horizontalAlign: "center",
        position: "bottom",
        fontSize: "24px",
        fontWeight: 500,
        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#analytics-Traffic-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-Traffic-chart"), optionsAnalyticsTraffic);
    chart.render();
}

// Analytics Visit
let optionsAnalyticsVisit = {
    series: [35, 25, 45],
    chart: {
        id: "analytics-visit-chart",
        fontFamily: "Manrope, sans-serif",
        type: "donut",
        height: 184,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#1BE7FF", "#0010F7", "#00F7BF"],

    labels: ["Desktop", "Tablet", "Mobile"],

    dataLabels: {
        enabled: false,
    },
    plotOptions: {
        pie: {
            donut: {
                size: "75%",
                labels: {
                    show: true,
                    name: {
                        fontSize: "12px",
                        offsetY: 0,
                    },
                    value: {
                        fontSize: "12px",
                        offsetY: 0,
                        formatter(val) {
                            return `% ${val}`;
                        },
                    },
                    total: {
                        show: true,
                        fontSize: "16px",
                        label: "Total",

                        formatter: function (w) {
                            return "2400";
                        },
                    },
                },
            },
        },
    },

    legend: {
        itemMargin: {
            horizontal: 0,
            vertical: 6,
        },
        horizontalAlign: "center",
        position: "left",
        fontSize: "14px",

        markers: {
            radius: 12,
        },
    },
    responsive: [
        {
            breakpoint: 325,
            options: {
                legend: {
                    itemMargin: {
                        horizontal: 4,
                        vertical: 0,
                    },
                    horizontalAlign: "center",
                    position: "bottom",
                    fontSize: "14px",
                },
            },
        },
    ],
};

if (document.querySelector("#analytics-visit-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-visit-chart"), optionsAnalyticsVisit);
    chart.render();
}

// Analytics Visiters
let optionsAnalyticsVisiters = {
    series: [
        {
            name: "Ads",
            data: [8245, 14452, 8545, 14452, 6012, 22333],
        },
        {
            name: "Organic",
            data: [12245, 7952, 10623, 7935, 14345, 4002],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "area",
        id: "analytics-visiters-chart",
        height: "100%",
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#0063F7", "#00F7BF"],
    labels: {
        style: {
            fontSize: "14px",
        },
    },
    fill: {
        opacity: 0.3,
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
        size: 0,
        colors: ["rgba(0, 255, 198, 0.17)", "rgba(45, 125, 239, 0.17)"],
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
        labels: {
            style: {
                colors: ["636E72"],
                fontSize: "14px",
            },
        },
        categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
    },
    legend: {
        position: 'top',
        horizontalAlign: 'right',
        offsetX: 40
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
        max: 30000,
        tickAmount: 3,
    },
};

if (document.querySelector("#analytics-visiters-chart")) {
    let chart = new ApexCharts(document.querySelector("#analytics-visiters-chart"), optionsAnalyticsVisiters);
    chart.render();
}