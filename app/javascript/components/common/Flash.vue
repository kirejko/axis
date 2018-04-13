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

    data() {
      return {
        statusMap: {
          notice: 'info',
          alert: 'warning'
        }
      }
    },

    computed: {
      mappedStatus() {
        return this.statusMap.hasOwnProperty(this.status)
          ? this.statusMap[this.status]
          : this.status
      }
    },

    created() {
      $.toast({
        heading: _.upperFirst(this.mappedStatus),
        text: this.message,
        position: 'top-right',
        loaderBg: '#ff6849',
        icon: this.mappedStatus,
        hideAfter: 5000,
        stack: 3,
        afterHidden: () => this.$destroy(),
      })
    }
  }
</script>
