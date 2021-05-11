import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

/**
*引入mintUI的弹窗和Toast
*/
import {Toast,MessageBox} from 'mint-ui'
import 'mint-ui/lib/style.min.css'
/**
 * 引入axios
 */
import axios from 'axios'
axios.defaults.baseURL = "http://localhost:65220/api/";//设置一个BaseUrl http://localhost:65220/api/Login'

Vue.config.productionTip = false;
Vue.prototype.$msg = Toast;
Vue.prototype.$alert = MessageBox;

Vue.prototype.$http = axios;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
