import axios from 'axios'

export default{
    namespaced: true,

    state: {
        profile: {},
    },

    getters: {
        getProfile (state) {
            return state.profile
        }
    },

    mutations: {            
        setProfile (state, value) {
            state.profile = value
        }
    },

    actions: {
        postProfile ({ getters }) {
            const url = '/patient/update';
            return axios.post(url, getters.getProfile);
        }
    }
}