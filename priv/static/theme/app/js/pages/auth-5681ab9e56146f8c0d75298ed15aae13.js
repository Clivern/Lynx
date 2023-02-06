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
