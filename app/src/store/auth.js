import axios from 'axios'

export default{
    namespaced: true,

    state: {
        authenticated: sessionStorage.getItem('Authenticated') || false,
        // authenticated: false,
        userId: sessionStorage.getItem('UserId') || null,
        userEmail: sessionStorage.getItem('UserEmail') || null,
        patientId: sessionStorage.getItem('PatientId') || null,
        doctorId: sessionStorage.getItem('DoctorId') || null,
        credentials: {},
        user: sessionStorage.getItem('User') || null,
        doctor: sessionStorage.getItem('Doctor') || null,
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

        getUser (state)
        {
            return state.user
        },

        getUserEmail (state)
        {
            return state.userEmail
        },

        getDoctor (state)
        {
            return state.doctor
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

        setUser (state, value)
        {
            state.user = value
        },

        setUserEmail (state, value)
        {
            state.userEmail = value
        },

        setDoctor (state, value)
        {
            state.doctor = value
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
                user_id: getters.getUserId,
                first_name: getters.getCredentials.first_name,
                last_name: getters.getCredentials.last_name 
            })
        },

        getPatient({ getters })
        {
            const url = '/patient/read'
            return axios.post(url, {
                user_id: getters.getUserId,
                
            });
        },

        postDoctor({ getters })
        {
            const url = '/doctor/create'
            console.log(getters.getUserId);
            return axios.post(url, {
                user_id: getters.getUserId,
                first_name: getters.getCredentials.first_name,
                last_name: getters.getCredentials.last_name
            })
        },

        getDoctor({ getters })
        {
            const url = '/doctor/read'
            return axios.post(url, {
                user_id: getters.getUserId,
            })
        }
    }
}