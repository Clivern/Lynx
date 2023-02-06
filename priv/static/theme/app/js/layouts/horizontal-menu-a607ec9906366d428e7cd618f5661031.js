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
