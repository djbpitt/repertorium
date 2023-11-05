/* 
 * classList toggling for svg elements is slow and fragile
 *   so modify display properties explicitly instead
 */
function plectogram_mouseover() {
  let currentClass = this.classList.baseVal;
  let hits = document.querySelectorAll("." + currentClass);
  for (var i = 0, len = hits.length; i < len; i++) {
    hits[i].style.fill = "fucshia";
    hits[i].style.stroke = "fucshia";
    hits[i].style.strokeWidth = "1.5";
  }
}
function plectogram_mouseout() {
  let currentClass = this.classList.baseVal;
  let hits = document.querySelectorAll("." + currentClass);
  for (var i = 0, len = hits.length; i < len; i++) {
    hits[i].style.fill = "yellow";
    hits[i].style.stroke = "black";
    hits[i].style.strokeWidth = "0.5";
  }
}
function scale_plectogram() {
  var svg = document.getElementById('plectogram_svg');
  svg.setAttribute('width', (readCookie('initialSvgWidth') * this.value));
}
function assign_mouseover_listener() {
  let plectogram_cells = document.querySelectorAll('rect');
  for (var i = 0, len = plectogram_cells.length; i < len; i++) {
    plectogram_cells[i].addEventListener('mouseover', plectogram_mouseover, 'false');
    plectogram_cells[i].addEventListener('mouseout', plectogram_mouseout, 'false');
  }
}
document.addEventListener('DOMContentLoaded', (e) => {
  var slider = document.getElementById('slider1');
  slider.addEventListener('input', scale_plectogram, false);
  assign_mouseover_listener();
  var svg = document.getElementById('plectogram_svg');
  createCookie('initialSvgWidth', svg.getAttribute('width'), 30);
});