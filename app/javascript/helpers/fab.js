function initFloatingButton() {
  $('#fab_button').click(function() {
    $('.btn-fab_subitem').toggleClass('scale-out');
  });
}

initFloatingButton();
