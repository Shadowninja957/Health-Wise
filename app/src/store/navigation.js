export default{
    namespaced: true,

    state: {
        tab: null,
    },

    getters: {
       getTab (state) {
           return state.tab;
       }
    },

    mutations: {
      setTab (state, value) {
          state.tab = value
      }
    },

    actions: {
        //
    }
}