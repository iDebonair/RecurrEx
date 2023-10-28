let slideIndex = 1; // Initialize the slide index

// Function to show the next or previous slide
function plusSlides(n) {
  showSlide(slideIndex += n);
}

// Function to show a specific slide
function currentSlide(n) {
  showSlide(slideIndex = n);
}

// Function to display a specific slide
function showSlide(n) {
  let slides = document.getElementsByClassName("slide-card");
  if (n > slides.length) {
    slideIndex = 1;
  }
  if (n < 1) {
    slideIndex = slides.length;
  }
  for (let i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slides[slideIndex - 1].style.display = "block";
}

// Automatically advance to the next slide 
function autoAdvance() {
  plusSlides(1);
}

// Set a timer to auto-advance the slides
setInterval(autoAdvance, 5000); 