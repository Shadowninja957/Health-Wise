import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import auth from './auth'
import doctor from './doctor'
import appointment from './appointment'
import feedback from './feedback'
import navigation from './navigation'
import diagnosis from './diagnosis'
import patient from './patient'
import * as VueGoogleMaps from 'vue2-google-maps'

// axios.defaults.withCredentials = true
axios.defaults.baseURL = process.env.VUE_APP_API_URI


Vue.use(Vuex)

Vue.use(VueGoogleMaps, {
    load: {
        key: 'AIzaSyDMtzdlMG4W7piCyvL3DcTAwbqtK271sgo',
        libraries: 'places'
    }
})

export default new Vuex.Store({
    modules: {
        auth,
        doctor,
        appointment,
        feedback,
        navigation, 
        diagnosis,
        patient,        
    }
})