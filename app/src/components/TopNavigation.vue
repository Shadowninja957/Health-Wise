<template>
    <v-app-bar
        app
        color="white"
        flat
    >
        <div class="d-flex align-center font-weight-bold">
            <v-btn 
                text
                href="/home"
            >Health Wise</v-btn>
        </div>

        <v-spacer></v-spacer>
        <v-btn
            class="mr-2"
            text
            color="primary"
            href="/home"
        >
            Home
        </v-btn>
        <v-btn
            text
            href="/doctors"
        >
            Find a doctor
        </v-btn>
        <v-btn
            text
        >
            Diagnosis
        </v-btn>
        <v-btn
            text
            href="/appointments"
        >
            Appointment
        </v-btn>
        <v-btn
            text
        >
            Feedback Form
        </v-btn>            
    </v-app-bar>
</template>

<script>
export default {
   data: () => ({
       active: null,
   }),

   methods: {
       landingPage () 
        {
            console.log("landing page")
            this.$router.replace('/')
        }
   }
}
</script>

<style scoped>
::v-deep .theme--light.v-card{
        background-color:transparent;
    }
</style>