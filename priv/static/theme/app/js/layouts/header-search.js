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
