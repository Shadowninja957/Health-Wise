import axios from 'axios'

export default{
    namespaced: true,

    state: {
        selectedDoctor: null,
    },

    getters: {
        getSelectedDoctor (state) {
            return state.selectedDoctor
        }
    },

    mutations: {
       setSelectedDoctor (state, value) {
           state.selectedDoctor = value
       }
    },

    actions: {
        getDoctors ()
        {
            const url = '/doctor/read';
            return axios.get(url);
        }       
    }
}