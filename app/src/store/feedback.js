import axios from 'axios'

export default{
    namespaced: true,

    state: {
        feedback: null,
        feedbackSelected: null,
        feedbackReply: null,
    },

    getters: {
        getFeedback (state) {
            return state.feedback
        },

        getFeedbackSelected (state) {
            return state.feedbackSelected;
        },

        getFeedbackReply (state) {
            return state.feedbackReply
        }
            
    },

    mutations: {
        setFeedback (state, value) {
           state.feedback = value
        },

        setFeedbackSelected (state, value) {
            state.feedbackSelected = value
        },

        setFeedbackReply (state, value) {
            state.feedbackReply = value
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
                patient_id: rootGetters['auth/getPatientId'],
                doctor_id: rootGetters['auth/getDoctorId']
            })
        },
       
        postFeedbackReply ({ getters })
        {
            const url = '/feedbackReplies/create';
            return axios.post(url, getters.getFeedbackReply)
        },

        getFeedbackReplies ({ getters })
        {
            const url = '/feedbackReplies/read';
            return axios.post(url, {
                patient_feedback_id: getters.getFeedbackSelected.id
            })
        }
    }
}