// Hero Section Carousel (Auto slide enabled)
var heroSwiper = new Swiper(".hero-carousel", {
  loop: true, // Enable looping for continuous sliding
  autoplay: {
    delay: 5000, // 5-second auto slide
    disableOnInteraction: false, // Keep autoplay even if user interacts
  },
  navigation: {
    nextEl: ".hero-next", // Next button
    prevEl: ".hero-prev", // Previous button
  },
  pagination: {
    el: ".swiper-pagination", // Pagination dots
    clickable: true, // Clickable dots for manual navigation
  },
  effect: 'fade', // Elegant fade effect for slides
  fadeEffect: {
    crossFade: true, // Ensure smooth cross fade between slides
  },
  speed: 1000, // Smooth transition speed
  on: {
    init: function () {
      console.log("Hero swiper initialized");
    }
  }
});

// Log message to confirm the script is loaded
console.log("Homepage JS loaded");

// Coming Soon Section Carousel
var comingSoonSwiper = new Swiper(".coming-soon-carousel", {
  loop: true, // Enable looping
  slidesPerView: 4, // Show 4 slides at a time
  spaceBetween: 20, // 20px space between slides
  autoplay: {
    delay: 4000, // 4-second auto slide
    disableOnInteraction: false,
  },
  navigation: {
    nextEl: ".coming-soon-next", // Next button
    prevEl: ".coming-soon-prev", // Previous button
  },
  pagination: {
    el: ".swiper-pagination", // Pagination
    clickable: true,
  },
  breakpoints: {
    1024: {
      slidesPerView: 3, // Show 3 slides on tablets
    },
    768: {
      slidesPerView: 2, // Show 2 slides on smaller screens
    },
    480: {
      slidesPerView: 1, // Show 1 slide on mobile
    },
  },
  speed: 1000,
});

// Log message to confirm the comingSoonSwiper is initialized
console.log("Coming Soon swiper initialized");

// Deals Section Carousel
var dealsSwiper = new Swiper(".deals-container", {
  loop: true, // Enable looping
  slidesPerView: 3, // Show 3 deal cards at a time
  spaceBetween: 30, // 30px space between cards
  autoplay: {
    delay: 5000, // 5-second auto slide
    disableOnInteraction: false,
  },
  navigation: {
    nextEl: ".deals-next", // Next button
    prevEl: ".deals-prev", // Previous button
  },
  pagination: {
    el: ".swiper-pagination", // Pagination dots
    clickable: true,
  },
  breakpoints: {
    1024: {
      slidesPerView: 2, // Show 2 deal cards on tablets
    },
    768: {
      slidesPerView: 1, // Show 1 deal card on smaller screens
    },
  },
  speed: 1000,
});

// Log message to confirm the dealsSwiper is initialized
console.log("Deals swiper initialized");
