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