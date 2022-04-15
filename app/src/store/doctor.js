import axios from 'axios'

export default{
    namespaced: true,

    state: {
        selectedDoctor: null,
        doctorProfile: {},
    },

    getters: {
        getSelectedDoctor (state) {
            return state.selectedDoctor
        },

        getDoctorProfile (state) {
            return state.doctorProfile
        }
    },

    mutations: {
        setSelectedDoctor (state, value) {
            state.selectedDoctor = value
        },

        setDoctorProfile (state, value) {
            state.doctorProfile = value
        }
    },

    actions: {
        getDoctors () {
            const url = '/doctor/readDoctors';
            return axios.get(url);
        },        
        
        postUpdate ({ getters }) {
            const url = '/doctor/update';
            return axios.post(url, getters.getDoctorProfile);
        }
    }
}