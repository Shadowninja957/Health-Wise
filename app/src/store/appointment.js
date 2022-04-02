import axios from 'axios'

export default{
    namespaced: true,

    state: {
        appointmentDetails: null,
    },

    getters: {
        getAppointmentDetails (state) {
            return state.appointmentDetails
        }
    },

    mutations: {
       setAppointmentDetails (state, value) {
           state.appointmentDetails = value
       }
    },

    actions: {
        getAppointments ({ rootGetters })
        {
            const url = '/appointment/read';
            return axios.post(url, {
                patient_id: rootGetters['auth/getPatientId'],
                doctor_id: rootGetters['auth/getDoctorId'], 
            });
        },
        
        setAppointment ({ getters })
        {
            const url = '/appointment/create';
            console.log(getters.getAppointmentDetails);
            return axios.post(url, getters.getAppointmentDetails);
        },

        updateAppointment({ getters })
        {
            const url = '/appointment/update';
            return axios.post(url, getters.getAppointmentDetails);
        },

        cancelAppointment({ getters })
        {
            const url = '/appointment/cancel';
            console.log(getters.getAppointmentDetails);
            return axios.post(url, getters.getAppointmentDetails);
        }
    }
}