require('dropify')
require('bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker')

$('.dropify').dropify();

$('[data-toggle="tooltip"]').tooltip({
  container: 'body'
});

$('[data-toggle="popover"]').popover();

$('input.user-birth-datepicker').bootstrapMaterialDatePicker({
  time: false,
  nowButton: false,
  maxDate: window.moment().subtract(18, 'years'),
  format: "ddd, Do MMMM YYYY"
});