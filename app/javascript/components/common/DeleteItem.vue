<template>
    <a href="#" @click.prevent="process()" class="text-danger">
        <font-awesome-icon :icon="icon"/>
    </a>
</template>

<script>
  import FontAwesomeIcon from '@fortawesome/vue-fontawesome'
  import faTrashAlt from '@fortawesome/fontawesome-free-regular/faTrashAlt'

  export default {
    props: {
      url: {
        type: String,
        required: true
      }
    },

    components: {
      FontAwesomeIcon
    },

    computed: {
      icon() {
        return faTrashAlt
      }
    },

    methods: {
      process() {

        swal({
          title: "Are you sure?",
          text: "Once deleted, you will not be able to recover!",
          buttons: true,
          dangerMode: true,
        })
          .then(willDelete => {
            if (willDelete) {
              this.$http.delete(this.url)
                .then(({ data }) => VueBus.$emit('envelope', data))
                .catch(e => VueBus.$emit('envelope', e.response.data))
            }
          })
      }
    }
  }
</script>
