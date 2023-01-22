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
