import axios from 'axios'

export default{
    namespaced: true,

    state: {
        feedback: null,
    },

    getters: {
        getFeedback (state) {
            return state.feedback
        }
    },

    mutations: {
       setFeedback (state, value) {
           state.feedback = value
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
        
        postFeedback ({ getters })
        {
            const url = '/feedback/create';
            console.log(getters.getFeedback);
            return axios.post(url, getters.getFeedback);
        },

        getFeedback ({ rootGetters })
        {
            const url = '/feedback/read';
            return axios.post(url, {
                patient_id: rootGetters['auth/getPatientId']
            })
        }
    }
}