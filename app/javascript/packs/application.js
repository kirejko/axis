/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

window.$ = window.jQuery = require('jquery')
window.moment = require('moment')
require('jquery-toast-plugin')
require('bootstrap')

// import faLib from '@fortawesome/fontawesome'
// import brands from '@fortawesome/fontawesome-free-brands'
// import solid from '@fortawesome/fontawesome-free-solid'
// import regular from '@fortawesome/fontawesome-free-regular'
// faLib.library.add(brands, solid, regular)

import Vue from 'vue/dist/vue.esm'
//import TurbolinksAdapter from 'vue-turbolinks';

//Vue.use(TurbolinksAdapter)

import vbus from '../utils/vbus'
import deleteItem from '../components/deleteItem.vue'

import ucfirst from 'locutus/php/strings/ucfirst'

//document.addEventListener('turbolinks:load', () => {
document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',

    components: {
      deleteItem
    },

    mounted() {
      $('.preloader').fadeOut()

      require('../helpers/theme')
      require('../helpers/fab')
    },

    created() {
      vbus.$on('envelope', (envelope) => {
        document.addEventListener('turbolinks:load', () => {

          $.toast({
            heading:   ucfirst(envelope.status),
            text:      envelope.message,
            position:  'top-right',
            loaderBg:  '#ff6849',
            icon:      envelope.status,
            hideAfter: 5000,
            stack:     3,
          })
        })
      })
    }

  });
})