import axios from 'axios'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')

axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

export default axios.create()

// export const http = axios.create({
//   'X-CSRF-TOKEN': token,
//   'X-Requested-With': 'XMLHttpRequest',
//   'Accept': 'application/json'
// })
