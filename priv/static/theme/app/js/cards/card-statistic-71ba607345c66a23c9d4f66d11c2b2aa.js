// Statistics Revenue 1 
let optionsStatisticsRevenue1 = {
    series: [
        {
            data: [0, 20, 10, 40, 50, 30],
        },
    ],
    chart: {
        type: "line",
        id: "revenue-line-1",
        height: 100,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    legend: {
        show: false,
    },
    markers: {
        size: 1,
        strokeColors: "#FF8B9A",
        strokeOpacity: 0,
    },

    colors: ["#FF8B9A"],
    stroke: {
        lineCap: "round",
        width: 2,
    },
    tooltip: {
        enabled: false,
    },
    dataLabels: {
        enabled: false,
    },
    grid: {
        show: true,
        borderColor: "#B2BEC3",
        strokeDashArray: 6,
        position: "back",
        xaxis: {
            lines: {
                show: true,
            },
        },
        yaxis: {
            lines: {
                show: false,
            },
        },
    },
    xaxis: {
        show: false,
        labels: {
            show: false,
        },
        axisTicks: {
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

if (document.querySelector("#statistics-revenue-1")) {
    let chart = new ApexCharts(document.querySelector("#statistics-revenue-1"), optionsStatisticsRevenue1);
    chart.render();
}

// Statistics Revenue 2
let optionsStatisticsRevenue2 = {
    series: [
        {
            data: [0, 20, 10, 40, 50, 30],
        },
    ],
    chart: {
        type: "line",
        id: "revenue-line-2",
        height: 100,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#0063F7"],
    stroke: {
        lineCap: "round",
        width: 2,
    },
    markers: {
        size: 1,
        strokeColors: "#0063F7",
        strokeOpacity: 0,
    },
    tooltip: {
        enabled: false,
    },
    dataLabels: {
        enabled: false,
    },
    grid: {
        show: true,
        borderColor: "#B2BEC3",
        strokeDashArray: 6,
        position: "back",
        xaxis: {
            lines: {
                show: true,
            },
        },
        yaxis: {
            lines: {
                show: false,
            },
        },
    },
    xaxis: {
        show: false,
        labels: {
            show: false,
        },
        axisTicks: {
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

if (document.querySelector("#statistics-revenue-2")) {
    let chart = new ApexCharts(document.querySelector("#statistics-revenue-2"), optionsStatisticsRevenue2);
    chart.render();
}

// Statistics Revenue 3
let optionsStatisticsRevenue3 = {
    series: [
        {
            data: [0, 20, 10, 40, 50, 30],
        },
    ],
    chart: {
        type: "line",
        id: "revenue-line-3",
        height: 100,
        toolbar: {
            show: false,
        },
        zoom: {
            enabled: false,
        },
    },
    colors: ["#FFE393"],
    stroke: {
        lineCap: "round",
        width: 2,
    },
    markers: {
        size: 1,
        strokeColors: "#FFE393",
        strokeOpacity: 0,
    },
    tooltip: {
        enabled: false,
    },
    dataLabels: {
        enabled: false,
    },
    grid: {
        show: true,
        borderColor: "#B2BEC3",
        strokeDashArray: 6,
        position: "back",
        xaxis: {
            lines: {
                show: true,
            },
        },
        yaxis: {
            lines: {
                show: false,
            },
        },
    },
    xaxis: {
        show: false,
        labels: {
            show: false,
        },
        axisTicks: {
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

if (document.querySelector("#statistics-revenue-3")) {
    let chart = new ApexCharts(document.querySelector("#statistics-revenue-3"), optionsStatisticsRevenue3);
    chart.render();
}

// Statistics Order
let optionsStatisticsOrder = {
    series: [
        {
            name: "Earning",
            data: [50, 70, 100, 60],
        },
    ],
    chart: {
        type: "bar",
        height: "80",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: 0,
            right: 10,
            top: -10,
            bottom: -10,
        },
    },
    plotOptions: {
        bar: {
            horizontal: false,
            columnWidth: "65%",
            borderRadius: 2,
            colors: {
                backgroundBarColors: [],
                backgroundBarRadius: 5,
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#0010F7"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-order")) {
    let chart = new ApexCharts(document.querySelector("#statistics-order"), optionsStatisticsOrder);
    chart.render();
}

// Statistics Order Vertical
let optionsStatisticsOrderVertical = {
    series: [
        {
            name: "Earning",
            data: [50, 70, 100, 60],
        },
    ],
    chart: {
        type: "bar",
        height: "80",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: 8,
            right: 15,
            top: -10,
            bottom: -10,
        },
    },
    plotOptions: {
        bar: {
            horizontal: false,
            columnWidth: "60%",
            borderRadius: 2,
            colors: {
                backgroundBarColors: [],
                backgroundBarRadius: 5,
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#0010F7"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-order-vertical")) {
    let chart = new ApexCharts(document.querySelector("#statistics-order-vertical"), optionsStatisticsOrderVertical);
    chart.render();
}

// Statistics Subscribe
let optionsStatisticsSubscribe = {
    series: [
        {
            name: "Earning",
            data: [50, 70, 100, 60],
        },
    ],
    chart: {
        type: "bar",
        height: 80,
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: 0,
            right: 10,
            top: -10,
            bottom: -10,
        },
    },
    plotOptions: {
        bar: {
            horizontal: false,
            columnWidth: "65%",
            borderRadius: 2,
            colors: {
                backgroundBarColors: [],
                backgroundBarRadius: 5,
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#00F7BF"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-subscribe")) {
    let chart = new ApexCharts(document.querySelector("#statistics-subscribe"), optionsStatisticsSubscribe);
    chart.render();
}

// Statistics Subscribe Vertical
let optionsStatisticsSubscribeVertical = {
    series: [
        {
            name: "Earning",
            data: [50, 70, 100, 60],
        },
    ],
    chart: {
        type: "bar",
        height: "80",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: 8,
            right: 15,
            top: -10,
            bottom: -10,
        },
    },
    plotOptions: {
        bar: {
            horizontal: false,
            columnWidth: "60%",
            borderRadius: 2,
            colors: {
                backgroundBarColors: [],
                backgroundBarRadius: 5,
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#00F7BF"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-subscribe-vertical")) {
    let chart = new ApexCharts(document.querySelector("#statistics-subscribe-vertical"), optionsStatisticsSubscribeVertical);
    chart.render();
}

// Statistics Ticket
let optionsStatisticsTicket = {
    series: [76],
    chart: {
        type: "radialBar",
        height: "80",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: -24,
            right: -24,
            top: -16,
            bottom: -16,
        },
    },
    plotOptions: {
        radialBar: {
            startAngle: 0,
            endAngle: 360,
            hollow: {
                size: "45%",
            },
            track: {
                show: true,
                background: "#ffffff",
                strokeWidth: "100%",
                opacity: 1,
                margin: 0,
            },
            dataLabels: {
                show: true,
                value: {
                    fontSize: "12px",
                    color: "#FF455E",
                    fontWeight: 500,
                    offsetY: -11,
                },
                total: {
                    show: true,
                    fontSize: "12px",
                    label: "",
                    formatter: function (w) {
                        return "%" + 76;
                    },
                },
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#FF455E"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-ticket")) {
    let chart = new ApexCharts(document.querySelector("#statistics-ticket"), optionsStatisticsTicket);
    chart.render();
}

// Statistics Ticket Vertical
let optionsStatisticsTicketVertical = {
    series: [76],
    chart: {
        type: "radialBar",
        height: "92",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: -24,
            right: -24,
            top: -12,
            bottom: -16,
        },
    },
    plotOptions: {
        radialBar: {
            startAngle: 0,
            endAngle: 360,
            hollow: {
                size: "45%",
            },
            track: {
                show: true,
                background: "#ffffff",
                strokeWidth: "100%",
                opacity: 1,
                margin: 0,
            },
            dataLabels: {
                show: true,
                value: {
                    fontSize: "12px",
                    color: "#FF455E",
                    fontWeight: 500,
                    offsetY: -11,
                },
                total: {
                    show: true,
                    fontSize: "12px",
                    label: "",
                    formatter: function (w) {
                        return "%" + 76;
                    },
                },
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#FF455E"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-ticket-vertical")) {
    let chart = new ApexCharts(document.querySelector("#statistics-ticket-vertical"), optionsStatisticsTicketVertical);
    chart.render();
}

// Statistics Traffic
let optionsStatisticsTraffic = {
    series: [
        {
            data: [31, 10, 109, 60, 140, 40, 150],
        },
    ],
    chart: {
        fontFamily: "Manrope, sans-serif",
        type: "line",
        height: "70%",
        stacked: true,
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
        padding: {
            left: 0,
            right: 0,
        },
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
        lines: {
            show: false,
        },
        axisBorder: {
            show: false,
        },
        axisTicks: {
            show: false,
        },

        labels: {
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

    yaxis: [
        {
            show: false,
            offsetX: 0,
            offsetY: 0,
            padding: {
                left: 0,
                right: 0,
            },
        },
    ],
};

if (document.querySelector("#statistics-traffic")) {
    let chart = new ApexCharts(document.querySelector("#statistics-traffic"), optionsStatisticsTraffic);
    chart.render();
}

// Statistics Users
let optionsStatisticsUsers = {
    series: [40],
    chart: {
        type: "radialBar",
        height: "92",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: -24,
            right: -24,
            top: -12,
            bottom: -16,
        },
    },
    plotOptions: {
        radialBar: {
            startAngle: 0,
            endAngle: 360,
            hollow: {
                size: "45%",
            },
            track: {
                show: true,
                background: "#ffffff",
                strokeWidth: "100%",
                opacity: 1,
                margin: 0,
            },
            dataLabels: {
                show: true,
                value: {
                    fontSize: "12px",
                    color: "#FFC700",
                    fontWeight: 500,
                    offsetY: -11,
                },
                total: {
                    show: true,
                    fontSize: "12px",
                    label: "",
                    formatter: function (w) {
                        return "%" + 40;
                    },
                },
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#FFD252"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-users")) {
    let chart = new ApexCharts(document.querySelector("#statistics-users"), optionsStatisticsUsers);
    chart.render();
}

// Statistics Users Vertical
let optionsStatisticsUsersVertical = {
    series: [40],
    chart: {
        type: "radialBar",
        height: "92",
        stacked: true,
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
        padding: {
            left: -24,
            right: -24,
            top: -12,
            bottom: -16,
        },
    },
    plotOptions: {
        radialBar: {
            startAngle: 0,
            endAngle: 360,
            hollow: {
                size: "45%",
            },
            track: {
                show: true,
                background: "#ffffff",
                strokeWidth: "100%",
                opacity: 1,
                margin: 0,
            },
            dataLabels: {
                show: true,
                value: {
                    fontSize: "12px",
                    color: "#FFC700",
                    fontWeight: 500,
                    offsetY: -11,
                },
                total: {
                    show: true,
                    fontSize: "12px",
                    label: "",
                    formatter: function (w) {
                        return "%" + 40;
                    },
                },
            },
        },
    },
    legend: {
        show: false,
    },
    dataLabels: {
        enabled: false,
    },
    colors: ["#FFD252"],
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
    yaxis: {
        show: false,
        max: 100,
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#statistics-users-vertical")) {
    let chart = new ApexCharts(document.querySelector("#statistics-users-vertical"), optionsStatisticsUsersVertical);
    chart.render();
}
