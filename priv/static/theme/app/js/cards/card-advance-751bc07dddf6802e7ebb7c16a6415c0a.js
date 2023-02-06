// Browser Chrome Chart
let optionsBrowserChromeChart = {
    series: [50.2],
    chart: {
        type: "radialBar",
        width: 24,
        height: 22,
    },
    grid: {
        show: false,
        padding: {
            left: -15,
            right: -15,
            top: -12,
            bottom: -15,
        },
    },
    colors: ["#C903FF"],
    plotOptions: {
        radialBar: {
            hollow: {
                size: "20%",
            },
            track: {
                background: "#DFE6E9",
            },
            dataLabels: {
                showOn: "always",
                name: {
                    show: false,
                },
                value: {
                    show: false,
                },
            },
        },
    },
    stroke: {
        lineCap: "round",
    },
};

if (document.querySelector("#browser-chrome-chart")) {
    let chart = new ApexCharts(document.querySelector("#browser-chrome-chart"), optionsBrowserChromeChart);
    chart.render();
}

// Browser Edge Chart
let optionsBrowserEdgeChart = {
    series: [4.7],
    chart: {
        type: "radialBar",
        width: 24,
        height: 22,
    },
    grid: {
        show: false,
        padding: {
            left: -15,
            right: -15,
            top: -12,
            bottom: -15,
        },
    },
    colors: ["#0010F7"],
    plotOptions: {
        radialBar: {
            hollow: {
                size: "20%",
            },
            track: {
                background: "#DFE6E9",
            },
            dataLabels: {
                showOn: "always",
                name: {
                    show: false,
                },
                value: {
                    show: false,
                },
            },
        },
    },
    stroke: {
        lineCap: "round",
    },
};

if (document.querySelector("#browser-edge-chart")) {
    let chart = new ApexCharts(document.querySelector("#browser-edge-chart"), optionsBrowserEdgeChart);
    chart.render();
}

// Browser Firefox Chart
let optionsBrowserFirefoxChart = {
    series: [12.5],
    chart: {
        type: "radialBar",
        width: 24,
        height: 22,
    },
    grid: {
        show: false,
        padding: {
            left: -15,
            right: -15,
            top: -12,
            bottom: -15,
        },
    },
    colors: ["#FFC700"],
    plotOptions: {
        radialBar: {
            hollow: {
                size: "20%",
            },
            track: {
                background: "#DFE6E9",
            },
            dataLabels: {
                showOn: "always",
                name: {
                    show: false,
                },
                value: {
                    show: false,
                },
            },
        },
    },
    stroke: {
        lineCap: "round",
    },
};

if (document.querySelector("#browser-firefox-chart")) {
    let chart = new ApexCharts(document.querySelector("#browser-firefox-chart"), optionsBrowserFirefoxChart);
    chart.render();
}

// Browser Opera Chart
let optionsBrowserOperaChart = {
    series: [7.8],
    chart: {
        type: "radialBar",
        width: 24,
        height: 22,
    },
    grid: {
        show: false,
        padding: {
            left: -15,
            right: -15,
            top: -12,
            bottom: -15,
        },
    },
    colors: ["#FF0022"],
    plotOptions: {
        radialBar: {
            hollow: {
                size: "20%",
            },
            track: {
                background: "#DFE6E9",
            },
            dataLabels: {
                showOn: "always",
                name: {
                    show: false,
                },
                value: {
                    show: false,
                },
            },
        },
    },
    stroke: {
        lineCap: "round",
    },
};

if (document.querySelector("#browser-opera-chart")) {
    let chart = new ApexCharts(document.querySelector("#browser-opera-chart"), optionsBrowserOperaChart);
    chart.render();
}

// Browser Other Chart
let optionsBrowserOtherChart = {
    series: [2.2],
    chart: {
        type: "radialBar",
        width: 24,
        height: 22,
    },
    grid: {
        show: false,
        padding: {
            left: -15,
            right: -15,
            top: -12,
            bottom: -15,
        },
    },
    colors: ["#111314"],
    plotOptions: {
        radialBar: {
            hollow: {
                size: "20%",
            },
            track: {
                background: "#DFE6E9",
            },
            dataLabels: {
                showOn: "always",
                name: {
                    show: false,
                },
                value: {
                    show: false,
                },
            },
        },
    },
    stroke: {
        lineCap: "round",
    },
};

if (document.querySelector("#browser-other-chart")) {
    let chart = new ApexCharts(document.querySelector("#browser-other-chart"), optionsBrowserOtherChart);
    chart.render();
}

// Browser Safari Chart
let optionsBrowserSafariChart = {
    series: [24.8],
    chart: {
        type: "radialBar",
        width: 24,
        height: 22,
    },
    grid: {
        show: false,
        padding: {
            left: -15,
            right: -15,
            top: -12,
            bottom: -15,
        },
    },
    colors: ["#1BE7FF"],
    plotOptions: {
        radialBar: {
            hollow: {
                size: "20%",
            },
            track: {
                background: "#DFE6E9",
            },
            dataLabels: {
                showOn: "always",
                name: {
                    show: false,
                },
                value: {
                    show: false,
                },
            },
        },
    },
    stroke: {
        lineCap: "round",
    },
};

if (document.querySelector("#browser-safari-chart")) {
    let chart = new ApexCharts(document.querySelector("#browser-safari-chart"), optionsBrowserSafariChart);
    chart.render();
}

// Earnings Chart
let optionsEarningsChart = {
    series: [
        {
            name: "Marketing",
            data: [48],
        },
        {
            name: "Payment",
            data: [21],
        },
        {
            name: "Bills",
            data: [31],
        },
    ],
    chart: {
        type: "bar",
        height: 100,
        stacked: true,
        stackType: "100%",
        toolbar: {
            show: false,
        },
    },
    grid: {
        show: false,
    },
    plotOptions: {
        bar: {
            horizontal: true,
            barHeight: "100%",
            startingShape: "rounded",
            endingShape: "rounded",
        },
    },

    colors: ["#00F7BF", "#1BE7FF", "#0010F7"],
    fill: {
        type: "solid",
    },
    xaxis: {
        type: "datetime",
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
    },

    legend: {
        position: "left",
    },
    tooltip: {
        x: {
            show: false,
        },
    },
};

if (document.querySelector("#earnings-chart")) {
    let chart = new ApexCharts(document.querySelector("#earnings-chart"), optionsEarningsChart);
    chart.render();
}

// Expenses Donut Card
let optionsExpensesDonutCard = {
    series: [1244, 2155, 1541],
    chart: {
        id: "expenses-donut-card",
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
                size: "90%",
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
        fontSize: "12px",
        labels: {
            colors: "#2D3436",
        },

        markers: {
            radius: 12,
        },
    },
};

if (document.querySelector("#expenses-donut-card")) {
    let chart = new ApexCharts(document.querySelector("#expenses-donut-card"), optionsExpensesDonutCard);
    chart.render();
}