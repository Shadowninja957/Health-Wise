<template>
  <v-app>
    <v-app-bar
      app
      color="white"      
      flat
    >
      <div class="d-flex align-center">
        Health Wise
      </div>

      <v-spacer></v-spacer>
      <v-btn
        class="mr-2"
        text
        color="primary"
        @click="login"
      >
        Log in
      </v-btn>
      <v-btn
        color="primary"
        @click="signup"
      >
        Sign up
      </v-btn>
      
    </v-app-bar>

    <v-main>
      <landing-page-banner/>
    </v-main>
  </v-app>
</template>

<script>
import LandingPageBanner from './LandingPageBanner.vue';

export default {
  name: 'App',

  components: {
    LandingPageBanner,
  },

  data: () => ({
    //
  }),

  methods: {
    login () 
    {
      this.$router.replace('/login')
    },

    signup ()
    {
      this.$router.replace('/signup')
    }
  }
};
</script>

<style scoped>
  body{
    background: #E5E5E5;
  }
</style>
