/* Small script to force dark theme on page load.
   This sets the data-theme attribute and localStorage so
   PreTeXt / Runestone theme switchers respect dark mode.
   It runs immediately to avoid a flash of light theme. */
(function(){
  try {
    // Force the attribute used by PreTeXt/Runestone
    document.documentElement.setAttribute('data-theme','dark');
    // Remove any light-mode class and add dark-mode
    document.documentElement.classList.remove('light-mode');
    document.documentElement.classList.add('dark-mode');
    // Persist preference for embedded scripts that read localStorage
    try { localStorage.setItem('theme','dark'); } catch(_) {}
  } catch (e) {
    // silent
  }
})();
