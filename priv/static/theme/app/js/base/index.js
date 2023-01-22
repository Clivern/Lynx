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
