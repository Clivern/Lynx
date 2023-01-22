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