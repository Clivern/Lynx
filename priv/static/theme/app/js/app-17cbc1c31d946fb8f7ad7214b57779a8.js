// Config
function themeConfig(data) {
    // Light & Dark
    if (localStorage.getItem('theme')) {
        if (localStorage.getItem('theme') === 'dark') {
            $("body").addClass("dark")
            $("body").removeClass("light")

            $('.hp-theme-customizer-container-body-item-svg[data-theme="light"]').removeClass("active")
            $('.hp-theme-customizer-container-body-item-svg[data-theme="dark"]').addClass("active")

            localStorage.setItem('theme', 'dark');
        } else if (localStorage.getItem('theme') === 'light') {
            $("body").addClass("light")
            $("body").removeClass("dark")

            $('.hp-theme-customizer-container-body-item-svg[data-theme="dark"]').removeClass("active")
            $('.hp-theme-customizer-container-body-item-svg[data-theme="light"]').addClass("active")

            localStorage.setItem('theme', 'light');
        }
    } else {
        if (!$("body").hasClass("dark")) {
            $("body").addClass("light")
            $("body").removeClass("dark")

            $('.hp-theme-customizer-container-body-item-svg[data-theme="dark"]').removeClass("active")
            $('.hp-theme-customizer-container-body-item-svg[data-theme="light"]').addClass("active")
        } else if ($("body").hasClass("dark")) {
            $("body").addClass("dark")
            $("body").removeClass("light")

            $('.hp-theme-customizer-container-body-item-svg[data-theme="light"]').removeClass("active")
            $('.hp-theme-customizer-container-body-item-svg[data-theme="dark"]').addClass("active")
        }
    }

    // Content Width
    if (data.contentWidth === "boxed") {
        $("body").addClass("content-width-boxed")

        $('.hp-theme-customizer-container-body-item-svg[data-content="full"]').removeClass("active")
        $('.hp-theme-customizer-container-body-item-svg[data-content="boxed"]').addClass("active")
    } else if (data.contentWidth === "full") {
        $('.hp-theme-customizer-container-body-item-svg[data-content="boxed"]').removeClass("active")
        $('.hp-theme-customizer-container-body-item-svg[data-content="full"]').addClass("active")
    }

    if ($("body").hasClass("content-width-boxed")) {
        $('.hp-theme-customizer-container-body-item-svg[data-content="full"]').removeClass("active")
        $('.hp-theme-customizer-container-body-item-svg[data-content="boxed"]').addClass("active")
    }
}

themeConfig({
    contentWidth: 'full' // boxed - full
});

// Open & Close
$(".hp-theme-customizer-button").click(function () {
    $(".hp-theme-customizer").toggleClass("active")
})

$(".hp-theme-customizer-container-header button").click(function () {
    $(".hp-theme-customizer").removeClass("active")
})

// Click Item
$(".hp-theme-customizer-container-body-item-svg").click(function () {
    $(this).addClass("active")
    $(this).parent().siblings().children(".hp-theme-customizer-container-body-item-svg").removeClass("active")

    // Light & Dark
    if ($(this).data("theme") === "light") {
        localStorage.setItem('theme', 'light');

        $("body").addClass("light")
        $("body").removeClass("dark")
    } else if ($(this).data("theme") === "dark") {
        localStorage.setItem('theme', 'dark');

        $("body").addClass("dark")
        $("body").removeClass("light")
    }

    // Content Width
    if ($(this).data("content") === "full") {
        $("body").removeClass("content-width-boxed")
    } else if ($(this).data("content") === "boxed") {
        $("body").addClass("content-width-boxed")
    }
})
// Scroll to Top
$(".scroll-to-top").click(function () {
    $(window).scrollTop(0)
});

$(window).scroll(function () {
    if ($(this).scrollTop() > (window.innerHeight / 3)) {
        $(".scroll-to-top").addClass("active")
    } else {
        $(".scroll-to-top").removeClass("active")
    }
});

// Wish Button
$(".hp-wish-button").click(function(){
    $(this).toggleClass("text-danger bg-danger-4 hp-bg-color-dark-danger")
    $(this).toggleClass("text-black-40 hp-text-color-dark-70 bg-black-10 hp-bg-color-dark-90")
});

// Date Timer (Page Error Coming Soon)
$(".data-date-timer").each(function () {
    if ($(this).data("date-timer")) {
        setInterval(() => {
            let future = Date.parse($(this).data("date-timer")),
                now = new Date(),
                diff = future - now,
                days = Math.floor(diff / (1000 * 60 * 60 * 24)),
                hours = Math.floor(diff / (1000 * 60 * 60)),
                mins = Math.floor(diff / (1000 * 60)),
                secs = Math.floor(diff / 1000),
                d = days,
                h = hours - days * 24,
                m = mins - hours * 60,
                s = secs - mins * 60;

            $(this).find("*[data-date-timer-day]").text(d)
            $(this).find("*[data-date-timer-hours]").text(h)
            $(this).find("*[data-date-timer-minutes]").text(m)
            $(this).find("*[data-date-timer-seconds]").text(s)
        }, 1000);
    }
});

// Search (Icon Search)
$("*[data-search]").keyup(function () {
    let value = $(this).val();
    let patt = new RegExp(value, "i");

    $("*[data-search-item]").each(function () {
        if (!($(this).find("*[data-search-item-text]").text().search(patt) >= 0)) {
            $(this).hide();
        }
        if (($(this).find("*[data-search-item-text]").text().search(patt) >= 0)) {
            $(this).show();
        }
    });
});

// Copy Text
setTimeout(() => {
    $("*[data-copy-click]").each(function () {
        let itemId = $(this).find("*[data-copy-id]")

        if ($(this).data("copy-click") === "value") {
            $(this).find("*[data-copy-click-id]").click(function (e) {
                if ($(this).data("copy-click-id") === itemId.data("copy-id")) {
                    let copyText = itemId.val();

                    navigator.clipboard.writeText(copyText);
                }
            })
        } else {
            $(this).find("*[data-copy-click-id]").click(function (e) {
                if ($(this).data("copy-click-id") === itemId.data("copy-id")) {
                    if (itemId.find("*[data-copy]")) {
                        navigator.clipboard.writeText(itemId.find("*[data-copy]").data("copy"));
                    } else {
                        navigator.clipboard.writeText(itemId.text());
                    }
                }
            })
        }
    });
}, 300);

// Payment Input Mask
$('#payment-cardnumber').mask('0000 0000 0000 0000');
$('#payment-date').mask('00/00');
$('#payment-cvc').mask('000');
$('#phone').mask('(000) 000-0000');

// Tooltip
let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})

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

// Header Search
$(function () {
    $(".hp-header-search-button").click(function () {
        $("header .hp-header-text-info").toggleClass("d-none")
        $("header .hp-header-search").toggleClass("d-none")
        $(this).find("button .hp-header-search-button-icon-1").toggleClass("d-none")
        $(this).find("button .hp-header-search-button-icon-2").toggleClass("d-none")

        $("header .hp-horizontal-menu").toggleClass("search-active")

        setTimeout(() => {
            $("header .hp-header-search").toggleClass("active")

            if (!$("header .hp-header-search").hasClass("active")) {
                $("#header-search").val("")
            }

            setTimeout(() => {
                $("#header-search").focus()
            }, 300);
        }, 100);
    });

    $("#header-search").keyup(function () {
        $(".autocomplete-suggestions").css("width", $("header .hp-header-search").width() + "px")
    });

    //--

    let data = [
        {
            value: "Components",
            url: "components-page"
        },

        {
            value: "Dashboard Analytics",
            url: "dashboard-analytics"
        },
        {
            value: "Dashboard Ecommerce",
            url: "dashboard-ecommerce"
        },

        {
            value: "Advance Cards",
            url: "advance-cards"
        },
        {
            value: "Statistics Cards",
            url: "statistics-cards"
        },
        {
            value: "Analytics Cards",
            url: "analytics-cards"
        },
        {
            value: "Charts",
            url: "charts"
        },
        {
            value: "Illustration Set",
            url: "illustration-set"
        },
        {
            value: "Crypto Icons",
            url: "crypto-icons"
        },
        {
            value: "User Icons",
            url: "user-icons"
        },
        {
            value: "Flags",
            url: "flags"
        },

        {
            value: "Divider",
            url: "divider"
        },
        {
            value: "Grid System",
            url: "grid-system"
        },

        {
            value: "Contact",
            url: "app-contact"
        },
        {
            value: "Ecommerce Shop",
            url: "ecommerce-shop"
        },
        {
            value: "Ecommerce Wishlist",
            url: "ecommerce-wishlist"
        },
        {
            value: "Ecommerce Detail",
            url: "ecommerce-product-detail"
        },
        {
            value: "Ecommerce Checkout",
            url: "ecommerce-checkout"
        },

        {
            value: "404 Error Page",
            url: "error-404"
        },
        {
            value: "403 Error Page",
            url: "error-403"
        },
        {
            value: "500 Error Page",
            url: "error-500"
        },
        {
            value: "503 Error Page",
            url: "error-503"
        },
        {
            value: "502 Error Page",
            url: "error-502"
        },
        {
            value: "Maintenance",
            url: "error-maintenance"
        },
        {
            value: "Coming Soon",
            url: "error-coming-soon"
        },

        {
            value: "Pricing",
            url: "pricing"
        },

        {
            value: "Profile",
            url: "profile-information"
        },
        {
            value: "Profile Notification",
            url: "profile-notifications"
        },
        {
            value: "Profile Activity",
            url: "profile-activity"
        },
        {
            value: "Profile Security",
            url: "profile-security"
        },
        {
            value: "Profile Password Change",
            url: "profile-password"
        },
        {
            value: "Profile Social",
            url: "profile-connect"
        },

        {
            value: "Invoice",
            url: "invoice-page"
        },

        {
            value: "FAQ",
            url: "faq-page"
        },

        {
            value: "Knowledge Base 1",
            url: "knowledge-base-1"
        },
        {
            value: "Knowledge Base 2",
            url: "knowledge-base-2"
        },

        {
            value: "Blank",
            url: "blank-page"
        },

        {
            value: "Login",
            url: "auth-login"
        },
        {
            value: "Register",
            url: "auth-register"
        },
        {
            value: "Recover Password",
            url: "auth-recover"
        },
        {
            value: "Reset Password",
            url: "auth-reset"
        },

        {
            value: "Welcome",
            url: "lock-welcome"
        },
        {
            value: "Password is changed",
            url: "lock-password"
        },
        {
            value: "Deactivated",
            url: "lock-deactivated"
        },
        {
            value: "Lock",
            url: "lock"
        },

        {
            value: "StyleGuide",
            url: "general-style-guide"
        },
        {
            value: "Buttons",
            url: "general-buttons"
        },
        {
            value: "Remix Icons",
            url: "general-remix-icons"
        },
        {
            value: "Iconly Icons",
            url: "general-iconly-icons"
        },

        {
            value: "Breadcrumb",
            url: "component-breadcrumb"
        },
        {
            value: "Dropdown",
            url: "component-dropdown"
        },
        {
            value: "Menu",
            url: "component-menu"
        },
        {
            value: "Pagination",
            url: "component-pagination"
        },

        {
            value: "Checkbox",
            url: "component-checkbox"
        },
        {
            value: "Form",
            url: "component-form"
        },
        {
            value: "Input",
            url: "component-input"
        },
        {
            value: "Input Number",
            url: "component-input-number"
        },
        {
            value: "Radio",
            url: "component-radio"
        },
        {
            value: "Select",
            url: "component-select"
        },
        {
            value: "Slider",
            url: "component-slider"
        },
        {
            value: "Switch",
            url: "component-switch"
        },

        {
            value: "Avatar",
            url: "component-avatar"
        },
        {
            value: "Badge",
            url: "component-badge"
        },
        {
            value: "Card",
            url: "component-card"
        },
        {
            value: "Carousel",
            url: "component-carousel"
        },
        {
            value: "Accordion",
            url: "component-accordion"
        },
        {
            value: "Collapse",
            url: "component-collapse"
        },
        {
            value: "List",
            url: "component-list"
        },
        {
            value: "Popover",
            url: "component-popover"
        },
        {
            value: "Table",
            url: "component-table"
        },
        {
            value: "Tabs",
            url: "component-tabs"
        },
        {
            value: "Tooltip",
            url: "component-tooltip"
        },

        {
            value: "Alert",
            url: "component-alert"
        },
        {
            value: "Drawer",
            url: "component-drawer"
        },
        {
            value: "Modal",
            url: "component-modal"
        },
        {
            value: "Notification",
            url: "component-notification"
        },
        {
            value: "Progress",
            url: "component-progress"
        },
        {
            value: "Spinner",
            url: "component-spinner"
        }
    ];

    $('#header-search').autocomplete({
        lookup: data,
        onSelect: function (event) {
            window.location.href = event.url + ".html"
        }
    });
});

// Horizontal Menu
$(function () {
    // Menu Link
    $(".hp-horizontal-menu ul li a").each(function () {
        if (window.location.pathname.split("/")[window.location.pathname.split("/").length - 1] == $(this).attr("href")) {
            $(this).addClass("active")
            $(this).parent().parent().prev(".dropdown-item").addClass("active")
            $(this).parents(".dropdown-menu").prev("a").addClass("active")
        }
    });
})

// Sider
$(function () {
    // Menu Link
    $(".hp-sidebar-container li a").each(function () {
        if (window.location.pathname.split("/")[window.location.pathname.split("/").length - 1] == $(this).attr("href")) {
            $(this).addClass("active")

            $(this).parents(".submenu-children").slideDown()
            $(this).parents(".submenu-children").addClass("active")
            $(this).parents(".submenu-children").prev("a").addClass("active arrow-active")
        }
    });

    // Menu Dropdown
    $(".hp-sidebar-container li a").click(function () {
        if ($(this).next(".submenu-children").length) {
            $(this).toggleClass("arrow-active")
            $(this).next(".submenu-children").slideToggle(300)
        }
    });

    // Mobile Button
    $(".hp-mobile-sidebar-button").click(function () {
        $("body").removeClass("collapsed-active collapse-btn-none")
    });

    // Collapsed
    $(".hp-sidebar .hp-sidebar-collapse-button").click(function () {
        $("body").toggleClass("collapsed-active")
        $(".hp-sidebar .submenu-children").slideUp()
        $(".hp-sidebar li a").removeClass("arrow-active")
        $(".hp-sidebar .tooltip-item").toggleClass("in-active")

        if ($("body").hasClass("collapsed-active")) {
            $(".hp-sidebar .submenu-children").addClass("d-none")
        } else {
            $(".hp-sidebar .submenu-children").removeClass("d-none")
            $(".hp-sidebar .submenu-children").css("display", "none")
        }
    });

    if ($("body").hasClass("collapsed-active")) {
        $(".hp-sidebar .submenu-children").addClass("d-none")
        $(".hp-sidebar .tooltip-item").removeClass("in-active")
    }

    // Collapsed Menu Dropdown
    let position = "left";
    let sidebarWidth;

    if ($("html").attr("dir") === "rtl") {
        position = "right";
    }

    $(".hp-sidebar-container li a").mouseenter(function () {
        if ($("body").hasClass("collapsed-active")) {
            sidebarWidth = parseInt($(this).parents(".hp-sidebar").width()) + 38;

            $(".hp-sidebar-dropdown-container").remove();

            if ($(this).next(".submenu-children").length) {
                $("body").append(
                    `
                        <div class="hp-sidebar-dropdown-container position-absolute">
                            <ul>` +
                    $(this).next(".submenu-children").html() +
                    `</ul>
                        </div>
                        `
                );

                if ($(this).offset().top + $(".hp-sidebar-dropdown-container").height() > $(window).height()) {
                    $(".hp-sidebar-dropdown-container > ul").css({
                        maxHeight: "calc(100vh - " + ($(window).height() - $(this).offset().top) + "px)",
                    });

                    $(".hp-sidebar-dropdown-container").css(
                        "top", $(this).offset().top - $(".hp-sidebar-dropdown-container").height() + 50 + "px"
                    );
                    if (position === "right") {
                        $(".hp-sidebar-dropdown-container").css(
                            position, (sidebarWidth - 38) + "px"
                        );
                    } else {
                        $(".hp-sidebar-dropdown-container").css(
                            position, "calc(" + $(this).offset().left + "px + " + sidebarWidth + "px)"
                        );
                    }
                } else {
                    $(".hp-sidebar-dropdown-container > ul").css({
                        maxHeight: "none",
                    });

                    $(".hp-sidebar-dropdown-container").css(
                        "top", $(this).offset().top + "px"
                    );
                    if (position === "right") {
                        $(".hp-sidebar-dropdown-container").css(
                            position, (sidebarWidth - 38) + "px"
                        );
                    } else {
                        $(".hp-sidebar-dropdown-container").css(
                            position, "calc(" + $(this).offset().left + "px + " + sidebarWidth + "px)"
                        );
                    }
                }

                //--

                let levelNumber;
                $(".hp-sidebar-dropdown-container li a").mouseenter(function () {
                    if ($(this).next(".submenu-children").length) {
                        $(this).css("pointer-events", "none");

                        levelNumber = $(this)
                            .next(".collapse")
                            .find(".submenu-children")
                            .data("level");

                        $("body").append(
                            `
                                <div class="hp-sidebar-dropdown-container position-absolute" data-level="` +
                            levelNumber +
                            `">
                                    <ul>` +
                            $(this).next(".submenu-children").html() +
                            `</ul>
                                 </div>
                                `
                        );

                        if ($(this).offset().top + $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").height() > $(window).height()) {
                            $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "] > ul").css({
                                maxHeight: "calc(100vh - " + ($(window).height() - $(this).offset().top) + "px)",
                            });

                            $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").css(
                                "top", $(this).offset().top - $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").height() + 50 + "px"
                            );

                            if (position === "right") {
                                $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").css(
                                    position, "calc(" + ($(this).width() + sidebarWidth - 38 + 27) + "px)"
                                );
                            } else {
                                $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").css(
                                    position, "calc(" + $(this).offset().left + "px + " + (sidebarWidth - 37) * parseInt(levelNumber) + "px)"
                                );
                            }
                        } else {
                            $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "] > ul").css({
                                maxHeight: "none",
                            });

                            $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").css("top", $(this).offset().top + "px");
                            if (position === "right") {
                                $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").css(
                                    position, "calc(" + ($(this).width() + sidebarWidth - 38 + 27) + "px)"
                                );
                            } else {
                                $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").css(
                                    position, "calc(" + $(this).offset().left + "px + " + (sidebarWidth - 37) * parseInt(levelNumber) + "px)"
                                );
                            }
                        }
                    } else {
                        $(".hp-sidebar-dropdown-container li a").css("pointer-events", "all");
                        $(".hp-sidebar-dropdown-container[data-level=" + levelNumber + "]").remove();
                    }
                });
            }
        } else {
            $(".hp-sidebar-dropdown-container").remove();
        }
    });

    $(window).mousemove(function (e) {
        let menuItem = $(".hp-sidebar-container li a");
        let dropdownContainer = $(".hp-sidebar-dropdown-container");

        if (
            !menuItem.is(event.target) &&
            !menuItem.has(event.target).length &&
            !dropdownContainer.is(event.target) &&
            !dropdownContainer.has(event.target).length
        ) {
            $(".hp-sidebar-dropdown-container").remove();
            $(".hp-sidebar-dropdown-container li a").css("pointer-events", "all");
        }
    });
})

// Avatar Component
$(function () {
    // Max Count
    $(".avatar-group").each(function (index) {
        let maxValue = $(this).data("max");

        if (maxValue) {
            if ($(this).children("div").length > maxValue) {
                $(this).find(".avatar-item-max-count").removeClass("d-none")
            }

            $(this).children("div").each(function (index) {
                if (!$(this).hasClass("avatar-item-max-count")) {
                    if ((index + 1) > maxValue) {
                        $(this).parent().find(".avatar-group-dropdown-container").append($(this))
                    }
                }
            });

            $(this).find(".avatar-item-max-count > span").text("+" + ($(this).parent().find(".avatar-group-dropdown-container > div").length))
        }
    });
})

// Carousel
new bootstrap.Carousel()

// Input Number Component
$(".input-number .input-number-input").focusin(function () {
    $(this).parent().parent().addClass("input-number-focused")
});

$(".input-number .input-number-input").focusout(function () {
    $(this).parent().parent().removeClass("input-number-focused")
});

$(".input-number .input-number-input").keyup(function () {
    let inputNumberUp = $(this).parents(".input-number").find(".input-number-handler-up"),
        inputNumberDown = $(this).parents(".input-number").find(" .input-number-handler-down");

    if (Number($(this).val()) >= $(this).attr("max")) {
        $(this).val($(this).attr("max"))

        inputNumberUp.addClass("input-number-handler-up-disabled")
        inputNumberDown.removeClass("input-number-handler-down-disabled")
    } else {
        inputNumberDown.removeClass("input-number-handler-down-disabled")
        inputNumberUp.removeClass("input-number-handler-up-disabled")
    }

    if ($(this).val() !== "") {
        if (Number($(this).val()) <= $(this).attr("min")) {
            $(this).val($(this).attr("min"))

            inputNumberDown.addClass("input-number-handler-down-disabled")
            inputNumberUp.removeClass("input-number-handler-up-disabled")
        }
    }
});

$(".input-number .input-number-handler").click(function () {
    let inputNumberInput = $(this).parents(".input-number").find(".input-number-input"),
        inputNumberUp = $(this).parents(".input-number").find(".input-number-handler-up"),
        inputNumberDown = $(this).parents(".input-number").find(".input-number-handler-down"),
        inputNumberValue = Number(inputNumberInput.val()),
        inputNumberStep = Number(inputNumberInput.attr("step")) ? Number(inputNumberInput.attr("step")) : 1,
        inputNumberMin = Number(inputNumberInput.attr("min")),
        inputNumberMax = Number(inputNumberInput.attr("max"));

    if (!$(this).hasClass("input-number-handler-up-disabled")) {
        if ($(this).hasClass("input-number-handler-up")) {
            if (inputNumberValue < inputNumberMax) {
                inputNumberValue += inputNumberStep;
                inputNumberDown.removeClass("input-number-handler-down-disabled")
            }

            if (inputNumberValue === inputNumberMax) {
                inputNumberUp.addClass("input-number-handler-up-disabled")
            }
        }
    }

    if (!$(this).hasClass("input-number-handler-down-disabled")) {
        if ($(this).hasClass("input-number-handler-down")) {
            if (inputNumberValue > inputNumberMin) {
                inputNumberValue -= inputNumberStep;
                inputNumberUp.removeClass("input-number-handler-up-disabled")
            }

            if (inputNumberValue === inputNumberMin) {
                inputNumberDown.addClass("input-number-handler-down-disabled")
            }
        }
    }

    inputNumberInput.val(inputNumberValue)
});

// Modal Component
var varyingModal = document.getElementById('varyingModal')
if (varyingModal) {
    varyingModal.addEventListener('show.bs.modal', function (event) {
        // Button that triggered the modal
        var button = event.relatedTarget
        // Extract info from data-bs-* attributes
        var recipient = button.getAttribute('data-bs-whatever')
        // If necessary, you could initiate an AJAX request here
        // and then do the updating in a callback.
        //
        // Update the modal's content.
        var modalTitle = varyingModal.querySelector('.modal-title')
        var modalBodyInput = varyingModal.querySelector('.modal-body input')

        modalTitle.textContent = 'New message to ' + recipient
        modalBodyInput.value = recipient
    })
}

// Notification
$(".toast-btn").click(function () {
    let btnItem = $(this),
        btnId = btnItem.data("id");

    $(".toast").each(function () {
        let eachItem = $(this),
            eachItemId = eachItem.data("id");

        if (eachItemId) {
            if (btnId === eachItemId) {
                new bootstrap.Toast($(this)).show();
            }
        }
    });
});

// Popover
var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
})

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

// Ecommerce Detail Other Slider
setTimeout(() => {
    new Swiper('.hp-ecommerce-app-detail-other-slider .swiper', {
        slidesPerView: 2,
        spaceBetween: 24,
        navigation: {
            nextEl: '.hp-ecommerce-app-detail-other-slider .btn-next',
            prevEl: '.hp-ecommerce-app-detail-other-slider .btn-prev',
        },
        breakpoints: {
            1200: {
                slidesPerView: 6,
            },
            768: {
                slidesPerView: 3,
            },
        }
    });
}, 500);

// Ecommerce Detail Slider
setTimeout(() => {
    let ecommerceAppDetailSlider1 = new Swiper(".hp-ecommerce-app-detail-slider-1", {
        loop: true,
        slidesPerView: 1,
        watchSlidesProgress: true,
    });

    new Swiper(".hp-ecommerce-app-detail-slider-2", {
        slidesPerView: 3,
        loop: true,
        thumbs: {
            swiper: ecommerceAppDetailSlider1,
        },
        breakpoints: {
            768: {
                slidesPerView: 4,
            }
        }
    });
}, 500);

// Auth V2
if ($(".hp-authentication-page-register").length) {
    $(".hp-authentication-page-register *[data-button-step]").click(function () {
        let buttonItem = $(this);

        if (buttonItem.attr("data-button-step") === "register-step-1") {
            $(this).addClass("d-none")
            $(".hp-authentication-page-register *[data-button-step='register-step-2']").removeClass("d-none")

            $(".hp-authentication-page-register *[data-step]").each(function () {
                if ("register-step-1" === $(this).attr("data-step")) {
                    $(this).removeClass("d-none")
                }
            });
        }
       
        if (buttonItem.attr("data-button-step") === "register-step-2") {
            $(this).addClass("d-none")
            $(".hp-authentication-page-register *[data-button-step='register-step-3']").removeClass("d-none")

            $(".hp-authentication-page-register *[data-step]").each(function () {
                if ("register-step-2" === $(this).attr("data-step")) {
                    $(this).removeClass("d-none")
                }
            });
        }
       
        if (buttonItem.attr("data-button-step") === "register-step-3") {
            $(this).addClass("d-none")
            $(".hp-authentication-page-register *[data-button-step='register-step-4']").removeClass("d-none")

            $(".hp-authentication-page-register *[data-step]").each(function () {
                if ("register-step-3" === $(this).attr("data-step")) {
                    $(this).removeClass("d-none")
                }
            });
        }
    });
} else {
    $(".hp-authentication-page *[data-button-step]").click(function () {
        let buttonItem = $(this);

        $(".hp-authentication-page *[data-step]").each(function () {
            if (buttonItem.attr("data-button-step") === $(this).attr("data-step")) {
                $(this).removeClass("d-none")
                buttonItem.addClass("d-none")
            }
        });
    });
}

// Dashboard Ecommerce Products Slide
setTimeout(() => {
    new Swiper('.best-selling-product-slide .swiper', {
        slidesPerView: 1,
        spaceBetween: 32,
        speed: 800,
        navigation: {
            nextEl: '.best-selling-product-slide .slide-btn-next',
            prevEl: '.best-selling-product-slide .slide-btn-prev',
        },
        breakpoints: {
            992: {
                slidesPerView: 3,
            },
            768: {
                slidesPerView: 2,
            },
        }
    });
}, 500);

$(function () {
    // Slide
    new Swiper('.hp-landing-features-slide', {
        slidesPerView: 1,
        spaceBetween: 32,
        centeredSlides: true,
        loop: true,
        speed: 800,
        autoplay: {
            delay: 5000,
            disableOnInteraction: false,
        },
        breakpoints: {
            1200: {
                slidesPerView: 3,
            },
            768: {
                slidesPerView: 2,
            },
        }
    });

    // Pricing
    $(".hp-landing-pricing .form-switch input").change(function (e) {
        $(this).parent().next("span").toggleClass("text-primary text-black-100 hp-text-color-dark-0")
        $(this).parent().prev("span").toggleClass("text-primary text-black-100 hp-text-color-dark-0")

        $(".monthly-text").toggleClass("d-none")
        $(".annually-text").toggleClass("d-none")
    })
})
// Components Page Menu
setTimeout(() => {
    new Swiper('.hp-components-menu .swiper', {
        slidesPerView: 'auto',
        speed: 800,
    });
}, 500);
// Pricing Page
$(function () {
    $("#pricing-billed").change(function (e) {
        if (e.target.checked) {
            $(".hp-pricing-billed-yearly-text").addClass("active");
            $(".hp-pricing-billed-monthly-text").removeClass("active");

            $(".hp-pricing-billed-active").removeClass("d-none")
            $(".hp-pricing-billed-inactive").addClass("d-none")
        } else {
            $(".hp-pricing-billed-monthly-text").addClass("active");
            $(".hp-pricing-billed-yearly-text").removeClass("active");

            $(".hp-pricing-billed-active").addClass("d-none")
            $(".hp-pricing-billed-inactive").removeClass("d-none")
        }
    })
})

const defaultButtons = `
<button class="btn btn-primary">Primary</button>
<button class="btn btn-secondary">Secondary</button>
<button class="btn btn-danger">Danger</button>
<button class="btn btn-info">Info</button>
<button class="btn btn-success">Success</button>
<button class="btn btn-warning">Warning</button>
<button class="btn btn-dark">Dark</button>

`;

const largeButtons = `
<button class="btn btn-lg btn-primary">Primary</button>
<button class="btn btn-lg btn-secondary">Secondary</button>
<button class="btn btn-lg btn-danger">Danger</button>
<button class="btn btn-lg btn-info">Info</button>
<button class="btn btn-lg btn-success">Success</button>
<button class="btn btn-lg btn-warning">Warning</button>
<button class="btn btn-lg btn-dark">Dark</button>

`;

const smallButtons = `
<button class="btn btn-sm btn-primary">Primary</button>
<button class="btn btn-sm btn-secondary">Secondary</button>
<button class="btn btn-sm btn-danger">Danger</button>
<button class="btn btn-sm btn-info">Info</button>
<button class="btn btn-sm btn-success">Success</button>
<button class="btn btn-sm btn-warning">Warning</button>
<button class="btn btn-sm btn-dark">Dark</button>

`;

const textButtons = `
<button class="btn btn-text text-primary hp-hover-bg-primary-4 hp-hover-bg-dark-primary">Primary Button</button>
<button class="btn btn-text text-secondary hp-hover-bg-secondary-4 hp-hover-bg-dark-secondary">Secondary Button</button>
<button class="btn btn-text text-danger hp-hover-bg-danger-4 hp-hover-bg-dark-danger">Danger Button</button>
<button class="btn btn-text text-info hp-hover-bg-info-4 hp-hover-bg-dark-info">Info Button</button>
<button class="btn btn-text text-success hp-hover-bg-success-4 hp-hover-bg-dark-success">Success Button</button>
<button class="btn btn-text text-warning hp-hover-bg-warning-4 hp-hover-bg-dark-warning">Warning Button</button>
<button class="btn btn-text text-black-100 hp-hover-bg-black-10 hp-hover-bg-dark-80 hp-hover-text-color-dark-0">Dark Button</button>

`;

const linkButtons = `
<button class="btn btn-link text-primary hp-hover-text-color-primary-3">Primary Button</button>
<button class="btn btn-link text-secondary hp-hover-text-color-secondary-3">Secondary Button</button>
<button class="btn btn-link text-danger hp-hover-text-color-danger-3">Danger Button</button>
<button class="btn btn-link text-info hp-hover-text-color-info-3">Info Button</button>
<button class="btn btn-link text-success hp-hover-text-color-success-3">Success Button</button>
<button class="btn btn-link text-warning hp-hover-text-color-warning-3">Warning Button</button>
<button class="btn btn-link text-black-100 hp-hover-text-color-black-60">Dark Button</button>

`;

const dashedButtons = `
<button class="btn btn-dashed text-primary border-primary hp-hover-text-color-primary-2 hp-hover-border-color-primary-2">Primary Button</button>
<button class="btn btn-dashed text-secondary border-secondary hp-hover-text-color-secondary-2 hp-hover-border-color-secondary-2">Secondary Button</button>
<button class="btn btn-dashed text-danger border-danger hp-hover-text-color-danger-2 hp-hover-border-color-danger-2">Danger Button</button>
<button class="btn btn-dashed text-info border-info hp-hover-text-color-info-2 hp-hover-border-color-info-2">Info Button</button>
<button class="btn btn-dashed text-success border-success hp-hover-text-color-success-2 hp-hover-border-color-success-2">Success Button</button>
<button class="btn btn-dashed text-warning border-warning hp-hover-text-color-warning-2 hp-hover-border-color-warning-2">Warning Button</button>
<button class="btn btn-dashed text-black-100 border-black-100 hp-hover-text-color-black-80 hp-hover-border-color-black-80">Dark Button</button>

`;

const disabledButtons = `
<button class="btn btn-primary" disabled>Primary Button</button>

<button class="btn btn-primary" disabled>
    <i class="ri-arrow-right-s-line remix-icon"></i>
    <span>Primary Button</span>
</button>

<button class="btn btn-text" disabled>Text Button</button>

`;

const outlineButtons = `
<button class="btn btn-outline-primary">Primary Button</button>
<button class="btn btn-outline-secondary">Secondary Button</button>
<button class="btn btn-outline-danger">Danger Button</button>
<button class="btn btn-outline-info">Info Button</button>
<button class="btn btn-outline-success">Success Button</button>
<button class="btn btn-outline-warning">Warning Button</button>
<button class="btn btn-outline-black-100">Dark Button</button>

`;

const ghostButtons = `
<button class="btn btn-ghost btn-primary">Primary Button</button>
<button class="btn btn-ghost btn-secondary">Secondary Button</button>
<button class="btn btn-ghost btn-danger">Danger Button</button>
<button class="btn btn-ghost btn-info">Info Button</button>
<button class="btn btn-ghost btn-success">Success Button</button>
<button class="btn btn-ghost btn-warning">Warning Button</button>
<button class="btn btn-ghost btn-dark">Dark Button</button>

`;

const gradientButtons = `
<button class="btn btn-gradient btn-primary"><span>Primary Button</span></button>
<button class="btn btn-gradient btn-secondary"><span>Secondary Button</span></button>
<button class="btn btn-gradient btn-danger"><span>Danger Button</span></button>
<button class="btn btn-gradient btn-info"><span>Info Button</span></button>
<button class="btn btn-gradient btn-success"><span>Success Button</span></button>
<button class="btn btn-gradient btn-warning"><span>Warning Button</span></button>
<button class="btn btn-gradient btn-dark"><span>Dark Button</span></button>

`;

const iconButtons = `
<button class="btn btn-primary">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-outline-primary">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-dashed btn-dashed-primary">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

--

<button class="btn btn-secondary">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-outline-secondary">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-dashed btn-dashed-secondary">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

--

<button class="btn btn-danger">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-outline-danger">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-dashed btn-dashed-danger">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

--

<button class="btn btn-info">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-outline-info">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-dashed btn-dashed-info">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

--

<button class="btn btn-success">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-outline-success">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-dashed btn-dashed-success">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

--

<button class="btn btn-warning">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-outline-warning">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

<button class="btn btn-dashed btn-dashed-warning">
    <i class="ri-search-line remix-icon"></i>
    <span>Search</span>
</button>

`;

const iconOnlyButtons = `
<button class="btn btn-icon-only rounded-circle btn-primary">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-primary">
    <span>Y</span>
</button>

<button class="btn btn-icon-only rounded-circle btn-outline-primary">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-dashed btn-dashed-primary">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only btn-primary">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-primary">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

--

<button class="btn btn-icon-only rounded-circle btn-secondary">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-secondary">
    <span>Y</span>
</button>

<button class="btn btn-icon-only rounded-circle btn-outline-secondary">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-dashed btn-dashed-secondary">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only btn-secondary">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-secondary">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

--

<button class="btn btn-icon-only rounded-circle btn-danger">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-danger">
    <span>Y</span>
</button>

<button class="btn btn-icon-only rounded-circle btn-outline-danger">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-dashed btn-dashed-danger">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only btn-danger">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-danger">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

--

<button class="btn btn-icon-only rounded-circle btn-info">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-info">
    <span>Y</span>
</button>

<button class="btn btn-icon-only rounded-circle btn-outline-info">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-dashed btn-dashed-info">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only btn-info">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-info">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

--

<button class="btn btn-icon-only rounded-circle btn-success">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-success">
    <span>Y</span>
</button>

<button class="btn btn-icon-only rounded-circle btn-outline-success">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-dashed btn-dashed-success">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only btn-success">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-success">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>
                
--

<button class="btn btn-icon-only rounded-circle btn-warning">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-warning">
    <span>Y</span>
</button>

<button class="btn btn-icon-only rounded-circle btn-outline-warning">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-dashed btn-dashed-warning">
    <i class="ri-search-line remix-icon"></i>
</button>

<button class="btn btn-icon-only btn-warning">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

<button class="btn btn-icon-only rounded-circle btn-warning">
    <i class="ri-arrow-right-s-line remix-icon"></i>
</button>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "buttons") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "default-buttons") {
            $(this).text(defaultButtons)
        }

        if ($(this).data("code") === "large-buttons") {
            $(this).text(largeButtons)
        }

        if ($(this).data("code") === "small-buttons") {
            $(this).text(smallButtons)
        }

        if ($(this).data("code") === "text-buttons") {
            $(this).text(textButtons)
        }

        if ($(this).data("code") === "link-buttons") {
            $(this).text(linkButtons)
        }

        if ($(this).data("code") === "dashed-buttons") {
            $(this).text(dashedButtons)
        }

        if ($(this).data("code") === "disabled-buttons") {
            $(this).text(disabledButtons)
        }

        if ($(this).data("code") === "outline-buttons") {
            $(this).text(outlineButtons)
        }

        if ($(this).data("code") === "ghost-buttons") {
            $(this).text(ghostButtons)
        }

        if ($(this).data("code") === "gradient-buttons") {
            $(this).text(gradientButtons)
        }

        if ($(this).data("code") === "icon-buttons") {
            $(this).text(iconButtons)
        }

        if ($(this).data("code") === "icon-only-buttons") {
            $(this).text(iconOnlyButtons)
        }
    }
});

const basicAccordion = `
<div class="accordion" id="accordionExample">
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>

  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>

  <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>
</div>

`;

const flushAccordion = `
<div class="accordion accordion-flush" id="accordionFlushExample">
  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>

  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>

  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>
</div>

`;

const openData = `
<div class="accordion" id="accordionPanelsStayOpenExample">
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>

  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>

  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
        <div class="row align-items-center">
          <div class="col pe-16">
            <p class="d-flex align-items-center hp-p1-body mb-0">
              <span>Lorem Ipsum Collapse Title</span>
              <span class="badge bg-primary-4 border-primary text-primary ms-16">Tag</span>
            </p>
          </div>
        </div>
      </button>
    </h2>

    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
      <div class="accordion-body">
        <p class="hp-p1-body">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget eleifend lectus. Sed quis nisi lectus. Quisque vel leo diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer sit amet nisi eu nisi tincidunt facilisis. Sed mollis nisl dui, a sodales massa sodales sit amet. Sed nisl est, volutpat sed feugiat non, maximus id orci. Fusce placerat congue nulla, a consectetur massa hendrerit a.
        </p>
      </div>
    </div>
  </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "accordion") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "example") {
      $(this).text(basicAccordion)
    }

    if ($(this).data("code") === "flush") {
      $(this).text(flushAccordion)
    }

    if ($(this).data("code") === "open") {
      $(this).text(openData)
    }
  }
});

const examplesAlert = `
<div class="alert alert-primary" role="alert">
    A simple primary alert—check it out!
</div>

<div class="alert alert-secondary" role="alert">
    A simple secondary alert—check it out!
</div>

<div class="alert alert-success" role="alert">
    A simple success alert—check it out!
</div>

<div class="alert alert-danger" role="alert">
    A simple danger alert—check it out!
</div>

<div class="alert alert-warning" role="alert">
    A simple warning alert—check it out!
</div>

<div class="alert alert-info" role="alert">
    A simple info alert—check it out!
</div>

<div class="alert alert-light" role="alert">
    A simple light alert—check it out!
</div>

<div class="alert alert-dark mb-0" role="alert">
    A simple dark alert—check it out!
</div>

`;

const linkColor = `
<div class="alert alert-primary" role="alert">
    A simple primary alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-secondary" role="alert">
  A simple secondary alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-success" role="alert">
    A simple success alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-danger" role="alert">
    A simple danger alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-warning" role="alert">
    A simple warning alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-info" role="alert">
    A simple info alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-light" role="alert">
    A simple light alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-dark" role="alert">
    A simple dark alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

`;

const additional = `
<div class="alert alert-success" role="alert">
    <h4 class="alert-heading hp-text-color-dark-info-1">Well done!</h4>
    <p>Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.</p>
    <div class="divider hp-border-color-dark-info-1"></div>
    <p class="mb-0">Whenever you need to, be sure to use margin utilities to keep things nice and tidy.</p>
</div>

`;

const iconsAlert = `
<div class="alert alert-primary d-flex align-items-center" role="alert">
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
    </svg>

    <div>
        An example alert with an icon
    </div>
</div>

`;

const icons2Alert = `
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
      <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
  </symbol>

  <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
  </symbol>

  <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
      <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
  </symbol>
</svg>

<div class="alert alert-primary d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>

  <div>
      An example alert with an icon
  </div>
</div>

<div class="alert alert-success d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>

      <div>
      An example success alert with an icon
  </div>
</div>

<div class="alert alert-warning d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Warning:"><use xlink:href="#exclamation-triangle-fill"/></svg>

  <div>
      An example warning alert with an icon
  </div>
</div>

<div class="alert alert-danger d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>

  <div>
      An example danger alert with an icon
  </div>
</div>

`;

const dismissing = `
<div class="alert alert-warning alert-dismissible fade show" role="alert">
    <strong>Holy guacamole!</strong> You should check in on some of those fields below.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "alert") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "examples") {
      $(this).text(examplesAlert)
    }

    if ($(this).data("code") === "link-color") {
      $(this).text(linkColor)
    }

    if ($(this).data("code") === "additional") {
      $(this).text(additional)
    }

    if ($(this).data("code") === "icons") {
      $(this).text(iconsAlert)
    }

    if ($(this).data("code") === "icons2") {
      $(this).text(icons2Alert)
    }

    if ($(this).data("code") === "dismissing") {
      $(this).text(dismissing)
    }
  }
});

const basicAvatar = `
<div>
    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle" style="width: 64px; height: 64px;">
        <i class="iconly-Curved-User" style="font-size: 46px; letter-spacing: -2px;"></i>
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
        <i class="iconly-Curved-User"></i>
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
        <i class="iconly-Curved-User"></i>
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center avatar-sm hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
        <i class="iconly-Curved-User"></i>
    </div>
</div>

<div>
  <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded" style="width: 64px; height: 64px;">
      <i class="iconly-Curved-User" style="font-size: 46px; letter-spacing: -2px;"></i>
  </div>
  
  <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-primary-4 hp-text-color-primary-1 rounded">
      <i class="iconly-Curved-User"></i>
  </div>
  
  <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded">
      <i class="iconly-Curved-User"></i>
  </div>
  
  <div class="avatar-item d-flex align-items-center justify-content-center avatar-sm hp-bg-primary-4 hp-text-color-primary-1 rounded">
      <i class="iconly-Curved-User"></i>
  </div>
</div>

`;

const avatarGroup = `
<div class="avatar-group">
    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
        <img src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png" alt="User">
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-danger-4 hp-text-color-danger-1 rounded-circle"> K </div>
   
    <div data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="User">
        <div class="avatar-item d-flex align-items-center justify-content-center rounded-circle">
            <i class="iconly-Curved-User" style="font-size: 22px; letter-spacing: -2px;"></i>
        </div>
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-info-4 hp-text-color-info-1 rounded-circle">
        <i class="ri-reactjs-line" style="font-size: 18px; letter-spacing: -2px;"></i>
    </div>
</div>

<div class="divider"></div>

<div class="avatar-group" data-max="2">
    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
        <img src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png" alt="User">
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-warning-4 hp-text-color-warning-1 rounded-circle"> K </div>
    
    <div data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="User">
        <div class="avatar-item d-flex align-items-center justify-content-center rounded-circle">
            <i class="iconly-Curved-User"></i>
        </div>
    </div>

    <div class="avatar-item d-flex align-items-center justify-content-center hp-bg-info-4 hp-text-color-info-1 rounded-circle">
        <i class="ri-reactjs-line"></i>
    </div>

    <div class="avatar-item avatar-item-max-count d-none bg-danger-4 hp-bg-dark-danger text-danger">
        <span></span>

        <div class="avatar-group-dropdown">
            <div class="avatar-group-dropdown-container"></div>
        </div>
    </div>
</div>

<div class="divider"></div>

<div class="avatar-group">
    <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
        <img src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png" alt="User">
    </div>
   
    <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-warning-4 hp-text-color-warning-1 rounded-circle"> K </div>
   
    <div class="avatar-item avatar-lg avatar-item-max-count hp-bg-danger-4 hp-text-color-danger-1">
        <span>+2</span>

        <div class="avatar-group-dropdown">
            <div class="avatar-group-dropdown-container">
                <div data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="User">
                    <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg rounded-circle">
                        <i class="iconly-Curved-User"></i>
                    </div>
                </div>

                <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-info-4 hp-text-color-info-1 rounded-circle">
                    <i class="ri-reactjs-line"></i>
                </div>
            </div>
        </div>
    </div>
</div>

`;

const avatarType = `
<div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle">
    <i class="iconly-Curved-User"></i>
</div>

<div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle"> S </div>

<div class="avatar-item d-flex align-items-center justify-content-center hp-bg-primary-4 hp-text-color-primary-1 rounded-circle" style="width: 40px; height: 40px;">
    <span style="font-size: 12px;">USER</span>
</div>

<div class="avatar-item d-flex align-items-center justify-content-center hp-bg-danger-4 hp-text-color-danger-1 rounded-circle"> D </div>

<div class="avatar-item d-flex align-items-center justify-content-center hp-bg-success-4 hp-text-color-success-1 rounded-circle">
    <i class="iconly-Curved-User"></i>
</div>

`;

const avatarBadge = `
<div class="position-relative">
    <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-primary-4 hp-text-color-primary-1 rounded">
        <i class="iconly-Curved-User"></i>
    </div>

    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary"> 1 </span>
</div>

<div class="position-relative">
    <div class="avatar-item d-flex align-items-center justify-content-center avatar-lg hp-bg-primary-4 hp-text-color-primary-1 rounded">
        <i class="iconly-Curved-User"></i>
    </div>

    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger d-block p-0" style="width: 6px; height: 6px;"></span>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "avatar") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicAvatar)
    }

    if ($(this).data("code") === "avatar-group") {
      $(this).text(avatarGroup)
    }

    if ($(this).data("code") === "avatar-type") {
      $(this).text(avatarType)
    }

    if ($(this).data("code") === "avatar-badge") {
      $(this).text(avatarBadge)
    }
  }
});

const headings = `
<h1>Example heading <span class="badge bg-primary">New</span></h1>
<h2>Example heading <span class="badge bg-primary">New</span></h2>
<h3>Example heading <span class="badge bg-primary">New</span></h3>
<h4>Example heading <span class="badge bg-primary">New</span></h4>
<h5>Example heading <span class="badge bg-primary">New</span></h5>
<h6>Example heading <span class="badge bg-primary">New</span></h6>

`;

const buttons = `
<button type="button" class="btn btn-primary">
    Notifications <span class="badge text-white hp-bg-primary-2 hp-bg-dark-primary border-primary ms-8">4</span>
</button>

`;

const positioned = `
<button type="button" class="btn btn-primary position-relative me-24">
    Inbox
    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
        99+
        <span class="visually-hidden">unread messages</span>
    </span>
</button>

<button type="button" class="btn btn-primary position-relative">
    Profile
    <span class="position-absolute top-0 start-100 translate-middle p-8 bg-danger border border-light rounded-circle">
        <span class="visually-hidden">New alerts</span>
    </span>
</button>

`;

const background = `
<span class="badge bg-primary">Primary</span>
<span class="badge bg-secondary">Secondary</span>
<span class="badge bg-success">Success</span>
<span class="badge bg-danger">Danger</span>
<span class="badge bg-warning text-dark">Warning</span>
<span class="badge bg-info text-dark">Info</span>
<span class="badge bg-light text-dark">Light</span>
<span class="badge bg-dark">Dark</span>

`;

const pillBadges = `
<span class="badge rounded-pill bg-primary">Primary</span>
<span class="badge rounded-pill bg-secondary">Secondary</span>
<span class="badge rounded-pill bg-success">Success</span>
<span class="badge rounded-pill bg-danger">Danger</span>
<span class="badge rounded-pill bg-warning text-dark">Warning</span>
<span class="badge rounded-pill bg-info text-dark">Info</span>
<span class="badge rounded-pill bg-light text-dark">Light</span>
<span class="badge rounded-pill bg-dark">Dark</span>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "badge") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "headings") {
            $(this).text(headings)
        }

        if ($(this).data("code") === "buttons") {
            $(this).text(buttons)
        }

        if ($(this).data("code") === "positioned") {
            $(this).text(positioned)
        }

        if ($(this).data("code") === "background") {
            $(this).text(background)
        }

        if ($(this).data("code") === "pill-badges") {
            $(this).text(pillBadges)
        }
    }
});

const basicBreadcrumb = `
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item active" aria-current="page">Home</li>
  </ol>
</nav>

<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Library</li>
  </ol>
</nav>

<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item"><a href="#">Library</a></li>
    <li class="breadcrumb-item active" aria-current="page">Data</li>
  </ol>
</nav>

`;

const divider = `
<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Library</li>
  </ol>
</nav>

<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Library</li>
  </ol>
</nav>

<nav style="--bs-breadcrumb-divider: '';" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Library</li>
  </ol>
</nav>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "breadcrumb") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicBreadcrumb)
    }

    if ($(this).data("code") === "divider") {
      $(this).text(divider)
    }
  }
});

const exampleCard = `
<div class="card" style="max-width: 18rem;">
    <img src="..." class="card-img-top" alt="...">

    <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <p class="card-text hp-p1-body">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
        <a href="#" class="btn btn-primary">Go somewhere</a>
    </div>
</div>

`;

const bodyCard = `
<div class="card">
    <div class="card-body">
        This is some text within a card body.
    </div>
</div>

`;

const titlesTextLinks = `
<div class="card" style="max-width: 18rem;">
    <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <h6 class="card-subtitle mb-16 text-muted">Card subtitle</h6>
        <p class="card-text hp-p1-body">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
        <a href="#" class="card-link">Card link</a>
        <a href="#" class="card-link">Another link</a>
    </div>
</div>

`;

const imagesCard = `
<div class="card" style="max-width: 18rem;">
  <img src="..." class="card-img-top" alt="...">

  <div class="card-body">
      <p class="card-text hp-p1-body">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
  </div>
</div>

`;

const listGroups = `
<div class="card" style="max-width: 18rem;">
    <ul class="list-group list-group-flush">
        <li class="list-group-item">An item</li>
        <li class="list-group-item">A second item</li>
        <li class="list-group-item">A third item</li>
    </ul>
</div>

<div class="card" style="width: 18rem;">
    <div class="card-header">
        Featured
    </div>
    <ul class="list-group list-group-flush">
        <li class="list-group-item">An item</li>
        <li class="list-group-item">A second item</li>
        <li class="list-group-item">A third item</li>
    </ul>
</div>

<div class="card" style="width: 18rem;">
    <ul class="list-group list-group-flush">
        <li class="list-group-item">An item</li>
        <li class="list-group-item">A second item</li>
        <li class="list-group-item">A third item</li>
    </ul>
    <div class="card-footer">
        Card footer
    </div>
</div>

`;

const kitchenSink = `
<div class="card" style="max-width: 18rem;">
  <img src="..." class="card-img-top" alt="...">

  <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text hp-p1-body">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
  </div>

  <ul class="list-group list-group-flush">
      <li class="list-group-item">An item</li>
      <li class="list-group-item">A second item</li>
      <li class="list-group-item">A third item</li>
  </ul>

  <div class="card-body">
      <a href="#" class="card-link">Card link</a>
      <a href="#" class="card-link">Another link</a>
  </div>
</div>

`;

const headerAndFooter = `
<div class="card">
    <div class="card-header">
        Featured
    </div>

    <div class="card-body">
        <h5 class="card-title">Special title treatment</h5>
        <p class="card-text hp-p1-body">With supporting text below as a natural lead-in to additional content.</p>
        <a href="#" class="btn btn-primary">Go somewhere</a>
    </div>
</div>

<div class="card text-center">
    <div class="card-header">
        Featured
    </div>

    <div class="card-body">
        <h5 class="card-title">Special title treatment</h5>
        <p class="card-text hp-p1-body">With supporting text below as a natural lead-in to additional content.</p>
        <a href="#" class="btn btn-primary">Go somewhere</a>
    </div>

    <div class="card-footer text-muted">
        2 days ago
    </div>
</div>

`;

const navigation = `
<div class="card text-center">
    <div class="card-header">
        <ul class="nav nav-tabs card-header-tabs">
            <li class="nav-item">
                <a class="nav-link active" aria-current="true" href="#">Active</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
            </li>
        </ul>
    </div>

    <div class="card-body">
        <h5 class="card-title">Special title treatment</h5>
        <p class="card-text hp-p1-body">With supporting text below as a natural lead-in to additional content.</p>
        <a href="#" class="btn btn-primary">Go somewhere</a>
    </div>
</div>

<div class="card text-center">
    <div class="card-header">
        <ul class="nav nav-pills card-header-pills">
            <li class="nav-item">
                <a class="nav-link active" href="#">Active</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
            </li>
        </ul>
    </div>

    <div class="card-body">
        <h5 class="card-title">Special title treatment</h5>
        <p class="card-text hp-p1-body">With supporting text below as a natural lead-in to additional content.</p>
        <a href="#" class="btn btn-primary">Go somewhere</a>
    </div>
</div>

`;

const imageCaps = `
<div class="card mb-3">
  <img src="..." class="card-img-top" alt="...">

  <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
      <p class="card-text">
          <small class="text-muted">Last updated 3 mins ago</small>
      </p>
  </div>
</div>

<div class="card">
  <div class="card-body">
      <h5 class="card-title">Card title</h5>
      <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
      <p class="card-text">
          <small class="text-muted">Last updated 3 mins ago</small>
      </p>
  </div>

  <img src="..." class="card-img-bottom" alt="...">
</div>

`;

const imageOverlay = `
<div class="card bg-dark text-white">
  <img src="..." class="card-img" alt="...">

  <div class="card-img-overlay">
      <h5 class="card-title text-white">Card title</h5>
      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
      <p class="card-text">Last updated 3 mins ago</p>
  </div>
</div>

`;

const horizontalCard = `
<div class="card" style="max-width: 540px;">
  <div class="row g-0">
    <div class="col-md-4">
      <img src="..." class="img-fluid rounded-start" alt="...">
    </div>

    <div class="col-md-8">
        <div class="card-body">
            <h5 class="card-title">Card title</h5>
            <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            <p class="card-text">
                <small class="text-muted">Last updated 3 mins ago</small>
            </p>
        </div>
    </div>
  </div>
</div>

`;

const backgroundColor = `
<div class="card text-white bg-primary" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title text-white">Primary card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-white bg-secondary" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title text-white">Secondary card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-white bg-success" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title text-white">Success card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-white bg-danger" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title text-white">Danger card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-dark bg-warning" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title">Warning card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-dark bg-info" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title">Info card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-dark bg-light" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title">Light card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card text-white bg-dark" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title text-white">Dark card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

`;

const cardBorder = `
<div class="card border-primary" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body text-primary">
        <h5 class="card-title text-primary">Primary card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-secondary" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body text-secondary">
        <h5 class="card-title text-secondary">Secondary card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-success" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body text-success">
        <h5 class="card-title text-success">Success card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-danger" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body text-danger">
        <h5 class="card-title text-danger">Danger card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-warning" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title">Warning card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-info" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title">Info card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-light" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body">
        <h5 class="card-title">Light card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

<div class="card border-dark" style="max-width: 18rem;">
    <div class="card-header">Header</div>
    <div class="card-body text-dark">
        <h5 class="card-title">Dark card title</h5>
        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    </div>
</div>

`;

const cardGroups = `
<div class="card-group">
  <div class="card">
      <img src="..." class="card-img-top" alt="...">

      <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
          <p class="card-text">
              <small class="text-muted">Last updated 3 mins ago</small>
          </p>
      </div>
  </div>

  <div class="card">
      <img src="..." class="card-img-top" alt="...">

      <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-text hp-p1-body">This card has supporting text below as a natural lead-in to additional content.</p>
          <p class="card-text">
              <small class="text-muted">Last updated 3 mins ago</small>
          </p>
      </div>
  </div>

  <div class="card">
      <img src="..." class="card-img-top" alt="...">

      <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
          <p class="card-text">
              <small class="text-muted">Last updated 3 mins ago</small>
          </p>
      </div>
  </div>
</div>

<div class="card-group">
  <div class="card">
      <img src="..." class="card-img-top" alt="...">

      <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
      </div>
      <div class="card-footer">
          <small class="text-muted">Last updated 3 mins ago</small>
      </div>
  </div>

  <div class="card">
      <img src="..." class="card-img-top" alt="...">

      <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-text hp-p1-body">This card has supporting text below as a natural lead-in to additional content.</p>
      </div>
      <div class="card-footer">
          <small class="text-muted">Last updated 3 mins ago</small>
      </div>
  </div>

  <div class="card">
      <img src="..." class="card-img-top" alt="...">

      <div class="card-body">
          <h5 class="card-title">Card title</h5>
          <p class="card-text hp-p1-body">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action. This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
      </div>
      <div class="card-footer">
          <small class="text-muted">Last updated 3 mins ago</small>
      </div>
  </div>
</div>

`;

const cardGrid = `
  <div class="row row-cols-1 row-cols-md-2 g-16">
    <div class="col">
        <div class="card h-100">
            <img src="..." class="card-img-top" alt="...">

            <div class="card-body">
                <h5 class="card-title">Card title</h5>
                <p class="card-text hp-p1-body">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
        </div>
    </div>

    <div class="col">
        <div class="card h-100">
            <img src="..." class="card-img-top" alt="...">

            <div class="card-body">
                <h5 class="card-title">Card title</h5>
                <p class="card-text hp-p1-body">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer. This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer. This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
        </div>
    </div>

    <div class="col">
        <div class="card h-100">
            <img src="..." class="card-img-top" alt="...">

            <div class="card-body">
                <h5 class="card-title">Card title</h5>
                <p class="card-text hp-p1-body">This is a longer card with supporting text below as a natural lead-in to additional content.</p>
            </div>
        </div>
    </div>

    <div class="col">
        <div class="card h-100">
            <img src="..." class="card-img-top" alt="...">

            <div class="card-body">
                <h5 class="card-title">Card title</h5>
                <p class="card-text hp-p1-body">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
            </div>
        </div>
    </div>
  </div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "card") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "example") {
      $(this).text(exampleCard)
    }

    if ($(this).data("code") === "body") {
      $(this).text(bodyCard)
    }

    if ($(this).data("code") === "titles-text-links") {
      $(this).text(titlesTextLinks)
    }

    if ($(this).data("code") === "images") {
      $(this).text(imagesCard)
    }

    if ($(this).data("code") === "list-groups") {
      $(this).text(listGroups)
    }

    if ($(this).data("code") === "kitchen-sink") {
      $(this).text(kitchenSink)
    }

    if ($(this).data("code") === "header-and-footer") {
      $(this).text(headerAndFooter)
    }

    if ($(this).data("code") === "navigation") {
      $(this).text(navigation)
    }

    if ($(this).data("code") === "image-caps") {
      $(this).text(imageCaps)
    }

    if ($(this).data("code") === "image-overlay") {
      $(this).text(imageOverlay)
    }

    if ($(this).data("code") === "horizontal") {
      $(this).text(horizontalCard)
    }

    if ($(this).data("code") === "background-color") {
      $(this).text(backgroundColor)
    }

    if ($(this).data("code") === "card-border") {
      $(this).text(cardBorder)
    }

    if ($(this).data("code") === "card-groups") {
      $(this).text(cardGroups)
    }

    if ($(this).data("code") === "card-grid") {
      $(this).text(cardGrid)
    }
  }
});

const basicCarousel = `
<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>
</div>

`;

const controls = `
<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>

  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

`;

const indicators = `
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>

  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>

  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

`;

const captionsCarousel = `
<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>

    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="..." class="d-block w-100" alt="...">

            <div class="carousel-caption d-none d-md-block">
                <h5 class="text-white">First slide label</h5>
                <p>Some representative placeholder content for the first slide.</p>
            </div>
        </div>

        <div class="carousel-item">
            <img src="..." class="d-block w-100" alt="...">

            <div class="carousel-caption d-none d-md-block">
                <h5 class="text-white">Second slide label</h5>
                <p>Some representative placeholder content for the second slide.</p>
            </div>
        </div>

        <div class="carousel-item">
            <img src="..." class="d-block w-100" alt="...">

            <div class="carousel-caption d-none d-md-block">
                <h5 class="text-white">Third slide label</h5>
                <p>Some representative placeholder content for the third slide.</p>
            </div>
        </div>
    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>

    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

`;

const crossfade = `
<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>

  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

`;

const interval = `
<div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active" data-bs-interval="10000">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item" data-bs-interval="2000">
      <img src="..." class="d-block w-100" alt="...">
    </div>

    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>

  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

`;

const touch = `
<div id="carouselExampleControlsNoTouching" class="carousel slide" data-bs-touch="false" data-bs-interval="false">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>
  
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "carousel") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "basic") {
            $(this).text(basicCarousel)
        }
        
        if ($(this).data("code") === "controls") {
            $(this).text(controls)
        }

        if ($(this).data("code") === "indicators") {
            $(this).text(indicators)
        }

        if ($(this).data("code") === "captions") {
            $(this).text(captionsCarousel)
        }
        
        if ($(this).data("code") === "crossfade") {
            $(this).text(crossfade)
        }
        
        if ($(this).data("code") === "interval") {
            $(this).text(interval)
        }

        if ($(this).data("code") === "touch") {
            $(this).text(touch)
        }
    }
});

const basicCheckbox = `
<div class="form-check">
  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
  <label class="form-check-label" for="flexCheckDefault">
    Default checkbox
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
  <label class="form-check-label" for="flexCheckChecked">
    Checked checkbox
  </label>
</div>

`;

const disabledCheckbox = `
<div class="form-check">
  <input class="form-check-input" type="checkbox" value="" id="flexCheckDisabled" disabled>
  <label class="form-check-label" for="flexCheckDisabled">
    Disabled checkbox
  </label>
</div>

<div class="form-check">
  <input class="form-check-input" type="checkbox" value="" id="flexCheckCheckedDisabled" checked disabled>
  <label class="form-check-label" for="flexCheckCheckedDisabled">
    Disabled checked checkbox
  </label>
</div>
`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "checkbox") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicCheckbox)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledCheckbox)
    }
  }
});

const exampleCollapse = `
<a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
  Link with href
</a>

<button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
  Button with data-bs-target
</button>

<div class="collapse" id="collapseExample">
  <div class="card card-body mt-16">
    <p class="hp-p1-body mb-0">
      Some placeholder content for the collapse component. This panel is hidden by default but revealed when the user activates the relevant trigger.
    </p>
  </div>
</div>

`;

const multipleCollapse = `
<a class="btn btn-primary" data-bs-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Toggle first element</a>

<button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#multiCollapseExample2" aria-expanded="false" aria-controls="multiCollapseExample2">Toggle second element</button>

<button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target=".multi-collapse" aria-expanded="false" aria-controls="multiCollapseExample1 multiCollapseExample2">Toggle both elements</button>

<div class="row">
  <div class="col">
    <div class="collapse multi-collapse" id="multiCollapseExample1">
      <div class="card card-body mt-16">
        <p class="hp-p1-body mb-0">
          Some placeholder content for the first collapse component of this multi-collapse example. This panel is hidden by default but revealed when the user activates the relevant trigger.
        </p>
      </div>
    </div>
  </div>

  <div class="col">
    <div class="collapse multi-collapse" id="multiCollapseExample2">
      <div class="card card-body mt-16">
        <p class="hp-p1-body mb-0">
          Some placeholder content for the first collapse component of this multi-collapse example. This panel is hidden by default but revealed when the user activates the relevant trigger.
        </p>
      </div>
    </div>
  </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "collapse") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "example") {
      $(this).text(exampleCollapse)
    }

    if ($(this).data("code") === "multiple") {
      $(this).text(multipleCollapse)
    }
  }
});

const demoDrawer = `
<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
    Link with href
</a>

<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
    Button with data-bs-target
</button>

<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasExampleLabel">Offcanvas</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body">
        <div>
            Some text as placeholder. In real life you can have the elements you have chosen. Like, text, images, lists, etc.
        </div>

        <div class="dropdown mt-16">
            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown">
                Dropdown button
            </button>

            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li>
                    <a class="dropdown-item" href="#">Action</a>
                </li>
                <li>
                    <a class="dropdown-item" href="#">Another action</a>
                </li>
                <li>
                    <a class="dropdown-item" href="#">Something else here</a>
                </li>
            </ul>
        </div>
    </div>
</div>

`;

const placement = `
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">Toggle top offcanvas</button>

<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">Toggle right offcanvas</button>

<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom">Toggle bottom offcanvas</button>

<div class="offcanvas offcanvas-top" tabindex="-1" id="offcanvasTop" aria-labelledby="offcanvasTopLabel">
    <div class="offcanvas-header">
        <h5 id="offcanvasTopLabel">Offcanvas top</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body">
        ...
    </div>
</div>

<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header">
        <h5 id="offcanvasRightLabel">Offcanvas right</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body">
        ...
    </div>
</div>

<div class="offcanvas offcanvas-bottom" tabindex="-1" id="offcanvasBottom" aria-labelledby="offcanvasBottomLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasBottomLabel">Offcanvas bottom</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body small">
        ...
    </div>
</div>

`;

const backdrop = `
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">Enable body scrolling</button>
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBackdrop" aria-controls="offcanvasWithBackdrop">Enable backdrop (default)</button>
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions">Enable both scrolling & backdrop</button>

<div class="offcanvas offcanvas-start" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasScrollingLabel">Colored with scrolling</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <p>Try scrolling the rest of the page to see this option in action.</p>
    </div>
</div>

<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasWithBackdrop" aria-labelledby="offcanvasWithBackdropLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasWithBackdropLabel">Offcanvas with backdrop</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <p>.....</p>
    </div>
</div>

<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">Backdroped with scrolling</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <p>Try scrolling the rest of the page to see this option in action.</p>
    </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "drawer") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "demo") {
      $(this).text(demoDrawer)
    }

    if ($(this).data("code") === "placement") {
      $(this).text(placement)
    }

    if ($(this).data("code") === "backdrop") {
      $(this).text(backdrop)
    }
  }
});

const singleButton = `
<div class="dropdown">
  <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    Dropdown button
  </button>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    <li><a class="dropdown-item active" aria-current="true" href="javascript:;">Action</a></li>
    <li><a class="dropdown-item disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Another action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Something else here</a></li>
  </ul>
</div>

<div class="dropdown">
  <a class="btn btn-primary dropdown-toggle" href="javascript:;" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
    Dropdown link
  </a>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <li><a class="dropdown-item" href="javascript:;">Action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Another action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Something else here</a></li>
  </ul>
</div>

<div>
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Action
  </button>

  <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Action
  </button>
  
  <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Action
  </button>
  
  <button type="button" class="btn btn-info dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Action
  </button>

  <button type="button" class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Action
  </button>
  
  <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Action
  </button>

  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:;">Action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Another action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="javascript:;">Separated link</a></li>
  </ul>
</div>

`;

const splitButton = `
<div class="btn-group">
  <button type="button" class="btn btn-danger">Action</button>
  <button type="button" class="btn btn-danger dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>
  
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:;">Action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Another action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="javascript:;">Separated link</a></li>
  </ul>
</div>

`;

const sizing = `
<div class="btn-group">
  <button class="btn btn-primary btn-lg dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Large button
  </button>

  <ul class="dropdown-menu">
    ...
  </ul>
</div>

<div class="btn-group">
  <button class="btn btn-primary btn-lg" type="button">
    Large split button
  </button>
  <button type="button" class="btn btn-lg btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>

  <ul class="dropdown-menu">
    ...
  </ul>
</div>

<div class="btn-group">
  <button class="btn btn-primary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Small button
  </button>

  <ul class="dropdown-menu">
    ...
  </ul>
</div>

<div class="btn-group">
  <button class="btn btn-primary btn-sm" type="button">
    Small split button
  </button>
  <button type="button" class="btn btn-sm btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>

  <ul class="dropdown-menu">
    ...
  </ul>
</div>

`;

const dropup = `
<div class="btn-group dropup">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Dropup
  </button>

  <ul class="dropdown-menu">
    <li>...</li>
  </ul>
</div>

<div class="btn-group dropup">
  <button type="button" class="btn btn-primary">
    Split dropup
  </button>

  <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>

  <ul class="dropdown-menu">
    <li>...</li>
  </ul>
</div>

`;

const dropright = `
<div class="btn-group dropend">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Dropright
  </button>

  <ul class="dropdown-menu">
    <li>...</li>
  </ul>
</div>

<div class="btn-group dropend">
  <button type="button" class="btn btn-primary">
    Split dropend
  </button>
  <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropright</span>
  </button>

  <ul class="dropdown-menu">
    <li>...</li>
  </ul>
</div>

`;

const dropleft = `
<div class="btn-group dropstart">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Dropleft
  </button>

  <ul class="dropdown-menu">
    <li>...</li>
  </ul>
</div>

<div class="btn-group dropstart">
  <button type="button" class="btn btn-primary">
    Split dropstart
  </button>
  <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropleft</span>
  </button>

  <ul class="dropdown-menu">
    <li>...</li>
  </ul>
</div>

`;

const responsiveDropdown = `
<div class="btn-group">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
    Left-aligned but right aligned when large screen
  </button>
  <ul class="dropdown-menu dropdown-menu-lg-end">
    <li><button class="dropdown-item" type="button">Action</button></li>
    <li><button class="dropdown-item" type="button">Another action</button></li>
    <li><button class="dropdown-item" type="button">Something else here</button></li>
  </ul>
</div>

<div class="btn-group">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
    Right-aligned but left aligned when large screen
  </button>

  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start">
    <li><button class="dropdown-item" type="button">Action</button></li>
    <li><button class="dropdown-item" type="button">Another action</button></li>
    <li><button class="dropdown-item" type="button">Something else here</button></li>
  </ul>
</div>

`;

const alignment = `
<div class="btn-group">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Right-aligned menu
  </button>
  <ul class="dropdown-menu dropdown-menu-end">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
    Left-aligned, right-aligned lg
  </button>
  <ul class="dropdown-menu dropdown-menu-lg-end">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
    Right-aligned, left-aligned lg
  </button>
  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group dropstart">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Dropstart
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group dropend">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Dropend
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group dropup">
  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
    Dropup
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

`;

const dropdownOptions = `
<div class="dropdown">
  <button type="button" class="btn btn-primary dropdown-toggle" id="dropdownMenuOffset" data-bs-toggle="dropdown" aria-expanded="false" data-bs-offset="10,20">
    Offset
  </button>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuOffset">
    <li><a class="dropdown-item" href="javascript:;">Action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Another action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Something else here</a></li>
  </ul>
</div>

<div class="btn-group">
  <button type="button" class="btn btn-primary">Reference</button>
  <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" id="dropdownMenuReference" data-bs-toggle="dropdown" aria-expanded="false" data-bs-reference="parent">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuReference">
    <li><a class="dropdown-item" href="javascript:;">Action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Another action</a></li>
    <li><a class="dropdown-item" href="javascript:;">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="javascript:;">Separated link</a></li>
  </ul>
</div>

`;

const autoClose = `
<div class="btn-group">
  <button class="btn btn-primary dropdown-toggle" type="button" id="defaultDropdown" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="false">
    Default dropdown
  </button>
  <ul class="dropdown-menu" aria-labelledby="defaultDropdown">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group">
  <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuClickableOutside" data-bs-toggle="dropdown" data-bs-auto-close="inside" aria-expanded="false">
    Clickable outside
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuClickableOutside">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group">
  <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
    Clickable inside
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuClickableInside">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

<div class="btn-group">
  <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuClickable" data-bs-toggle="dropdown" data-bs-auto-close="false" aria-expanded="false">
    Manual close
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuClickable">
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
    <li><a class="dropdown-item" href="javascript:;">Menu item</a></li>
  </ul>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "dropdown") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "single-button") {
      $(this).text(singleButton)
    }

    if ($(this).data("code") === "split-button") {
      $(this).text(splitButton)
    }

    if ($(this).data("code") === "sizing") {
      $(this).text(sizing)
    }

    if ($(this).data("code") === "dropup") {
      $(this).text(dropup)
    }
    
    if ($(this).data("code") === "dropright") {
      $(this).text(dropright)
    }
    
    if ($(this).data("code") === "dropleft") {
      $(this).text(dropleft)
    }
    
    if ($(this).data("code") === "responsive") {
      $(this).text(responsiveDropdown)
    }
    
    if ($(this).data("code") === "alignment") {
      $(this).text(alignment)
    }
    
    if ($(this).data("code") === "dropdown-options") {
      $(this).text(dropdownOptions)
    }
    
    if ($(this).data("code") === "auto-close") {
      $(this).text(autoClose)
    }
  }
});

const basicForm = `
<form>
  <div class="mb-24">
    <label for="exampleInputEmail1" class="form-label">Email address</label>
    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
  </div>

  <div class="mb-24">
    <label for="exampleInputPassword1" class="form-label">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1">
  </div>

  <div class="mb-24 form-check">
    <input type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">Check me out</label>
  </div>

  <button type="submit" class="btn btn-primary">Submit</button>
</form>

`;

const disabledForm = `
<form>
  <div class="mb-24">
    <label for="disabledTextInput" class="form-label">Disabled input</label>
    <input type="text" id="disabledTextInput" class="form-control" placeholder="Disabled input" disabled>
  </div>

  <div class="mb-24">
    <label for="disabledSelect" class="form-label">Disabled select menu</label>
    <select id="disabledSelect" class="form-select" disabled>
      <option>Disabled select</option>
    </select>
  </div>

  <div class="mb-24">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="disabledFieldsetCheck" disabled>
      <label class="form-check-label" for="disabledFieldsetCheck">
        Can't check this
      </label>
    </div>
  </div>

  <button type="submit" class="btn btn-primary" disabled>Submit</button>
</form>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "form") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicForm)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledForm)
    }
  }
});

const basicInputNumber = `
<div class="input-number">
    <div class="input-number-handler-wrap">
        <span class="input-number-handler input-number-handler-up">
            <span class="input-number-handler-up-inner">
                <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                    <path d="M890.5 755.3L537.9 269.2c-12.8-17.6-39-17.6-51.7 0L133.5 755.3A8 8 0 00140 768h75c5.1 0 9.9-2.5 12.9-6.6L512 369.8l284.1 391.6c3 4.1 7.8 6.6 12.9 6.6h75c6.5 0 10.3-7.4 6.5-12.7z"></path>
                </svg>
            </span>
        </span>

        <span class="input-number-handler input-number-handler-down input-number-handler-down-disabled">
            <span class="input-number-handler-down-inner">
                <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                    <path d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path>
                </svg>
            </span>
        </span>
    </div>

    <div class="input-number-input-wrap">
        <input class="input-number-input" type="number" min="1" max="10" value="1">
    </div>
</div>

`;

const disabledInputNumber = `
<div class="input-number input-number-disabled">
    <div class="input-number-handler-wrap">
        <span class="input-number-handler input-number-handler-up">
            <span class="input-number-handler-up-inner">
                <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                    <path d="M890.5 755.3L537.9 269.2c-12.8-17.6-39-17.6-51.7 0L133.5 755.3A8 8 0 00140 768h75c5.1 0 9.9-2.5 12.9-6.6L512 369.8l284.1 391.6c3 4.1 7.8 6.6 12.9 6.6h75c6.5 0 10.3-7.4 6.5-12.7z"></path>
                </svg>
            </span>
        </span>

        <span class="input-number-handler input-number-handler-down input-number-handler-down-disabled">
            <span class="input-number-handler-down-inner">
                <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                    <path d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path>
                </svg>
            </span>
        </span>
    </div>

    <div class="input-number-input-wrap">
        <input class="input-number-input" type="number" min="1" max="10" value="1" disabled>
    </div>
</div>

`;

const sizesInputNumber = `
<div class="input-number input-number-lg">
  <div class="input-number-handler-wrap">
      <span class="input-number-handler input-number-handler-up">
          <span class="input-number-handler-up-inner">
              <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                  <path d="M890.5 755.3L537.9 269.2c-12.8-17.6-39-17.6-51.7 0L133.5 755.3A8 8 0 00140 768h75c5.1 0 9.9-2.5 12.9-6.6L512 369.8l284.1 391.6c3 4.1 7.8 6.6 12.9 6.6h75c6.5 0 10.3-7.4 6.5-12.7z"></path>
              </svg>
          </span>
      </span>

      <span class="input-number-handler input-number-handler-down input-number-handler-down-disabled">
          <span class="input-number-handler-down-inner">
              <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                  <path d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path>
              </svg>
          </span>
      </span>
  </div>

  <div class="input-number-input-wrap">
      <input class="input-number-input" type="number" min="1" max="10" value="1">
  </div>
</div>

<div class="input-number">
  <div class="input-number-handler-wrap">
      <span class="input-number-handler input-number-handler-up">
          <span class="input-number-handler-up-inner">
              <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                  <path d="M890.5 755.3L537.9 269.2c-12.8-17.6-39-17.6-51.7 0L133.5 755.3A8 8 0 00140 768h75c5.1 0 9.9-2.5 12.9-6.6L512 369.8l284.1 391.6c3 4.1 7.8 6.6 12.9 6.6h75c6.5 0 10.3-7.4 6.5-12.7z"></path>
              </svg>
          </span>
      </span>

      <span class="input-number-handler input-number-handler-down input-number-handler-down-disabled">
          <span class="input-number-handler-down-inner">
              <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                  <path d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path>
              </svg>
          </span>
      </span>
  </div>

  <div class="input-number-input-wrap">
      <input class="input-number-input" type="number" min="1" max="10" value="1">
  </div>
</div>

<div class="input-number input-number-sm">
  <div class="input-number-handler-wrap">
      <span class="input-number-handler input-number-handler-up">
          <span class="input-number-handler-up-inner">
              <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                  <path d="M890.5 755.3L537.9 269.2c-12.8-17.6-39-17.6-51.7 0L133.5 755.3A8 8 0 00140 768h75c5.1 0 9.9-2.5 12.9-6.6L512 369.8l284.1 391.6c3 4.1 7.8 6.6 12.9 6.6h75c6.5 0 10.3-7.4 6.5-12.7z"></path>
              </svg>
          </span>
      </span>

      <span class="input-number-handler input-number-handler-down input-number-handler-down-disabled">
          <span class="input-number-handler-down-inner">
              <svg viewBox="64 64 896 896" width="1em" height="1em" fill="currentColor">
                  <path d="M884 256h-75c-5.1 0-9.9 2.5-12.9 6.6L512 654.2 227.9 262.6c-3-4.1-7.8-6.6-12.9-6.6h-75c-6.5 0-10.3 7.4-6.5 12.7l352.6 486.1c12.8 17.6 39 17.6 51.7 0l352.6-486.1c3.9-5.3.1-12.7-6.4-12.7z"></path>
              </svg>
          </span>
      </span>
  </div>

  <div class="input-number-input-wrap">
      <input class="input-number-input" type="number" min="1" max="10" value="1">
  </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "input-number") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicInputNumber)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledInputNumber)
    }

    if ($(this).data("code") === "sizes") {
      $(this).text(sizesInputNumber)
    }
  }
});

const basicInput = `
<input type="text" class="form-control mb-16" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">

<div class="input-group mb-16">
  <span class="input-group-text" id="basic-addon1">@</span>
  <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
</div>

<div class="input-group mb-16">
  <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="basic-addon2">
  <span class="input-group-text" id="basic-addon2">@example.com</span>
</div>

<label for="basic-url" class="form-label">Your vanity URL</label>
<div class="input-group mb-16">
  <span class="input-group-text" id="basic-addon3">https://example.com/users/</span>
  <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3">
</div>

<div class="input-group mb-16">
  <span class="input-group-text">$</span>
  <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
  <span class="input-group-text">.00</span>
</div>

<div class="input-group mb-16">
  <input type="text" class="form-control" placeholder="Username" aria-label="Username">
  <span class="input-group-text">@</span>
  <input type="text" class="form-control" placeholder="Server" aria-label="Server">
</div>

<div class="input-group">
  <span class="input-group-text">With textarea</span>
  <textarea class="form-control" aria-label="With textarea"></textarea>
</div>

`;

const sizingInput = `
<div class="input-group input-group-sm mb-16">
  <span class="input-group-text" id="inputGroup-sizing-sm">Small</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
</div>

<div class="input-group mb-16">
  <span class="input-group-text" id="inputGroup-sizing-default">Default</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
</div>

<div class="input-group input-group-lg">
  <span class="input-group-text" id="inputGroup-sizing-lg">Large</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
</div>

`;

const checkboxesRadios = `
<div class="input-group mb-16">
  <div class="input-group-text">
    <input class="form-check-input mt-0" type="checkbox" value="" aria-label="Checkbox for following text input">
  </div>
  <input type="text" class="form-control" aria-label="Text input with checkbox">
</div>

<div class="input-group">
  <div class="input-group-text">
    <input class="form-check-input mt-0" type="radio" value="" aria-label="Radio button for following text input">
  </div>
  <input type="text" class="form-control" aria-label="Text input with radio button">
</div>

`;

const multipleInput = `
<div class="input-group">
  <span class="input-group-text">First and last name</span>
  <input type="text" aria-label="First name" class="form-control">
  <input type="text" aria-label="Last name" class="form-control">
</div>

`;

const addons = `
<div class="input-group mb-16">
  <span class="input-group-text">$</span>
  <span class="input-group-text">0.00</span>
  <input type="text" class="form-control" aria-label="Dollar amount (with dot and two decimal places)">
</div>

<div class="input-group">
  <input type="text" class="form-control" aria-label="Dollar amount (with dot and two decimal places)">
  <span class="input-group-text">$</span>
  <span class="input-group-text">0.00</span>
</div>

`;

const buttonAddons = `
<div class="input-group mb-16">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button" id="button-addon1">Button</button>
  <input type="text" class="form-control" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
</div>

<div class="input-group mb-16">
  <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button" id="button-addon2">Button</button>
</div>

<div class="input-group mb-16">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button">Button</button>
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button">Button</button>
  <input type="text" class="form-control" placeholder="" aria-label="Example text with two button addons">
</div>

<div class="input-group">
  <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username with two button addons">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button">Button</button>
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button">Button</button>
</div>

`;

const buttonDropdowns = `
<div class="input-group mb-16">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0 dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="#">Separated link</a></li>
  </ul>
  <input type="text" class="form-control" aria-label="Text input with dropdown button">
</div>

<div class="input-group mb-16">
  <input type="text" class="form-control" aria-label="Text input with dropdown button">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0 dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</button>
  <ul class="dropdown-menu dropdown-menu-end">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="#">Separated link</a></li>
  </ul>
</div>

<div class="input-group">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0 dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Action before</a></li>
    <li><a class="dropdown-item" href="#">Another action before</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="#">Separated link</a></li>
  </ul>
  <input type="text" class="form-control" aria-label="Text input with 2 dropdown buttons">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0 dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</button>
  <ul class="dropdown-menu dropdown-menu-end">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="#">Separated link</a></li>
  </ul>
</div>

`;

const segmented = `
<div class="input-group mb-16">
  <button type="button" class="btn btn-outline-primary text-primary hp-hover-text-color-black-0">Action</button>
  <button type="button" class="btn btn-outline-primary text-primary hp-hover-text-color-black-0 dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="#">Separated link</a></li>
  </ul>
  <input type="text" class="form-control" aria-label="Text input with segmented dropdown button">
</div>

<div class="input-group">
  <input type="text" class="form-control" aria-label="Text input with segmented dropdown button">
  <button type="button" class="btn btn-outline-primary text-primary hp-hover-text-color-black-0">Action</button>
  <button type="button" class="btn btn-outline-primary text-primary hp-hover-text-color-black-0 dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
    <span class="visually-hidden">Toggle Dropdown</span>
  </button>
  <ul class="dropdown-menu dropdown-menu-end">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="#">Separated link</a></li>
  </ul>
</div>

`;

const selectInput = `
<div class="input-group mb-16">
  <label class="input-group-text" for="inputGroupSelect01">Options</label>
  <select class="form-select" id="inputGroupSelect01">
    <option selected>Choose...</option>
    <option value="1">One</option>
    <option value="2">Two</option>
    <option value="3">Three</option>
  </select>
</div>

<div class="input-group mb-16">
  <select class="form-select" id="inputGroupSelect02">
    <option selected>Choose...</option>
    <option value="1">One</option>
    <option value="2">Two</option>
    <option value="3">Three</option>
  </select>
  <label class="input-group-text" for="inputGroupSelect02">Options</label>
</div>

<div class="input-group mb-16">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button">Button</button>
  <select class="form-select" id="inputGroupSelect03" aria-label="Example select with button addon">
    <option selected>Choose...</option>
    <option value="1">One</option>
    <option value="2">Two</option>
    <option value="3">Three</option>
  </select>
</div>

<div class="input-group">
  <select class="form-select" id="inputGroupSelect04" aria-label="Example select with button addon">
    <option selected>Choose...</option>
    <option value="1">One</option>
    <option value="2">Two</option>
    <option value="3">Three</option>
  </select>
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button">Button</button>
</div>

`;

const fileInput = `
<div class="input-group mb-16">
  <label class="input-group-text" for="inputGroupFile01">Upload</label>
  <input type="file" class="form-control" id="inputGroupFile01">
</div>

<div class="input-group mb-16">
  <input type="file" class="form-control" id="inputGroupFile02">
  <label class="input-group-text" for="inputGroupFile02">Upload</label>
</div>

<div class="input-group mb-16">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button" id="inputGroupFileAddon03">Button</button>
  <input type="file" class="form-control" id="inputGroupFile03" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
</div>

<div class="input-group">
  <input type="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
  <button class="btn btn-outline-primary text-primary hp-hover-text-color-black-0" type="button" id="inputGroupFileAddon04">Button</button>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "input") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicInput)
    }

    if ($(this).data("code") === "sizing") {
      $(this).text(sizingInput)
    }

    if ($(this).data("code") === "checkboxes-radios") {
      $(this).text(checkboxesRadios)
    }

    if ($(this).data("code") === "multiple") {
      $(this).text(multipleInput)
    }

    if ($(this).data("code") === "button-addons") {
      $(this).text(buttonAddons)
    }

    if ($(this).data("code") === "button-dropdowns") {
      $(this).text(buttonDropdowns)
    }

    if ($(this).data("code") === "segmented") {
      $(this).text(segmented)
    }

    if ($(this).data("code") === "select") {
      $(this).text(selectInput)
    }

    if ($(this).data("code") === "file-input") {
      $(this).text(fileInput)
    }
  }
});

const basicList = `
<ul class="list-group">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
  <li class="list-group-item">A fourth item</li>
  <li class="list-group-item">And a fifth one</li>
</ul>

`;

const activeItems = `
<ul class="list-group">
  <li class="list-group-item active" aria-current="true">An active item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
  <li class="list-group-item">A fourth item</li>
  <li class="list-group-item">And a fifth one</li>
</ul>

`;

const disabledList = `
<ul class="list-group">
  <li class="list-group-item disabled" aria-disabled="true">A disabled item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
  <li class="list-group-item">A fourth item</li>
  <li class="list-group-item">And a fifth one</li>
</ul>

`;

const linksAndButtons = `
<div class="list-group">
  <a href="#" class="list-group-item list-group-item-action active" aria-current="true">
    The current link item
  </a>
  <a href="#" class="list-group-item list-group-item-action">A second link item</a>
  <a href="#" class="list-group-item list-group-item-action">A third link item</a>
  <a href="#" class="list-group-item list-group-item-action">A fourth link item</a>
  <a href="#" class="list-group-item list-group-item-action disabled" tabindex="-1" aria-disabled="true">A disabled link item</a>
</div>

<div class="list-group">
  <button type="button" class="list-group-item list-group-item-action active" aria-current="true">
    The current button
  </button>
  <button type="button" class="list-group-item list-group-item-action">A second item</button>
  <button type="button" class="list-group-item list-group-item-action">A third button item</button>
  <button type="button" class="list-group-item list-group-item-action">A fourth button item</button>
  <button type="button" class="list-group-item list-group-item-action" disabled>A disabled button item</button>
</div>

`;

const flushList = `
<ul class="list-group list-group-flush">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
  <li class="list-group-item">A fourth item</li>
  <li class="list-group-item">And a fifth one</li>
</ul>

`;

const numbered = `
<ol class="list-group list-group-numbered">
  <li class="list-group-item">Cras justo odio</li>
  <li class="list-group-item">Cras justo odio</li>
  <li class="list-group-item">Cras justo odio</li>
</ol>

<ol class="list-group list-group-numbered">
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold">Subheading</div>
      Cras justo odio
    </div>
    <span class="badge bg-primary rounded-pill">14</span>
  </li>

  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold">Subheading</div>
      Cras justo odio
    </div>
    <span class="badge bg-primary rounded-pill">14</span>
  </li>

  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
      <div class="fw-bold">Subheading</div>
      Cras justo odio
    </div>
    <span class="badge bg-primary rounded-pill">14</span>
  </li>
</ol>

`;

const horizontalList = `
<ul class="list-group list-group-horizontal">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
</ul>

<ul class="list-group list-group-horizontal-sm">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
</ul>

<ul class="list-group list-group-horizontal-md">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
</ul>

<ul class="list-group list-group-horizontal-lg">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
</ul>

<ul class="list-group list-group-horizontal-xl">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
</ul>

<ul class="list-group list-group-horizontal-xxl">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
</ul>

`;

const contextual = `
<ul class="list-group">
  <li class="list-group-item">A simple default list group item</li>

  <li class="list-group-item list-group-item-primary">A simple primary list group item</li>
  <li class="list-group-item list-group-item-secondary">A simple secondary list group item</li>
  <li class="list-group-item list-group-item-success">A simple success list group item</li>
  <li class="list-group-item list-group-item-danger">A simple danger list group item</li>
  <li class="list-group-item list-group-item-warning">A simple warning list group item</li>
  <li class="list-group-item list-group-item-info">A simple info list group item</li>
  <li class="list-group-item list-group-item-light">A simple light list group item</li>
  <li class="list-group-item list-group-item-dark">A simple dark list group item</li>
</ul>

<div class="list-group">
  <a href="#" class="list-group-item list-group-item-action">A simple default list group item</a>

  <a href="#" class="list-group-item list-group-item-action list-group-item-primary">A simple primary list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-secondary">A simple secondary list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-success">A simple success list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-danger">A simple danger list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-warning">A simple warning list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-info">A simple info list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-light">A simple light list group item</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-dark">A simple dark list group item</a>
</div>

`;

const badges = `
<ul class="list-group">
  <li class="list-group-item d-flex justify-content-between align-items-center">
    A list item
    <span class="badge bg-primary rounded-pill">14</span>
  </li>

  <li class="list-group-item d-flex justify-content-between align-items-center">
    A second list item
    <span class="badge bg-primary rounded-pill">2</span>
  </li>

  <li class="list-group-item d-flex justify-content-between align-items-center">
    A third list item
    <span class="badge bg-primary rounded-pill">1</span>
  </li>
</ul>

`;

const customContent = `
<div class="list-group">
  <a href="#" class="list-group-item list-group-item-action active" aria-current="true">
    <div class="d-flex w-100 justify-content-between">
      <h5 class="mb-1">List group item heading</h5>
      <small>3 days ago</small>
    </div>
    <p class="mb-1">Some placeholder content in a paragraph.</p>
    <small>And some small print.</small>
  </a>
  
  <a href="#" class="list-group-item list-group-item-action">
    <div class="d-flex w-100 justify-content-between">
      <h5 class="mb-1">List group item heading</h5>
      <small class="text-muted">3 days ago</small>
    </div>
    <p class="mb-1">Some placeholder content in a paragraph.</p>
    <small class="text-muted">And some muted small print.</small>
  </a>
  
  <a href="#" class="list-group-item list-group-item-action">
    <div class="d-flex w-100 justify-content-between">
      <h5 class="mb-1">List group item heading</h5>
      <small class="text-muted">3 days ago</small>
    </div>
    <p class="mb-1">Some placeholder content in a paragraph.</p>
    <small class="text-muted">And some muted small print.</small>
  </a>
</div>

`;

const checkboxesAndRadios = `
<ul class="list-group">
  <li class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
    First checkbox
  </li>

  <li class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
    Second checkbox
  </li>

  <li class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
    Third checkbox
  </li>

  <li class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
    Fourth checkbox
  </li>

  <li class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
    Fifth checkbox
  </li>
</ul>

<div class="list-group">
  <label class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="">
    First checkbox
  </label>
  
  <label class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="">
    Second checkbox
  </label>
  
  <label class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="">
    Third checkbox
  </label>
  
  <label class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="">
    Fourth checkbox
  </label>
  
  <label class="list-group-item">
    <input class="form-check-input me-1" type="checkbox" value="">
    Fifth checkbox
  </label>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "list") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicList)
    }

    if ($(this).data("code") === "active-items") {
      $(this).text(activeItems)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledList)
    }

    if ($(this).data("code") === "links-and-buttons") {
      $(this).text(linksAndButtons)
    }

    if ($(this).data("code") === "flush") {
      $(this).text(flushList)
    }

    if ($(this).data("code") === "numbered") {
      $(this).text(numbered)
    }

    if ($(this).data("code") === "horizontal") {
      $(this).text(horizontalList)
    }

    if ($(this).data("code") === "contextual") {
      $(this).text(contextual)
    }

    if ($(this).data("code") === "badges") {
      $(this).text(badges)
    }

    if ($(this).data("code") === "custom-content") {
      $(this).text(customContent)
    }

    if ($(this).data("code") === "checkboxes-and-radios") {
      $(this).text(checkboxesAndRadios)
    }
  }
});

const supportedContent = `
<nav class="navbar navbar-expand-lg navbar-light hp-bg-black-10 rounded">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mb-16 mb-lg-0 me-auto">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdown" role="button"
            data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>

          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li>
              <a class="dropdown-item" href="javascript:;">Action</a>
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Another action</a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Something else here</a>
            </li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>

      <form class="d-flex mb-8 mb-lg-0">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

`;

const textMenu = `
<nav class="navbar navbar-light hp-bg-black-10 rounded">
  <div class="container-fluid">
    <a class="navbar-brand" href="javascript:;">Yoda</a>
  </div>
</nav>

<nav class="navbar navbar-light hp-bg-black-10 rounded">
  <div class="container-fluid">
    <span class="navbar-brand mb-0 h1">Yoda</span>
  </div>
</nav>

`;

const imageMenu = `
<nav class="navbar navbar-light hp-bg-black-10 rounded">
  <div class="container">
    <a class="navbar-brand" href="javascript:;">
      <img src="..." alt="...">
    </a>
  </div>
</nav>

`;

const navMenu = `
<nav class="navbar navbar-expand-lg navbar-light hp-bg-black-10 rounded">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Features</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Pricing</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<nav class="navbar navbar-expand-lg navbar-light hp-bg-black-10 rounded">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
      aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Features</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Pricing</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdownMenuLink" role="button"
            data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown link
          </a>

          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <li>
              <a class="dropdown-item" href="javascript:;">Action</a>
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Another action</a>
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Something else here</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

`;

const colorSchemeMenu = `
<nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColorScheme1"
      aria-controls="navbarColorScheme1" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarColorScheme1">
      <ul class="navbar-nav me-auto mb-16 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdown" role="button"
            data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>

          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li>
              <a class="dropdown-item" href="javascript:;">Action</a>
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Another action</a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Something else here</a>
            </li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>

      <form class="d-flex">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary-3" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<nav class="navbar navbar-expand-lg navbar-dark hp-bg-primary-3 rounded">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColorScheme2"
      aria-controls="navbarColorScheme2" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarColorScheme2">
      <ul class="navbar-nav me-auto mb-16 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdown" role="button"
            data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>

          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li>
              <a class="dropdown-item" href="javascript:;">Action</a>
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Another action</a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Something else here</a>
            </li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>

      <form class="d-flex">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

`;

const scrollingMenu = `
<nav class="navbar navbar-expand-lg navbar-light bg-light rounded">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll"
      aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarScroll">
      <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarScrollingDropdown" role="button"
            data-bs-toggle="dropdown" aria-expanded="false">
            Link
          </a>

          <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
            <li>
              <a class="dropdown-item" href="javascript:;">Action</a>
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Another action</a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li>
              <a class="dropdown-item" href="javascript:;">Something else here</a>
            </li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Link</a>
        </li>
      </ul>

      <form class="d-flex mt-24 mt-lg-0">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

`;

const toggler = `
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01"
      aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse mt-8 mt-lg-0" id="navbarTogglerDemo01">
      <a class="navbar-brand me-8" href="javascript:;">
        <img src="..." alt="...">
      </a>

      <ul class="navbar-nav me-auto mb-16 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>

      <form class="d-flex">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02"
      aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav me-auto mb-16 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>

      <form class="d-flex">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo03"
      aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <a class="navbar-brand me-8" href="javascript:;">
      <img src="..." alt="...">
    </a>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
      <ul class="navbar-nav me-auto mb-16 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="javascript:;">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:;">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="javascript:;" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>

      <form class="d-flex">
        <input class="form-control me-8" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

`;

const externalContent = `
<nav class="navbar navbar-dark bg-dark rounded">
  <div class="collapse" id="navbarToggleExternalContent">
    <div class="bg-dark pt-16 px-24 pb-32">
      <h5 class="text-white h4">Collapsed content</h5>
      <span class="text-muted hp-p1-body">Toggleable via the navbar brand.</span>
    </div>
  </div>

  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent"
      aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  </div>
</nav>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "menu") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "supported-content") {
            $(this).text(supportedContent)
        }

        if ($(this).data("code") === "text-menu") {
            $(this).text(textMenu)
        }

        if ($(this).data("code") === "image-menu") {
            $(this).text(imageMenu)
        }

        if ($(this).data("code") === "nav-menu") {
            $(this).text(navMenu)
        }

        if ($(this).data("code") === "color-scheme-menu") {
            $(this).text(colorSchemeMenu)
        }

        if ($(this).data("code") === "scrolling-menu") {
            $(this).text(scrollingMenu)
        }

        if ($(this).data("code") === "toggler") {
            $(this).text(toggler)
        }

        if ($(this).data("code") === "external-content") {
            $(this).text(externalContent)
        }
    }
});

const demoModal = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Launch demo modal
</button>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

`;

const staticModal = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
    Launch static backdrop modal
</button>

<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

`;

const scrolling = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#scrollableBackdrop">
    Launch demo modal
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#scrollable2Backdrop">
    Launch demo modal
</button>

<div class="modal fade" id="scrollableBackdrop" tabindex="-1" aria-labelledby="scrollableBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scrollableBackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <p>This is some placeholder content to show the scrolling behavior for modals. We use repeated line breaks to demonstrate how content can exceed minimum inner height, thereby showing inner scrolling. When content becomes longer than the prefedined max-height of modal, content will be cropped and scrollable within the modal.</p>
                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                <p>This content should appear at the bottom after you scroll.</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="scrollable2Backdrop" tabindex="-1" aria-labelledby="scrollable2BackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scrollable2BackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <p>This is some placeholder content to show the scrolling behavior for modals. We use repeated line breaks to demonstrate how content can exceed minimum inner height, thereby showing inner scrolling. When content becomes longer than the prefedined max-height of modal, content will be cropped and scrollable within the modal.</p>
                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                <p>This content should appear at the bottom after you scroll.</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

`;

const vertically = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#centeredBackdrop">
    Vertical centered modal
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#centered2Backdrop">
    Vertical centered scrollable modal
</button>

<div class="modal fade" id="centeredBackdrop" tabindex="-1" aria-labelledby="centeredBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="centeredBackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <p>This is a vertically centered modal.</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="centered2Backdrop" tabindex="-1" aria-labelledby="centered2BackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="centered2BackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <p>This is some placeholder content to show the scrolling behavior for modals. We use repeated line breaks to demonstrate how content can exceed minimum inner height, thereby showing inner scrolling. When content becomes longer than the prefedined max-height of modal, content will be cropped and scrollable within the modal.</p>
                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                <p>This content should appear at the bottom after you scroll.</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

`;

const tooltipPopovers = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#tooltipPopoverBackdrop">
    Launch demo modal
</button>

<div class="modal fade" id="tooltipPopoverBackdrop" tabindex="-1" aria-labelledby="tooltipPopoverBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tooltipPopoverBackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <h5>Popover in a modal</h5>
                <p>This <a href="javascript:;" role="button" class="btn btn-primary popover-test" data-bs-toggle="popover" title="Popover title" data-bs-content="Popover body content is set in this attribute.">button</a> triggers a popover on click.</p>
                <div class="divider"></div>
                <h5>Tooltips in a modal</h5>
                <p>
                    <a href="javascript:;" class="tooltip-test" data-bs-toggle="tooltip" data-bs-placement="top" title="Tooltip">This link</a> and <a href="javascript:;" class="tooltip-test" data-bs-toggle="tooltip" data-bs-placement="top" title="Tooltip">that link</a> have tooltips on hover.
                </p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

`;

const grid = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#gridBackdrop">
    Launch demo modal
</button>

<div class="modal fade" id="gridBackdrop" tabindex="-1" aria-labelledby="gridBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="gridBackdropLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-4">.col-md-4</div>
                        <div class="col-md-4 ms-auto">.col-md-4 .ms-auto</div>
                    </div>

                    <div class="row">
                        <div class="col-md-3 ms-auto">.col-md-3 .ms-auto</div>
                        <div class="col-md-2 ms-auto">.col-md-2 .ms-auto</div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 ms-auto">.col-md-6 .ms-auto</div>
                    </div>

                    <div class="row">
                        <div class="col-sm-9">
                            Level 1: .col-sm-9

                            <div class="row">
                                <div class="col-8 col-sm-6">
                                    Level 2: .col-8 .col-sm-6
                                </div>
                                <div class="col-4 col-sm-6">
                                    Level 2: .col-4 .col-sm-6
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>

`;

const varying = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#varyingModal" data-bs-whatever="@mdo">Open modal for @mdo</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#varyingModal" data-bs-whatever="@fat">Open modal for @fat</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#varyingModal" data-bs-whatever="@getbootstrap">Open modal for @getbootstrap</button>

<div class="modal fade" id="varyingModal" tabindex="-1" aria-labelledby="varyingModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="varyingModalLabel">New message</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="recipient-name" class="col-form-label">Recipient:</label>
                        <input type="text" class="form-control" id="recipient-name">
                    </div>
                    <div class="mb-3">
                        <label for="message-text" class="col-form-label">Message:</label>
                        <textarea class="form-control" id="message-text"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Send message</button>
            </div>
        </div>
    </div>
</div>

var varyingModal = document.getElementById('varyingModal')
if (varyingModal) {
    varyingModal.addEventListener('show.bs.modal', function (event) {
        // Button that triggered the modal
        var button = event.relatedTarget
        // Extract info from data-bs-* attributes
        var recipient = button.getAttribute('data-bs-whatever')
        // If necessary, you could initiate an AJAX request here
        // and then do the updating in a callback.
        //
        // Update the modal's content.
        var modalTitle = varyingModal.querySelector('.modal-title')
        var modalBodyInput = varyingModal.querySelector('.modal-body input')

        modalTitle.textContent = 'New message to ' + recipient
        modalBodyInput.value = recipient
    })
}

`;

const between = `
<a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">Open first modal</a>

<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">Modal 1</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Show a second modal and hide this one with the button below.
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal" data-bs-dismiss="modal">Open second modal</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Hide this modal and show the first with the button below.
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" data-bs-dismiss="modal">Back to first</button>
            </div>
        </div>
    </div>
</div>

`;

const remove = `
<div class="modal" tabindex="-1" aria-labelledby="..." aria-hidden="true">
    ...
</div>

`;

const sizes = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#xlModal">
    Extra large modal
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#lgModal">
    Large modal
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#smModal">
    Small modal
</button>

<div class="modal fade" id="xlModal" tabindex="-1" aria-labelledby="xlModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="xlModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="lgModal" tabindex="-1" aria-labelledby="lgModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lgModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="smModal" tabindex="-1" aria-labelledby="smModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="smModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

`;

const fullscreen = `
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#fullModal">
    Full screen
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#smFullModal">
    Full screen below sm
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#mdFullModal">
    Full screen below md
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#lgFullModal">
    Full screen below lg
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#xlFullModal">
    Full screen below xl
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#xxlFullModal">
    Full screen below xxl
</button>

<div class="modal fade" id="fullModal" tabindex="-1" aria-labelledby="fullModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="fullModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="smFullModal" tabindex="-1" aria-labelledby="smFullModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="smFullModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mdFullModal" tabindex="-1" aria-labelledby="mdFullModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-md-down">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mdFullModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="lgFullModal" tabindex="-1" aria-labelledby="lgFullModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-lg-down">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lgFullModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="xlFullModal" tabindex="-1" aria-labelledby="xlFullModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-xl-down">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="xlFullModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="xxlFullModal" tabindex="-1" aria-labelledby="xxlFullModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-xxl-down">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="xxlFullModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                ...
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-text" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "modal") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "demo") {
      $(this).text(demoModal)
    }

    if ($(this).data("code") === "static") {
      $(this).text(staticModal)
    }

    if ($(this).data("code") === "scrolling") {
      $(this).text(scrolling)
    }

    if ($(this).data("code") === "vertically") {
      $(this).text(vertically)
    }

    if ($(this).data("code") === "tooltip-popovers") {
      $(this).text(tooltipPopovers)
    }

    if ($(this).data("code") === "grid") {
      $(this).text(grid)
    }

    if ($(this).data("code") === "varying") {
      $(this).text(varying)
    }

    if ($(this).data("code") === "between") {
      $(this).text(between)
    }

    if ($(this).data("code") === "remove") {
      $(this).text(remove)
    }

    if ($(this).data("code") === "sizes") {
      $(this).text(sizes)
    }

    if ($(this).data("code") === "fullscreen") {
      $(this).text(fullscreen)
    }
  }
});

const basicNotification = `
<div class="toast fade show" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
    <div class="toast-header">
        <img class="me-8" src="..." alt="...">
        <strong class="me-auto">Yoda</strong>
        <small>11 mins ago</small>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>

    <div class="toast-body">
        Hello, world! This is a toast message.
    </div>
</div>

`;

const live = `
<button type="button" class="btn btn-primary toast-btn" data-id="liveToast" id="liveToastBtn">Show live toast</button>

<div class="position-fixed bottom-0 end-0 p-16" style="z-index: 99">
    <div data-id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img class="me-8" src="..." alt="...">
            <strong class="me-auto">Yoda</strong>
            <small>11 mins ago</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>

        <div class="toast-body">
            Hello, world! This is a toast message.
        </div>
    </div>
</div>

`;

const translucent = `
<div class="hp-bg-black-100 hp-bg-dark-0 rounded p-32">
    <div class="toast fade show" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img class="me-8" src="..." alt="...">
            <strong class="me-auto">Yoda</strong>
            <small class="text-muted">11 mins ago</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>

        <div class="toast-body">
            Hello, world! This is a toast message.
        </div>
    </div>
</div>

`;

const stacking = `
<button type="button" class="btn btn-primary toast-btn" data-id="stacking-1">Toast 1</button>

<button type="button" class="btn btn-primary toast-btn" data-id="stacking-2">Toast 2</button>

<div class="position-fixed top-0 end-0 p-16" style="z-index: 99">
    <div class="toast-container">
        <div data-id="stacking-1" class="toast fade hide" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <img class="me-8" src="..." alt="...">
                <strong class="me-auto">Yoda</strong>
                <small class="text-muted">just now</small>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>

            <div class="toast-body">
                See? Just like this.
            </div>
        </div>

        <div data-id="stacking-2" class="toast fade hide" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <img class="me-8" src="..." alt="...">
                <strong class="me-auto">Yoda</strong>
                <small class="text-muted">2 seconds ago</small>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>

            <div class="toast-body">
                Heads up, toasts will stack automatically
            </div>
        </div>
    </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "notification") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicNotification)
    }

    if ($(this).data("code") === "live") {
      $(this).text(live)
    }

    if ($(this).data("code") === "translucent") {
      $(this).text(translucent)
    }

    if ($(this).data("code") === "stacking") {
      $(this).text(stacking)
    }
  }
});

const basicPagination = `
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="javascript:;">Previous</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">1</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">2</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">3</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">Next</a></li>
  </ul>
</nav>

`;

const iconsPagination = `
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item">
      <a class="page-link" href="javascript:;" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="javascript:;">1</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">2</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">3</a></li>
    <li class="page-item">
      <a class="page-link" href="javascript:;" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>

`;

const disabledActive = `
<nav aria-label="...">
  <ul class="pagination">
    <li class="page-item disabled">
      <a class="page-link" href="javascript:;" tabindex="-1" aria-disabled="true">Previous</a>
    </li>
    <li class="page-item"><a class="page-link" href="javascript:;">1</a></li>
    <li class="page-item active" aria-current="page">
      <a class="page-link" href="javascript:;">2</a>
    </li>
    <li class="page-item"><a class="page-link" href="javascript:;">3</a></li>
    <li class="page-item">
      <a class="page-link" href="javascript:;">Next</a>
    </li>
  </ul>
</nav>

`;

const sizingPagination = `
<nav aria-label="...">
  <ul class="pagination pagination-lg">
    <li class="page-item active" aria-current="page">
      <span class="page-link">1</span>
    </li>
    <li class="page-item"><a class="page-link" href="javascript:;">2</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">3</a></li>
  </ul>
</nav>

<nav aria-label="...">
  <ul class="pagination pagination-sm">
    <li class="page-item active" aria-current="page">
      <span class="page-link">1</span>
    </li>
    <li class="page-item"><a class="page-link" href="javascript:;">2</a></li>
    <li class="page-item"><a class="page-link" href="javascript:;">3</a></li>
  </ul>
</nav>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "pagination") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "basic") {
            $(this).text(basicPagination)
        }

        if ($(this).data("code") === "icons") {
            $(this).text(iconsPagination)
        }

        if ($(this).data("code") === "disabled-active") {
            $(this).text(disabledActive)
        }

        if ($(this).data("code") === "sizing") {
            $(this).text(sizingPagination)
        }
    }
});

const basicPopover = `
<button type="button" class="btn btn-lg btn-primary" data-bs-toggle="popover" title="Popover title" data-bs-content="And here's some amazing content. It's very engaging. Right?">
  Click to toggle popover
</button>

`;

const directions = `
<button type="button" class="btn btn-primary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Top popover">
    Popover on top
</button>

<button type="button" class="btn btn-primary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="Right popover">
    Popover on right
</button>

<button type="button" class="btn btn-primary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-content="Bottom popover">
    Popover on bottom
</button>

<button type="button" class="btn btn-primary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="left" data-bs-content="Left popover">
    Popover on left
</button>

`;

const dismiss = `
<a tabindex="0" class="btn btn-primary" role="button" data-bs-toggle="popover" data-bs-trigger="focus" title="Dismissible popover" data-bs-content="And here's some amazing content. It's very engaging. Right?">
  Dismissible popover
</a>

`;

const disabledPopover = `
<span class="d-inline-block" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-content="Disabled popover">
  <button class="btn btn-primary" type="button" disabled>Disabled button</button>
</span>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "popover") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicPopover)
    }

    if ($(this).data("code") === "directions") {
      $(this).text(directions)
    }

    if ($(this).data("code") === "dismiss") {
      $(this).text(dismiss)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledPopover)
    }
  }
});

const basicProgress = `
<div class="progress">
    <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
</div>

`;

const labels = `
<div class="progress">
    <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
</div>

`;

const height = `
<div class="progress" style="height: 1px;">
    <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress" style="height: 20px;">
    <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
</div>

`;

const backgrounds = `
<div class="progress">
    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar bg-warning" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
</div>

`;

const multiplebars = `
<div class="progress progress-multiple-bars">
  <div class="progress-bar" role="progressbar" style="width: 15%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
  <div class="progress-bar bg-success" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
  <div class="progress-bar bg-info" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
</div>

`;

const striped = `
<div class="progress">
    <div class="progress-bar progress-bar-striped" role="progressbar" style="width: 10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar progress-bar-striped bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar progress-bar-striped bg-warning" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
</div>

<div class="progress">
    <div class="progress-bar progress-bar-striped bg-danger" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
</div>

`;

const animatedStriped = `
<div class="progress">
  <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
</div>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "progress") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "basic") {
            $(this).text(basicProgress)
        }

        if ($(this).data("code") === "labels") {
            $(this).text(labels)
        }

        if ($(this).data("code") === "height") {
            $(this).text(height)
        }

        if ($(this).data("code") === "backgrounds") {
            $(this).text(backgrounds)
        }

        if ($(this).data("code") === "multiplebars") {
            $(this).text(multiplebars)
        }

        if ($(this).data("code") === "striped") {
            $(this).text(striped)
        }

        if ($(this).data("code") === "animated-striped") {
            $(this).text(animatedStriped)
        }
    }
});

const basicRadio = `
<div class="form-check">
    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
    <label class="form-check-label" for="flexRadioDefault1">
        Default radio
    </label>
</div>

<div class="form-check">
    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
    <label class="form-check-label" for="flexRadioDefault2">
        Default checked radio
    </label>
</div>

`;

const disabledRadio = `
<div class="form-check">
    <input class="form-check-input" type="radio" name="flexRadioDisabled" id="flexRadioDisabled" disabled>
    <label class="form-check-label" for="flexRadioDisabled">
        Disabled radio
    </label>
</div>

<div class="form-check">
    <input class="form-check-input" type="radio" name="flexRadioDisabled" id="flexRadioCheckedDisabled" checked disabled>
    <label class="form-check-label" for="flexRadioCheckedDisabled">
        Disabled checked radio
    </label>
</div>

`;

const toggleButtons = `
<input type="radio" class="btn-check" name="options" id="option1" autocomplete="off" checked>
<label class="btn btn-primary" for="option1">Checked</label>

<input type="radio" class="btn-check" name="options" id="option2" autocomplete="off">
<label class="btn btn-primary" for="option2">Radio</label>

<input type="radio" class="btn-check" name="options" id="option3" autocomplete="off" disabled>
<label class="btn btn-primary" for="option3">Disabled</label>

<input type="radio" class="btn-check" name="options" id="option4" autocomplete="off">
<label class="btn btn-primary" for="option4">Radio</label>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "radio") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "basic") {
            $(this).text(basicRadio)
        }

        if ($(this).data("code") === "disabled") {
            $(this).text(disabledRadio)
        }

        if ($(this).data("code") === "toggle-buttons") {
            $(this).text(toggleButtons)
        }
    }
});

const basicSelect = `
<select class="form-select" aria-label="Default select example">
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>

`;

const sizingSelect = `
<select class="form-select form-select-lg mb-16" aria-label=".form-select-lg example">
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>

<select class="form-select form-select-sm" aria-label=".form-select-sm example">
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>

<select class="form-select" multiple aria-label="multiple select example">
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>

<select class="form-select" size="3" aria-label="size 3 select example">
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>

`;

const disabledSelect = `
<select class="form-select" aria-label="Disabled select example" disabled>
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "select") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicSelect)
    }

    if ($(this).data("code") === "sizing") {
      $(this).text(sizingSelect)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledSelect)
    }
  }
});

const basicSlider = `
<input type="range" class="form-range">

`;

const disabledSlider = `
<input type="range" class="form-range" disabled>

`;

const minAndMax = `
<input type="range" class="form-range" min="0" max="5">

`;

const step = `
<input type="range" class="form-range" min="0" max="5" step="0.5">

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "slider") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicSlider)
    }

    if ($(this).data("code") === "disabled") {
      $(this).text(disabledSlider)
    }

    if ($(this).data("code") === "min-and-max") {
      $(this).text(minAndMax)
    }

    if ($(this).data("code") === "step") {
      $(this).text(step)
    }
  }
});

const borderSpinner = `
<div class="spinner-border" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

`;

const colors = `
<div class="spinner-border text-primary" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-secondary" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-success" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-danger" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-warning" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-info" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-light" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border text-dark" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

`;

const growingSpinner = `
<div class="spinner-grow text-primary" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-secondary" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-success" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-danger" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-warning" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-info" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-light" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow text-dark" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

`;

const flex = `
<div class="d-flex justify-content-center">
    <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<div class="d-flex align-items-center">
    <strong>Loading...</strong>
    <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
</div>

`;

const float = `
<div class="clearfix">
    <div class="spinner-border float-end" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

`;

const textAlign = `
<div class="text-center">
    <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

`;

const size = `
<div class="spinner-border spinner-border-sm" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow spinner-grow-sm" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

<div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
    <span class="visually-hidden">Loading...</span>
</div>

`;

const buttonSpinner = `
<button class="btn btn-primary" type="button" disabled>
    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
    <span class="visually-hidden">Loading...</span>
</button>

<button class="btn btn-primary" type="button" disabled>
    <span class="spinner-border spinner-border-sm me-8" role="status" aria-hidden="true"></span>
    Loading...
</button>

<button class="btn btn-primary" type="button" disabled>
    <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
    <span class="visually-hidden">Loading...</span>
</button>

<button class="btn btn-primary" type="button" disabled>
    <span class="spinner-grow spinner-grow-sm me-8" role="status" aria-hidden="true"></span>
    Loading...
</button>

`;

//--

$("pre code").each(function () {
    if ($(this).data("component") === "spinner") {
        $(this).text($.trim($(this).data("code")))

        if ($(this).data("code") === "border-spinner") {
            $(this).text(borderSpinner)
        }

        if ($(this).data("code") === "colors") {
            $(this).text(colors)
        }

        if ($(this).data("code") === "growing-spinner") {
            $(this).text(growingSpinner)
        }

        if ($(this).data("code") === "flex") {
            $(this).text(flex)
        }

        if ($(this).data("code") === "float") {
            $(this).text(float)
        }

        if ($(this).data("code") === "text-align") {
            $(this).text(textAlign)
        }

        if ($(this).data("code") === "size") {
            $(this).text(size)
        }
        
        if ($(this).data("code") === "button-spinner") {
            $(this).text(buttonSpinner)
        }
    }
});

const basicSwitch = `
<div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault">
  <label class="form-check-label" for="flexSwitchCheckDefault">
    <span class="ms-12">Default switch checkbox input</span>
  </label>
</div>

<div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" checked>
  <label class="form-check-label" for="flexSwitchCheckChecked">
    <span class="ms-12">Checked switch checkbox input</span>
  </label>
</div>

<div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" id="flexSwitchCheckDisabled" disabled>
  <label class="form-check-label" for="flexSwitchCheckDisabled">
    <span class="ms-12">Disabled switch checkbox input</span>
  </label>
</div>

<div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" id="flexSwitchCheckCheckedDisabled" checked disabled>
  <label class="form-check-label" for="flexSwitchCheckCheckedDisabled">
    <span class="ms-12">Disabled checked switch checkbox input</span>
  </label>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "switch") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicSwitch)
    }
  }
});

const overview = `
<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col">Handle</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>Mark</td>
      <td>Otto</td>
      <td>@mdo</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>Jacob</td>
      <td>Thornton</td>
      <td>@fat</td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td colspan="2">Larry the Bird</td>
      <td>@twitter</td>
    </tr>
  </tbody>
</table>

`;

const variants = `
<!-- On tables -->
<table class="table-primary">...</table>
<table class="table-secondary">...</table>
<table class="table-success">...</table>
<table class="table-danger">...</table>
<table class="table-warning">...</table>
<table class="table-info">...</table>
<table class="table-light">...</table>
<table class="table-dark">...</table>

<!-- On rows -->
<tr class="table-primary">...</tr>
<tr class="table-secondary">...</tr>
<tr class="table-success">...</tr>
<tr class="table-danger">...</tr>
<tr class="table-warning">...</tr>
<tr class="table-info">...</tr>
<tr class="table-light">...</tr>
<tr class="table-dark">...</tr>

<!-- On cells ('td' or 'th') -->
<tr>
  <td class="table-primary">...</td>
  <td class="table-secondary">...</td>
  <td class="table-success">...</td>
  <td class="table-danger">...</td>
  <td class="table-warning">...</td>
  <td class="table-info">...</td>
  <td class="table-light">...</td>
  <td class="table-dark">...</td>
</tr>

<table class="table table-dark">
  <thead>
      ...
  </thead>
  <tbody>
      ...
  </tbody>
</table>

`;

const stripedRows = `
<table class="table table-striped">
  ...
</table>

`;

const hoverableRows = `
<table class="table table-hover">
  ...
</table>

`;

const activeTables = `
<table class="table">
  <thead>
    ...
  </thead>
  <tbody>
    <tr class="table-active">
      ...
    </tr>
    <tr>
      ...
    </tr>
    <tr>
      <th scope="row">3</th>
      <td colspan="2" class="table-active">Larry the Bird</td>
      <td>@twitter</td>
    </tr>
  </tbody>
</table>

`;

const bordered = `
<table class="table table-bordered">
  ...
</table>

<table class="table table-bordered border-primary">
  ...
</table>

`;

const borderless = `
<table class="table table-borderless">
  ...
</table>

`;

const smallTables = `
<table class="table table-sm">
  ...
</table>

`;

const nesting = `
<table class="table table-striped">
  <thead>
    ...
  </thead>
  <tbody>
    ...
    <tr>
      <td colspan="4">
        <table class="table mb-0">
          ...
        </table>
      </td>
    </tr>
    ...
  </tbody>
</table>

`;

const foot = `
<table class="table">
  <thead>
    ...
  </thead>
  <tbody>
    ...
  </tbody>
  <tfoot>
    ...
  </tfoot>
</table>

`;

const captionsTable = `
<table class="table table-sm">
  <caption>List of users</caption>
  <thead>
    ...
  </thead>
  <tbody>
    ...
  </tbody>
</table>

<table class="table caption-top">
  <caption>List of users</caption>
  <thead>
    ...
  </thead>
  <tbody>
    ...
  </tbody>
</table>

`;

const responsiveTable = `
<div class="table-responsive">
  <table class="table">
    ...
  </table>
</div>

`;

const breakpoint = `
<div class="table-responsive">
  <table class="table">
    ...
  </table>
</div>

<div class="table-responsive-sm">
  <table class="table">
    ...
  </table>
</div>

<div class="table-responsive-md">
  <table class="table">
    ...
  </table>
</div>

<div class="table-responsive-lg">
  <table class="table">
    ...
  </table>
</div>

<div class="table-responsive-xl">
  <table class="table">
    ...
  </table>
</div>

<div class="table-responsive-xxl">
  <table class="table">
    ...
  </table>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "table") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "overview") {
      $(this).text(overview)
    }

    if ($(this).data("code") === "variants") {
      $(this).text(variants)
    }

    if ($(this).data("code") === "striped-rows") {
      $(this).text(stripedRows)
    }

    if ($(this).data("code") === "active-tables") {
      $(this).text(activeTables)
    }

    if ($(this).data("code") === "bordered") {
      $(this).text(bordered)
    }

    if ($(this).data("code") === "borderless") {
      $(this).text(borderless)
    }

    if ($(this).data("code") === "small-tables") {
      $(this).text(smallTables)
    }

    if ($(this).data("code") === "nesting") {
      $(this).text(nesting)
    }

    if ($(this).data("code") === "foot") {
      $(this).text(foot)
    }

    if ($(this).data("code") === "captions") {
      $(this).text(captionsTable)
    }

    if ($(this).data("code") === "responsive") {
      $(this).text(responsiveTable)
    }

    if ($(this).data("code") === "breakpoint") {
      $(this).text(breakpoint)
    }
  }
});

const basicTabs = `
<ul class="nav nav-tabs mb-12" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Home</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Profile</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">Contact</button>
  </li>
</ul>

<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
    <p class="hp-p1-body mb-0">
      Content of Tab Pane 1
    </p>
  </div>
  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
    <p class="hp-p1-body mb-0">
      Content of Tab Pane 2
    </p>
  </div>
  <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
    <p class="hp-p1-body mb-0">
      Content of Tab Pane 3
    </p>
  </div>
</div>

//-

<ul class="nav nav-pills mb-12" id="pills-tab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Home</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">Profile</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">Contact</button>
  </li>
</ul>

<div class="tab-content" id="pills-tabContent">
  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
    <p class="hp-p1-body mb-0">
      Content of Tab Pane 1
    </p>
  </div>
  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
    <p class="hp-p1-body mb-0">
      Content of Tab Pane 2
    </p>
  </div>
  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
    <p class="hp-p1-body mb-0">
      Content of Tab Pane 3
    </p>
  </div>
</div>

`;

const vertical = `
<div class="d-flex align-items-start">
  <div class="nav flex-column nav-pills me-16" id="v-pills-tab" role="tablist" aria-orientation="vertical">
      <button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">Home</button>
      <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">Profile</button>
      <button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">Messages</button>
      <button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">Settings</button>
  </div>

  <div class="tab-content" id="v-pills-tabContent">
    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
      <p class="hp-p1-body mb-0">
        Content of Tab Pane 1
      </p>
    </div>
    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
      <p class="hp-p1-body mb-0">
        Content of Tab Pane 2
      </p>
    </div>
    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
      <p class="hp-p1-body mb-0">
        Content of Tab Pane 3
      </p>
    </div>
    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
      <p class="hp-p1-body mb-0">
        Content of Tab Pane 4
      </p>
    </div>
  </div>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "tabs") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicTabs)
    }

    if ($(this).data("code") === "vertical") {
      $(this).text(vertical)
    }
  }
});

const basicTooltip = `
<button type="button" class="btn btn-primary" data-bs-toggle="tooltip" title="Tooltip on top">
  Tooltip
</button>

<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-html="true" title="<em>Tooltip</em> <u>with</u> <b>HTML</b>">
  Tooltip with HTML
</button>

`;

const direction = `
<button type="button" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-placement="top" title="Tooltip on top">
  Tooltip on top
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-placement="right" title="Tooltip on right">
  Tooltip on right
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
  Tooltip on bottom
</button>

<button type="button" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-placement="left" title="Tooltip on left">
  Tooltip on left
</button>

`;

const svg = `
<div class="d-inline-block" data-bs-toggle="tooltip" data-bs-placement="top" title="Yoda">
  <img src="..." alt="...">
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "tooltip") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "basic") {
      $(this).text(basicTooltip)
    }

    if ($(this).data("code") === "direction") {
      $(this).text(direction)
    }

    if ($(this).data("code") === "svg") {
      $(this).text(svg)
    }
  }
});

// Show Code Btn
$(".show-code-btn").click(function () {
    $(this).parent().nextAll(".hljs-container").fadeToggle(300)
})
