import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import auth from './auth'
import doctor from './doctor'
import appointment from './appointment'
import feedback from './feedback'

// axios.defaults.withCredentials = true
axios.defaults.baseURL = process.env.VUE_APP_API_URI


Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        auth,
        doctor,
        appointment,
        feedback,         
    }
})