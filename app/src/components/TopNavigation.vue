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

        <v-menu
            bottom
            min-width="200px"
            offset-y
            open-on-hover
        >
            <template v-slot:activator="{ on }">
                <v-btn
                    text                    
                    v-on="on"
                    
                    class="mr-3"
                >
                    Appointments
                </v-btn>
            </template>
            <v-card>
                <v-list-item-content class="justify-center">
                    <div class="mx-auto text-center">
                         <v-btn
                            depressed
                            rounded
                            text
                            href="/doctors"
                        >
                            Make Appointment
                        </v-btn>
                        <v-divider class="my-3"></v-divider>
                        <v-btn
                            depressed
                            rounded
                            text
                            href="/appointments"
                        >
                            View Appoinments
                        </v-btn>
                    </div>
                </v-list-item-content>
            </v-card>
        </v-menu>

        <v-menu
            bottom
            min-width="200px"
            offset-y
            open-on-hover
        >
            <template v-slot:activator="{ on }">
                <v-btn
                    text                    
                    v-on="on"
                    
                    class="mr-3"
                >
                    Feedback
                </v-btn>
            </template>
            <v-card>
                <v-list-item-content class="justify-center">
                    <div class="mx-auto text-center">
                         <v-btn
                            depressed
                            rounded
                            text
                            href="/feedback-form"
                        >
                            Add Feedback
                        </v-btn>
                        <v-divider class="my-3"></v-divider>
                        <v-btn
                            depressed
                            rounded
                            text
                            href="/feedback-view"
                        >
                            View Feedback
                        </v-btn>
                    </div>
                </v-list-item-content>
            </v-card>
        </v-menu>        
       
        <v-menu
            bottom
            min-width="200px"
            offset-y
            open-on-hover
        >
            <template v-slot:activator="{ on }">
                <v-btn
                    icon
                    v-on="on"
                    dark
                    class="mr-3"
                >
                    <v-avatar color="primary">
                        <v-icon>
                            mdi-account-circle
                        </v-icon>
                    </v-avatar>
                </v-btn>
            </template>
            <v-card>
                <v-list-item-content class="justify-center">
                    <div class="mx-auto text-center">
                        <p class="text-caption mt-1">{{ user }}</p>
                        <v-divider class="my-3"></v-divider>
                        <v-btn
                            depressed
                            rounded
                            text
                            @click="signout"
                        >
                            Sign Out
                        </v-btn>
                    </div>
                </v-list-item-content>
            </v-card>
        </v-menu>
                    
    </v-app-bar>
</template>

<script>
import { mapMutations } from 'vuex'
export default {
   data: () => ({
       active: null,
       user: ""
   }),

   methods: {
       ...mapMutations({
            setAuthenticated: 'auth/setAuthenticated',
       }),

       landingPage () 
        {
            console.log("landing page")
            this.$router.replace('/')
        },

        signout () {
            this.setAuthenticated(false);
            sessionStorage.clear();
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