import axios from 'axios'

export default{
    namespaced: true,

    state: {
        authenticated: sessionStorage.getItem('Authenticated') || false,
        // authenticated: false,
        userId: sessionStorage.getItem('UserId') || null,
        patientId: sessionStorage.getItem('PatientId') || null,
        doctorId: sessionStorage.getItem('DoctorId') || null,
        credentials: {},
        patient: sessionStorage.getItem('Patient') || null,
    },

    getters: {
        getAuthenticated (state)
        {
            return state.authenticated
        },

        getCredentials (state)
        {
            return state.credentials
        },

        getUserId (state)
        {
            return state.userId
        },

        getPatientId (state)
        {
            return state.patientId
        },

        getDoctorId (state)
        {
            return state.doctorId
        },

        getPatient (state)
        {
            return state.patient
        }
    },

    mutations: {
        setAuthenticated (state, value)
        {
            state.authenticated = value
        },

        setCredentials (state, value)
        {
            state.credentials = value
        },

        setUserId (state, value)
        {
            state.userId = value
        },

        setPatientId (state, value)
        {
            state.patientId = value
        },

        setDoctorId (state, value)
        {
            state.doctorId = value
        },

        setPatient (state, value)
        {
            state.patient = value
        }
    },

    actions: {
        signUp({ getters })
        {
            const url = '/login/create';
            return axios.post(url, getters.getCredentials);
        },

        logIn({ getters })
        {
            const url = '/login/authenticate'
            return axios.post(url, getters.getCredentials);
        },

        postPatient({ getters })
        {
            const url = '/patient/create'
            return axios.post(url, {
                user_id: getters.getUserId
            })
        },

        getPatient({ getters })
        {
            const url = '/patient/read'
            return axios.post(url, {
                user_id: getters.getUserId 
            });
        }
    }
}