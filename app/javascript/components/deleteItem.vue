<template>
    <a href="#" @click.prevent="process()" class="text-danger">
        <i class="far fa-trash-alt"></i>
    </a>
</template>

<script>
  import http from '../utils/http'
  import vbus from '../utils/vbus'

  import swal from 'sweetalert'

  export default {
    name: 'delete-item',

    props: {
      url: String
    },

    methods: {
      process() {

        swal({
          title: "Are you sure?",
          text: "Once deleted, you will not be able to recover!",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
          if (willDelete) {

            http.delete(this.url)
            .then(response => {
              vbus.$emit('envelope', response.data)

              Turbolinks.visit(location.toString())
            })
            .catch(e => {
              vbus.$emit('envelope', e.response.data)
              setTimeout(function() {
                Turbolinks.visit(location.toString())
              }, 3000)
            })

          }
        })

      }
    }

  }
</script>

<style scoped>

</style>