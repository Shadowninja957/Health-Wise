<template>
  <v-container>
    <v-row>

      <v-col cols="4" class="mb-4 d-flex flex-column justify-center align-left">
        <h1 class="display-1 font-weight-bold mb-5">
          Virtual healthcare for you
        </h1>

        <p class="subheading font-weight-light">
          Health Wise provides progressive, and general 
          healthcare, accessible on mobile and online 
          for everyone
        </p>

        <v-btn
          color="primary"
          @click="login"
          width="150"
        >
          Consult Today
        </v-btn>

       
      </v-col>

      <v-col cols="8">
        <v-img
          :src="require('../assets/landing-page-illustration.svg')"
          class="my-3"
          contain
          height="500"
        />
      </v-col>
    </v-row>

    <v-row class="text-center">
      <v-col cols="12">
        <v-fab-transition>
          <v-btn
            fab
            class="mb-4"
            color="primary"
            small
            dark
            bottom
            center
          >
            <v-icon>mdi-chevron-down</v-icon>
          </v-btn>
        </v-fab-transition>
        <h3 class="font-weight-bold">
          Our Services
        </h3>
      </v-col>

      <v-col cols="12">
        <p class="font-weight-light">
          We provide to you the best choices for you. 
          Adjust it to your health needs and make sure you 
          undergo treatment with our highly qualified doctors 
          you can consult with us which type of service is 
          suitable for your health
        </p>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="4">
        <v-card width="300" height="275" rounded class="pt-4 px-5 pb-5 rounded-xl">
          <v-img
            :src="require('../assets/search.png')"
            class="ma-4 pt-5"
            position="center left"
            contain
            height="60"
          />
          <v-card-title>Search doctor</v-card-title>
          <v-card-text class="font-weight-light">
            Choose your doctor 
            from thousands of specialist, 
            general, and trusted hospitals
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="4">
        <v-card width="300" height="275" rounded class="pt-4 px-5 pb-5 rounded-xl">
          <v-img
            :src="require('../assets/feedback.png')"
            class="ma-4 pt-5"
            position="center left"
            contain
            height="60"
          />
          <v-card-title>Patient Feedback</v-card-title>
          <v-card-text class="font-weight-light">
            Provide feedback to your doctor 
            about the medical procedures 
            you were prescribed 
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="4">
        <v-card width="300" height="275" rounded class="pt-4 px-5 pb-5 rounded-xl">
          <v-img
            :src="require('../assets/consultation.png')"
            class="ma-4 pt-5"
            position="center left"
            contain
            height="60"
          />
          <v-card-title>Consultation</v-card-title>
          <v-card-text class="font-weight-light">
            Free consultation with our trusted 
            doctors and get the best recomendations
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <v-row class="section-2">
      <v-col cols="4">
        <v-card width="300" height="275" rounded class="pt-4 px-5 pb-5 rounded-xl">
          <v-img
            :src="require('../assets/diagnose.png')"
            class="ma-4 pt-5"
            position="center left"
            contain
            height="60"
          />
          <v-card-title>Diagnose Yourself</v-card-title>
          <v-card-text class="font-weight-light">
            Enter symptoms you are experiencing 
            and be self diagnosed by our system.
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="4">
        <v-card width="300" height="275" rounded class="pt-4 px-5 pb-5 rounded-xl">
          <v-img
            :src="require('../assets/appointment.png')"
            class="ma-4 pt-5"
            position="center left"
            contain
            height="60"
          />
          <v-card-title>Make Appointments</v-card-title>
          <v-card-text class="font-weight-light">
            You can schedule 
            appointments with one of our 
            highly qualified doctors.
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="4">
        <v-card width="300" height="275" rounded class="pt-4 px-5 pb-5 rounded-xl">
          <v-img
            :src="require('../assets/tracking.png')"
            class="ma-4 pt-5"
            position="center left"
            contain
            height="60"
          />
          <v-card-title>Tracking</v-card-title>
          <v-card-text class="font-weight-light">
            Track and save your medical history and health data 
          </v-card-text>
        </v-card>
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

<style scoped>
  
</style>
