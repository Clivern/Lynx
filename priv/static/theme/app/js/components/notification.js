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
