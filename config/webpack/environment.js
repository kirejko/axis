const { environment } = require('@rails/webpacker')
const { ProvidePlugin } = require('webpack')
const vue = require('./loaders/vue')

// Loaders
environment.loaders.append('vue', vue)

// Config
environment.config.merge({
  resolve: {
    alias: {
      vue: 'vue/dist/vue.esm.js',
    }
  },
})

// Plugins
environment.plugins.prepend(
  'Provide',
  new ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Vue: ['vue/dist/vue.esm.js', 'default'],
    _: 'lodash',
    swal: 'sweetalert',
    moment: 'moment',
    'window.moment': 'moment',
  })
)

module.exports = environment
