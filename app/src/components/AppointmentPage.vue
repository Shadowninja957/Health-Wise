<template>
    <v-app>
        <top-navigation></top-navigation>
        <layout-page>
            <appointment-create
                v-if="createAppointment"
                v-on:loading="loading"
            ></appointment-create>
            <appointment-view
                v-else
                v-on:loading="loading"
            ></appointment-view>
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
import { mapGetters, mapMutations } from 'vuex';
import AppointmentCreate from './AppointmentPageCreate.vue';
import AppointmentView from './AppointmentPageView.vue';
export default {
    components: {
        TopNavigation,
        LayoutPage,
        AppointmentCreate,
        AppointmentView
    },

    created: function () {
        this.initialize();
    },

    computed: {
        ...mapGetters({
            doctor: 'doctor/getSelectedDoctor',
        })
    },

    data: () => ({
        createAppointment: false,
        overlay: false,
    }),

    methods: {
        initialize () {
            this.overlay = true;
            if(this.doctor){
                //make appointment
                console.log(`Doctor: ${this.doctor.name}`);
                this.createAppointment = true;
            }
            else{
                //view appointments
                this.createAppointment = false;
            }
            this.overlay = false;
        },

        ...mapMutations({
            //
        }),

        loading (value) {
            this.overlay = value;
        }
    }
}
</script>