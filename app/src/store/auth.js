import axios from 'axios'

export default{
    namespaced: true,

    state: {
        authenticated: sessionStorage.getItem('Authenticated') || false,
        // authenticated: false,
        userId: sessionStorage.getItem('UserId') || null,
        credentials: {},
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
        }
    }
}