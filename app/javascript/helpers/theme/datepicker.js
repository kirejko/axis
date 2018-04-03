require('bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker')

const defaultSettings = {
  time: false,
  nowButton: true,
  format: "ddd, Do MMMM YYYY"
}

const datepickerSettings = {
  'user-birth-datepicker': {
    nowButton: false,
    maxDate: window.moment().subtract(18, 'years')
  },
  'user-trial-datepicker': defaultSettings,
  'user-hired-datepicker': defaultSettings,
  'user-fired-datepicker': defaultSettings,
}

_.each(datepickerSettings, (settings, className) => {
  $(`input.${className}`)
    .bootstrapMaterialDatePicker(
      _.assign({}, defaultSettings, settings)
    )
})
