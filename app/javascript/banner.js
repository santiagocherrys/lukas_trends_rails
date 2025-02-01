document.addEventListener("DOMContentLoaded", function () {
  function refreshBanner() {
    fetch('/banner')
      .then(response => response.text())
      .then(html => {
        let bannerContainer = document.querySelector(".ad-banner");
        if (bannerContainer) {
          bannerContainer.innerHTML = html;
        }
      });
  }

  setInterval(refreshBanner, 5 * 60 * 1000); // Cambia cada 5 minutos
});
