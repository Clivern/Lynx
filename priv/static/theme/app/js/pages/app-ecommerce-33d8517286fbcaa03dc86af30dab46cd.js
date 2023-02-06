// Ecommerce Detail Other Slider
setTimeout(() => {
    new Swiper('.hp-ecommerce-app-detail-other-slider .swiper', {
        slidesPerView: 2,
        spaceBetween: 24,
        navigation: {
            nextEl: '.hp-ecommerce-app-detail-other-slider .btn-next',
            prevEl: '.hp-ecommerce-app-detail-other-slider .btn-prev',
        },
        breakpoints: {
            1200: {
                slidesPerView: 6,
            },
            768: {
                slidesPerView: 3,
            },
        }
    });
}, 500);

// Ecommerce Detail Slider
setTimeout(() => {
    let ecommerceAppDetailSlider1 = new Swiper(".hp-ecommerce-app-detail-slider-1", {
        loop: true,
        slidesPerView: 1,
        watchSlidesProgress: true,
    });

    new Swiper(".hp-ecommerce-app-detail-slider-2", {
        slidesPerView: 3,
        loop: true,
        thumbs: {
            swiper: ecommerceAppDetailSlider1,
        },
        breakpoints: {
            768: {
                slidesPerView: 4,
            }
        }
    });
}, 500);
