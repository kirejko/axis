const { environment } = require('@rails/webpacker')
const { ProvidePlugin } = require('webpack')
const path = require('path')
const vue = require('./loaders/vue')

// Loaders
environment.loaders.append('vue', vue)

// Config
environment.config.merge({
  resolve: {
    alias: {
      vue: 'vue/dist/vue.esm.js',
      utils: path.resolve(__dirname, 'app/javascript/utils')
    }
  },
})

// Plugins
environment.plugins.prepend(
  new ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Vue: ['vue/dist/vue.esm.js', 'default'],
    _: 'lodash',
    moment: 'moment',
    VueBus: 'utils/vbus',
    swal: 'sweetalert'
  })
)

module.exports = environment
