import axios from 'axios'

export default{
    namespaced: true,

    state: {
        authenticated: sessionStorage.authenticated || false,
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