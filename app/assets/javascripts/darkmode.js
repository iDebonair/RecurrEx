document.addEventListener('DOMContentLoaded', function () {
    const darkModeToggle = document.getElementById('dark-mode-toggle');
    const body = document.body;
  
    // Function to enable dark mode
    function enableDarkMode() {
      body.classList.add('dark-mode');
    }
  
    // Function to disable dark mode
    function disableDarkMode() {
      body.classList.remove('dark-mode');
    }
  
    // Function to toggle dark mode
    function toggleDarkMode() {
      if (body.classList.contains('dark-mode')) {
        disableDarkMode();
      } else {
        enableDarkMode();
      }
    }
  
    // Check if dark mode is already enabled (for returning users)
    if (localStorage.getItem('darkMode') === 'enabled') {
      enableDarkMode();
      darkModeToggle.checked = true;
    }
  
    // Event listener for dark mode toggle switch
    darkModeToggle.addEventListener('change', function () {
      if (darkModeToggle.checked) {
        enableDarkMode();
        localStorage.setItem('darkMode', 'enabled');
      } else {
        disableDarkMode();
        localStorage.setItem('darkMode', 'disabled');
      }
    });
  });
  