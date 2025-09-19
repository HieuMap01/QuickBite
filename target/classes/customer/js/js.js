document.getElementById('searchBtn').addEventListener('click', function () {
  const keyword = document.getElementById('searchInput').value.trim();
  if (keyword) {
    alert("Bạn vừa tìm: " + keyword);
  }
});

window.onscroll = function () {
  const btn = document.getElementById("scrollToTopBtn");
  if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
    btn.style.display = "block";
  } else {
      btn.style.display = "none";
  }
  };
  
document.getElementById("scrollToTopBtn").onclick = function () {
  window.scrollTo({
    top: 0,
    behavior: "smooth"
  });
};

