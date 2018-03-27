require('bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker')

$('input.user-birth-datepicker').bootstrapMaterialDatePicker({
  time: false,
  nowButton: false,
  maxDate: window.moment().subtract(18, 'years'),
  format: "ddd, Do MMMM YYYY"
});