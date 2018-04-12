import axios from '../utils/http'
import VueBus from '../utils/vbus'

import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios)

window.VueBus = VueBus
