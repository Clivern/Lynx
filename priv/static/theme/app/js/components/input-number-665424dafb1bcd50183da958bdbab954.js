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
