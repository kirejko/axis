import axios from 'axios'
import App from '../components/App'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios)

// Register common components as global
require
  .context('../components/common/', true, '/.vue$/')
  .keys()
  .forEach(fileName => {
    Vue.component(_.kebabCase(fileName), require(fileName))
  })

export default App
