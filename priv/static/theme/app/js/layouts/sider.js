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
