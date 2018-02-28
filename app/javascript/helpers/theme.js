require('dropify')

$('.dropify').dropify();

$(function () {
  $('[data-toggle="tooltip"]').tooltip({
    container: 'body'
  });
});

$(function () {
  $('[data-toggle="popover"]').popover();
});