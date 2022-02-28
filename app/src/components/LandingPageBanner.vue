<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
        <v-img
          :src="require('../assets/landing-page-illustration.svg')"
          class="my-3"
          contain
          height="400"
        />
      </v-col>

      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">
          Virtual healthcare for you
        </h1>

        <p class="subheading font-weight-light">
          Health Wise provides progressive, and general 
          healthcare, accessible on mobile and online 
          for everyone
        </p>

        
      </v-col>

      
      
    </v-row>
    <v-row class="text-center">
      <v-col>
        <v-btn
          color="primary"
          @click="login"
        >Consult Today</v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'HelloWorld',

    data: () => ({
      //
    }),

    methods: {
      login ()
      {
        this.$router.replace('/login')
      }
    }
  }
</script>
