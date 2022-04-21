<template>
    <v-container>
         <v-row justify="center">
            <h1>View Appointments</h1>
        </v-row>
        <v-row
            v-if="patientId" 
            class="text-center"
        >
            <v-col>
                <v-card 
                    flat
                    width="400"
                    class="mx-auto"
                >
                    <v-text-field
                        clearable
                        placeholder="Search Dr. Name / Speciality"
                        outlined
                        hide-details
                    ></v-text-field>                    
                </v-card>
            </v-col>
        </v-row>

        
        <v-row v-if="patientId">
            <v-col 
                
                v-for="appointment in appointments"
                :key="appointment.id"
            >
                <v-card 
                    width="350" 
                    :color="appointment.cancel == 1 ? 'red lighten-3' : 'white'"
                
                >
                    <v-system-bar 
                        :color="appointment.cancel == 1 ? 'red' : 'primary'"
                        dark
                    >
                        {{ appointment.cancel == 1 ? "Appointment Card - Cancelled" : "Appointment Card"}}
                    </v-system-bar>
                    <v-card-title>
                        <v-avatar
                            class="ma-3"
                            size="50"
                            tile
                        >
                            <v-img :src="require('../assets/stethoscope.png')"></v-img>
                        </v-avatar>
                        Dr. {{ appointment.name }}
                    </v-card-title>
                    <v-card-text>
                        <div>Specialization: {{ appointment.speciality }}</div>
                        <div>Age: {{ appointment.age }}</div>
                        <div>Contact: {{ appointment.work_number }}</div>
                        <div>Email: {{ appointment.email_address }}</div>
                        <div>Place of Work: {{ appointment.work_address }}</div>
                        <div class="font-weight-bold mt-3">Appointment Date and Time</div>
                        <!-- <div>{{ appointment.date }}, {{ appointment.time }}</div> -->
                        <div>{{ appointmentDateTime(appointment) }}</div>
                        <div class="font-weight-bold mt-3">Reason for appointment</div>
                        <div>{{ appointment.details }}</div>
                    </v-card-text>
                    <v-card-actions class="flex-column" >
                        <v-btn
                            color="primary"
                            dark
                            small
                            block
                            class="mb-3"
                            rounded
                            @click="reschedule(appointment)"
                            :disabled="appointment.cancel == 1 ? true : false"
                        >
                            Reschedule Appointment
                        </v-btn>

                        
                            
                        <google-maps
                            buttonText="View Doctor Location"
                            :block=true
                            :disabled="appointment.cancel == 1 ? true : false"
                            :lat="appointment.location_lat"
                            :lng="appointment.location_lng"
                        ></google-maps>                      
                        
                        <v-btn
                            color="red"
                            dark
                            small
                            block
                            class="ml-0 mt-3"
                            rounded
                            @click="cancelAppointment(appointment)"
                            :disabled="appointment.cancel == 1 ? true : false"
                        >
                            Cancel Appointment
                        </v-btn>

                    
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>

        <appointment-doctor
            v-if="doctorId"
            :appointmentsAll="appointments"
        ></appointment-doctor>

        <appointment-reschedule
            :openDialog="dialogReschedule"
            :appointment="rescheduleAppointment"
            @close-reschedule="closeReschedule"
        ></appointment-reschedule>

        <appointment-cancel
            :openDialog="dialogCancel"
            :appointmentCancel="appointmentSelected"
            @close-cancel="closeCancel"
            @appointment-cancelled="appointmentCancelled"
        ></appointment-cancel>
            
        
    </v-container>
    
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import GoogleMaps from './GoogleMaps.vue';
import AppointmentReschedule from './AppointmentReschedule.vue';
import AppointmentCancel from './AppointmentCancel.vue';
import AppointmentDoctor from './AppointmentDoctor.vue';
// import moment from "moment";
import { format } from 'date-fns';

export default {
    components: {
        GoogleMaps,
        AppointmentReschedule,
        AppointmentCancel,
        AppointmentDoctor
    },

    created: function () {
        this.initialize();
    },

    computed: {
        ...mapGetters({
            doctorId: 'auth/getDoctorId',
            patientId: 'auth/getPatientId',
        }),        
    },

    data: () => ({
        appointments: [],
        dialogReschedule: false,
        dialogCancel: false,
        rescheduleAppointment: {},
        appointmentSelected: {
            cancel: 0,
        },
    }),

    methods: {
        ...mapActions({
            getAppointments: 'appointment/getAppointments',
        }),

        async initialize () {
            // console.log(`Dr ID: ${this.doctorId}`);
            // console.log(`Paitent ID: ${this.patientId}`);
            this.$emit("loading", true);
            // console.log('initializing appointments...');
            try {
                const { data } = await this.getAppointments();
                // console.log(data);
                this.appointments = data;
            } catch (error) {
                console.log(error);
                console.log(error.response);
            }
            this.$emit("loading", false)
        },

        reschedule (appointment) {
            this.rescheduleAppointment = appointment;
            // console.log(this.rescheduleAppointment);            
            this.dialogReschedule = true;
        },

        closeReschedule () {
            this.dialogReschedule = false;
        },

        cancelAppointment (appointment) {
            console.log('cancelling...');
            this.appointmentSelected = appointment;
            this.dialogCancel = true;
        },

        closeCancel () {
            this.dialogCancel = false;
        },

        appointmentCancelled () {
            this.appointmentSelected.cancel = 1;
        },

        appointmentDateTime (appointment) {
            // console.log(appointment);
            let datetime = new Date(appointment.date + ' ' + appointment.time)
            // console.log(format(datetime, 'EEEE do MMM yyyy hh:mm a'));
            // console.log(moment(datetime).format("dddd Do MMM YYYY LLL"))
            return format(datetime, 'EEEE do MMM yyyy h:mm a')
        }

        
    }


}
</script>