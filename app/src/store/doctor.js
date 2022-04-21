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
        },

        getDoctorHours ({ getters }) {
            const url = '/doctor/hours';
            return axios.post(url, {
                id: getters.getSelectedDoctor.id
            })
        },

        getDoctorAppointments({ getters, rootGetters }) {
            const url = '/doctor/appointments';
            // console.log(rootGetters['appointment/getAppointmentDetails'])
            // console.log(getters.getSelectedDoctor);
            return axios.post(url, {
                id: getters.getSelectedDoctor.id,
                date: rootGetters['appointment/getAppointmentDetails'].date
            })
        },

        getDoctorSpecialities () {
            const url = '/speciality/read';
            return axios.get(url);
        }
    }
}