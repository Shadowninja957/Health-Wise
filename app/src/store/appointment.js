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
            console.log(`UserId: ${rootGetters['auth/getUserId']}`)
            return axios.post(url, {
                patient_id: rootGetters['auth/getUserId'] 
            });
        },
        
        setAppointment ({ getters })
        {
            const url = '/appointment/create';
            console.log(getters.getAppointmentDetails);
            return axios.post(url, getters.getAppointmentDetails);
        }
    }
}