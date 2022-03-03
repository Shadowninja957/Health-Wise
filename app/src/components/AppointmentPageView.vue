<template>
    <v-container>
         <v-row justify="center">
            <h1>View Appointments</h1>
        </v-row>
        <v-row class="text-center">
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

        
        <v-row >
            <v-col 
                
                v-for="appointment in appointments"
                :key="appointment.id"
            >
                <v-card width="350" >
                    <v-system-bar 
                        color="primary"
                        dark
                    >
                        Appointment Card
                    </v-system-bar>
                    <v-card-title>
                        <v-avatar
                            class="ma-3"
                            size="50"
                            tile
                        >
                            <v-img :src="require('../assets/stethoscope.png')"></v-img>
                        </v-avatar>
                        {{ appointment.name }}
                    </v-card-title>
                    <v-card-text>
                        <div>Specialization: {{ appointment.speciality }}</div>
                        <div>Age: {{ appointment.age }}</div>
                        <div>Contact: {{ appointment.work_number }}</div>
                        <div>Email: {{ appointment.email_address }}</div>
                        <div>Place of Work: {{ appointment.work_address }}</div>
                        <div class="font-weight-bold mt-3">Appointment Date and Time</div>
                        <div>{{ appointment.date }}, {{ appointment.time }}</div>
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
                        >
                            Reschedule Appointment
                        </v-btn>

                        <v-btn
                            color="primary"
                            dark
                            small
                            block
                            class="mb-3 ml-0"
                            rounded
                        >
                            View Doctor Location
                        </v-btn>
                        
                        <v-btn
                            color="red"
                            dark
                            small
                            block
                            class="ml-0"
                            rounded
                        >
                            Cancel Appointment
                        </v-btn>

                    
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
            
        
    </v-container>
    
</template>

<script>
import { mapActions } from 'vuex';
export default {
    created: function () {
        this.initialize();
    },

    data: () => ({
        appointments: [],
    }),

    methods: {
        ...mapActions({
            getAppointments: 'appointment/getAppointments',
        }),

        async initialize () {
            this.$emit("loading", true);
            console.log('initializing appointments...');
            try {
                const { data } = await this.getAppointments();
                this.appointments = data;
            } catch (error) {
                console.log(error);
            }
            this.$emit("loading", false)
        }
    }


}
</script>