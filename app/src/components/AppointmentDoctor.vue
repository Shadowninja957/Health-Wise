<template>
    <v-row>
        <v-col cols="4">
            <v-date-picker
                v-model="date"
                width="350"
                elevation="15"
            ></v-date-picker>
        </v-col>
        <v-col cols="8">
            <v-container style="height: 75vh; overflow-y: auto;">
                <div 
                    class="text-center text-h4 font-weight-light" 
                    v-if="appointments.length == 0"
                >
                    No Appointments
                </div>
                <div
                    v-for="appointment in appointments"
                    :key="appointment.id"
                    class="d-flex justify-center"
                >
                    <v-card 
                        width="350"
                        elevation="15"
                        class="mb-4" 
                    >
                        <v-system-bar 
                            color="primary"
                            dark
                        >
                            Appointment Card
                        </v-system-bar>
                        <v-card-title>
                            Patient: {{ appointment.name }}
                        </v-card-title>
                        <v-card-text>
                            <div>Age: {{ appointment.age }}</div>
                            <div>Contact: {{ appointment.work_number }}</div>
                            <div class="font-weight-bold mt-3">Appointment Date and Time</div>
                            <div>{{ appointment.date }}, {{ appointment.time }}</div>
                            <div class="font-weight-bold mt-3">Reason for appointment</div>
                            <div>{{ appointment.details }}</div>
                        </v-card-text>
                        <v-card-actions class="flex-column" >
                        
                        </v-card-actions>
                    </v-card>
                </div>
            </v-container>
        </v-col>
    </v-row>
</template>

<script>
import { format } from 'date-fns';
export default {
    props: {
        appointmentsAll: {
            type: Array,
            default: function () {
                return []
            }
        }
    },

    watch: {
        date: function () {
            this.appointmentsFilter();
        }, 

        appointmentsAll: function () {
            this.initialize();
        }
    },

    data: () => ({
        date: null,
        appointments: [],
    }),

    methods: {
        initialize () {
            // console.log('initialzing appointments...');
            this.date = (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
            // console.log(this.date);
            this.appointmentsFilter();
        },

        
        appointmentsFilter () {
            this.appointments = this.appointmentsAll.filter(value => {
                if(value.date == this.date){
                    value.time = format(new Date("2022-04-21 " + value.time), "h:mm a")
                    return value;
                }
            })
        }
    }
}
</script>