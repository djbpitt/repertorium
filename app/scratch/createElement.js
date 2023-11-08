document.addEventListener("DOMContentLoaded", init);
function init() {
  var trigger = document.getElementsByTagName("p")[0];
  trigger.addEventListener("click", show, false);
}

function show() {
  var d = document.createElement("div");
  d.textContent = "This is an inserted element."
  d.style.setProperty("background-color", "lightgreen");
  document.body.appendChild(d);
}