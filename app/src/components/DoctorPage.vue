<template>
    <v-app>
        <top-navigation></top-navigation>
        <layout-page>
            <v-row class="text-center">
                <v-col>
                    <h1>Find a Doctor</h1>
                    <v-card 
                        flat
                        width="400"
                        class="mx-auto"
                    >
                        <v-text-field
                            clearable
                            placeholder="Search Dr. Name / Speciality"
                            v-model="search"
                            @keydown="filterDoctors"
                            outlined
                            hide-details
                        ></v-text-field>
                    </v-card>
                    
                </v-col>
            </v-row>
            <v-container>
                <v-row >
                    <v-col 
                        
                        v-for="doctor in doctorsSearch"
                        :key="doctor.id"
                    >
                        <v-card width="350" height="390" >
                            <v-system-bar 
                                color="primary"
                                dark
                            >
                                Medical Practitioner
                            </v-system-bar>
                            <v-card-title>
                                <v-avatar
                                    class="ma-3"
                                    size="50"
                                    tile
                                >
                                    <v-img :src="require('../assets/stethoscope.png')"></v-img>
                                </v-avatar>
                                {{ doctor.name }}
                            </v-card-title>
                            <v-card-text>
                                <div>Specialization: {{ doctor.speciality }}</div>
                                <div>Age: {{ doctor.age }}</div>
                                <div>Contact: {{ doctor.work_number }}</div>
                                <div>Email: {{ doctor.email_address }}</div>
                                <div>Place of Work: {{ doctor.work_address }}</div>
                                <div>Work Hours</div>
                                <div>{{ doctor.work_days }}</div>
                                <div>{{ doctor.work_hours }}</div>
                            </v-card-text>
                            <v-card-actions class="d-flex justify-center">
                                <google-maps 
                                    buttonText="Show Location"
                                    :lat="doctor.location_lat"
                                    :lng="doctor.location_lng"
                                ></google-maps>
                                <v-spacer></v-spacer>
                                <v-btn
                                    color="primary"
                                    dark
                                    small
                                    rounded
                                    @click="makeAppointment(doctor)"
                                >
                                    Make Appointment
                                </v-btn>

                            
                            </v-card-actions>
                        </v-card>
                    </v-col>
                </v-row>
            </v-container>
        </layout-page>
        <v-overlay
            :value="overlay"
        >
            <v-progress-circular
                indeterminate
                size="64"
            ></v-progress-circular>
        </v-overlay>
    </v-app>
</template>

<script>
import TopNavigation from './TopNavigation.vue';
import LayoutPage from './LayoutPage.vue';
import GoogleMaps from './GoogleMaps.vue'
import { mapActions, mapMutations } from 'vuex';
export default {
    components: {
        TopNavigation,
        LayoutPage,
        GoogleMaps,
    },

    created: function () {
        this.initialize();
    },

    data: () => ({
        doctors: [],
        doctorsSearch: [],
        overlay: false,
        search: "",
    }),

    methods: {
        ...mapActions({
            getDoctors: 'doctor/getDoctors',
        }),

        ...mapMutations({
            setDoctor: 'doctor/setSelectedDoctor',
            setTab: 'navigation/setTab',
        }),

        async initialize () {
            console.log('doctors initializing..');
            this.setTab(2);
            this.overlay = true;
            try {
                const { data } = await this.getDoctors();
                // console.log(data);
                this.doctors = data;
                this.doctorsSearch = data;
            } catch (error) {
                if(error.response) console.log(error.response)
                else console.log(error);
            }
            this.overlay = false;
        },

        filterDoctors () {
            console.log(this.search);
            this.doctorsSearch = this.doctors.filter(this.checkDoctor);
        },

        checkDoctor (doctor) {
            if(
                doctor.name.toLowerCase().indexOf(this.search) !== -1 ||
                doctor.speciality.toLowerCase().includes(this.search)
            ) 
            return true;
            return false;
        },

        makeAppointment (doctor) {
            console.log(doctor);
            this.setDoctor(doctor);
            this.$router.replace('/appointments')
        }

        
    }
}
</script>