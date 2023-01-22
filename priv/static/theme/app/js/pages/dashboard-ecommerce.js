// Dashboard Ecommerce Products Slide
setTimeout(() => {
    new Swiper('.best-selling-product-slide .swiper', {
        slidesPerView: 1,
        spaceBetween: 32,
        speed: 800,
        navigation: {
            nextEl: '.best-selling-product-slide .slide-btn-next',
            prevEl: '.best-selling-product-slide .slide-btn-prev',
        },
        breakpoints: {
            992: {
                slidesPerView: 3,
            },
            768: {
                slidesPerView: 2,
            },
        }
    });
}, 500);
