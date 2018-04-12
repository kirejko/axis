<template>
    <span></span>
</template>

<script>
  export default {
    props: {
      status: {
        type: String,
        default: 'info'
      },
      message: {
        type: String,
        required: true
      }
    },

    created() {
      $.toast({
        heading: _.upperFirst(this.status),
        text: this.message,
        position: 'top-right',
        loaderBg: '#ff6849',
        icon: this.status,
        hideAfter: 5000,
        stack: 3,
        afterHidden: () => this.$destroy(),
      })
    }
  }
</script>