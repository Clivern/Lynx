$((function(){new Swiper(".hp-landing-features-slide",{slidesPerView:1,spaceBetween:32,centeredSlides:!0,loop:!0,speed:800,autoplay:{delay:5e3,disableOnInteraction:!1},breakpoints:{1200:{slidesPerView:3},768:{slidesPerView:2}}}),$(".hp-landing-pricing .form-switch input").change((function(e){$(this).parent().next("span").toggleClass("text-primary text-black-100 hp-text-color-dark-0"),$(this).parent().prev("span").toggleClass("text-primary text-black-100 hp-text-color-dark-0"),$(".monthly-text").toggleClass("d-none"),$(".annually-text").toggleClass("d-none")}))}));