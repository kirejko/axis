// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '../boot'

new Vue({
  el: '#app',
  created() {
    VueBus.$on('envelope', ({ message, status }) => {
      $.toast({
        heading: _.upperFirst(status),
        text: message,
        position: 'top-right',
        loaderBg: '#ff6849',
        icon: status,
        hideAfter: 5000,
        stack: 3,
        afterHidden() {
          window.location = location.toString().replace(/#/, '')
        },
      })
    })
  },

  mounted() {
    $('.preloader').fadeOut()

    require('../helpers/theme')
    require('../helpers/fab')
  }
});
