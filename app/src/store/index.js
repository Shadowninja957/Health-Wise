import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import auth from './auth'

// axios.defaults.withCredentials = true
axios.defaults.baseURL = process.env.VUE_APP_API_URI


Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        auth,         
    }
})