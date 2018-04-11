<template>
</template>

<script>
  export default {
    created() {
      VueBus.$on('envelope', ({ message, status }) => {
        $.toast({
          heading: _.ucfirst(status),
          text: message,
          position: 'top-right',
          loaderBg: '#ff6849',
          icon: status,
          hideAfter: 5000,
          stack: 3,
          afterHidden() {
            window.location = location.toString()
          },
        })
      })
    },

    mounted() {
      $('.preloader').fadeOut()

      require('../helpers/theme')
      require('../helpers/fab')
    }
  }
</script>
