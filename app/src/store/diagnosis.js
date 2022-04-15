import axios from 'axios'

export default{
    namespaced: true,

    state: {
        searchPhrase: null,
    },

    getters: {
       getSearchPhrase (state) {
           return state.searchPhrase
       }
    },

    mutations: {
       setSearchPhrase (state, value) {
           state.searchPhrase = value
       }
    },

    actions: {
        getDiagnosis ({ getters }) {
            const url = '/diagnosis/read';
            return axios.post(url, {
                search_phrase: getters.getSearchPhrase
            });
        },        
    }
}