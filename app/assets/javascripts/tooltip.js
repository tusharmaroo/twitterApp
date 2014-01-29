$(document).ready(function() {
  $('.radial-list').radmenu({
  listClass: 'list',
  itemClass: 'item',
  radius: 220,
  animSpeed:800,
  centerX: 250,
  centerY: 250,
  angleOffset: -90
  });
  $('.radial-list').radmenu('show');
  $('.radial_div [data-toggle=tooltip]').tooltip();
  });

