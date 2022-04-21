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
        <v-tabs
            v-model="tab"
            right
            slider-color="white"
        >
            <v-tab
                href="/home"
            >
                Home               
            </v-tab>
            <v-tab
                v-if="!doctor"
                href="/doctors"
            >
                Find a doctor
            </v-tab>
            <v-tab
                v-if="!doctor"
                href="/diagnosis"
            >
                Diagnosis
            </v-tab>
            
                 <v-menu
                    bottom
                    min-width="200px"
                    offset-y
                    open-on-hover
                >
                    <template v-slot:activator="{ on }">
                        <v-tab
                            v-on="on"
                        >
                            Appointments
                        </v-tab>
                    </template>
                    <v-card>
                        <v-list-item-content class="justify-center">
                            <div class="mx-auto text-center">
                                <v-btn
                                    v-if="!doctor"
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
                        <v-tab
                            v-on="on"
                        >
                            Feedback
                        </v-tab>
                    </template>
                    <v-card>
                        <v-list-item-content class="justify-center">
                            <div class="mx-auto text-center" >
                                <v-btn
                                    depressed
                                    rounded
                                    text
                                    href="/feedback-form"
                                    v-if="!doctor"
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
            
        </v-tabs>

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
                        <p class="text-caption mt-1">{{ userEmail }}</p>
                        <v-divider class="my-3"></v-divider>
                        <v-btn
                            depressed
                            rounded
                            block
                            text
                            @click="openProfile"
                        >
                            Profile
                        </v-btn>
                        <v-btn
                            depressed
                            rounded
                            block
                            text
                            @click="signout"
                        >
                            Sign Out
                        </v-btn>
                    </div>
                </v-list-item-content>
            </v-card>
        </v-menu>
        <user-profile
            :openDialog="dialogProfile"
            @close-profile="closeProfile"
        ></user-profile>            
    </v-app-bar>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import UserProfile from './UserProfile.vue'
export default {
    components: {
        UserProfile
    },

    data: () => ({
        active: null,
        user: null,
        dialogProfile: false,
        tab: null,
    }),

    computed: {
        ...mapGetters({
            userEmail: 'auth/getUserEmail',
            getUser: 'auth/getUser',
            doctor: 'auth/getDoctor',
            getTab: 'navigation/getTab',
        }),

    },

    methods: {
        ...mapMutations({
            setAuthenticated: 'auth/setAuthenticated',
            setDoctor: 'auth/setDoctor',
            setPatientId: 'auth/setPatientId',
            setDoctorId: 'auth/setDoctorId',
            setTab: 'navigation/setTab',
        }),


        landingPage () {
            console.log("landing page")
            this.$router.replace('/')
        },

        signout () {
            this.setAuthenticated(false);
            this.setDoctor();
            this.setPatientId(null);
            this.setDoctorId(null);
            sessionStorage.clear();
            console.log(`Doctor: ${this.doctor}`);
            this.$router.replace('/')
        },

        openProfile () {
            this.dialogProfile = true;
            console.log("opening profile...")
        },

        closeProfile () {
            this.dialogProfile = false;
        }
    }
}
</script>

<style scoped>
::v-deep .theme--light.v-card{
        background-color:transparent;
    }
</style>