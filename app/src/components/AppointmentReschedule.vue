<template>
    <v-dialog
        v-model="dialog"
        persistent
        max-width="400"
    >
        <v-card>
            <v-system-bar 
                    color="primary"
                    dark
                >
                    Reschedule Appointment
                </v-system-bar>
            <v-card-title>
                    <v-card-title>
                    <v-avatar
                        class="ma-3"
                        size="50"
                        tile
                    >
                        <v-img :src="require('../assets/stethoscope.png')"></v-img>
                    </v-avatar>
                    Dr. {{ rescheduleAppointment.name }}
                </v-card-title>
            </v-card-title>
            <v-container>
                <v-row
                    v-if="appointmentUpdated" 
                    justify="center"
                >
                    <v-col>
                        <v-alert
                            dismissible
                            type="success"
                        >
                            Appointment Rescheduled.
                        </v-alert>
                    </v-col>
                </v-row>
            </v-container>    
            <v-row
                v-if="appointmentUpdateError" 
                justify="center"
            >
                <v-col>
                    <v-alert
                        dismissible
                        type="error"
                    >
                        {{ appointmentUpdateError }}
                    </v-alert>
                </v-col>
            </v-row>
            <v-card-text>
                <v-menu
                    v-model="menu"
                    :close-on-content-click="false"
                    :nudge-right="40"
                    offset-y
                    min-width="auto"
                >
                    <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                            v-model="rescheduleAppointment.date"
                            label="Appoinment Date"
                            prepend-icon="mdi-calendar"
                            readonly
                            v-bind="attrs"
                            v-on="on"
                        ></v-text-field>
                    </template>
                    <v-date-picker
                        v-model="rescheduleAppointment.date"
                        @input="menu = false"
                        @change="newDate"
                    ></v-date-picker>
                </v-menu>
                <v-select
                    v-model="rescheduleAppointment.time"
                    :items="timeSlots"
                    item-value="time"
                    item-text="display"
                    label="Time"
                    prepend-icon="mdi-clock-outline"
                    class="mt-4"
                ></v-select>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="primary"
                    text
                    @click="cancel"
                >
                    Close
                </v-btn>
                <v-btn
                    color="primary"
                    outlined
                    @click="confirmReschedule"
                >
                    Reschedule
                </v-btn>
            </v-card-actions>

            <v-overlay
                :value="overlay"
            >
                <v-progress-circular
                    indeterminate
                    size="120"
                >
                    <span class="text-caption">Rescheduling...</span>
                </v-progress-circular>
            </v-overlay>
        </v-card>
    </v-dialog>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
export default {
    props: {
        openDialog: {
            type: Boolean,
            default: false,
        },
        appointment: {
            type: Object,
            default: function () {
                return {};
            }
        },
    },

    computed: {
        dialog: function () {
            return this.openDialog;
        },

        ...mapGetters({
            doctor: 'doctor/getSelectedDoctor',
        })
    },

    watch: {
        openDialog: function (val) {
            if(val){
                this.rescheduleAppointment = this.appointment;
                this.initialize();
            } 
        }
    },

    data: () => ({
        appointmentUpdated: false,
        appointmentUpdateError: null,
        menu: false,
        rescheduleAppointment: {},
        overlay: false,
        timeSlots:[],
    }),

    methods: {
        ...mapActions({
            updateAppointment: 'appointment/updateAppointment',
            getDoctorAppointments: 'doctor/getDoctorAppointments',
            getDoctorHours: 'doctor/getDoctorHours',
        }),

        ...mapMutations({
            setAppointmentDetails: 'appointment/setAppointmentDetails',
            setSelectedDoctor: 'doctor/setSelectedDoctor',
        }),

        async initialize () {
            console.log('reshedule appointment');
            this.timeSlots = [];
            let { doctor_id } = this.rescheduleAppointment;
            this.setSelectedDoctor({
                id: doctor_id
            });
            try {
                const { data: hours } = await this.getDoctorHours();
                let startTime = new Date("01/01/2022 " + hours[0].start_time);
                let endTime = new Date("01/01/2022 " + hours[0].end_time);
                for(let i = startTime.getHours(); i <= endTime.getHours(); i++){
                    let meridiem = i < 12 ? 'am' : 'pm';
                    let hour = i <= 12 ? i : i-12;
                    let h = i < 10 ? "0" + i : i;
                    this.timeSlots.push({
                        time: h + ":00:00",
                        display: hour + ":00 " + meridiem
                    })
                }
                console.log(this.rescheduleAppointment);
                this.setAppointmentDetails(this.rescheduleAppointment);
                const { data: appointments } = await this.getDoctorAppointments();
                // console.log(appointments)
                if(appointments.length != 0) this.setAllowedTimes(appointments)
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error); 
            }
        },

        setAllowedTimes (data) {
            let { time: appointmentTime } = this.rescheduleAppointment;
            console.log(appointmentTime);
            data.forEach(appointment => {
                let { time } = appointment;
                this.timeSlots = this.timeSlots.filter(value => {
                    if(value.time == appointmentTime) return value;
                    if(value.time != time) return value;
                })
            });
        },

        async confirmReschedule () {
            this.overlay = true;
            this.setAppointmentDetails(this.rescheduleAppointment);
            try {
                await this.updateAppointment();
                 setTimeout(() => {
                    this.overlay = false
                    this.appointmentUpdated = true; 
                    }, 2000);
                
            } catch (error) {
                console.log(error);
                setTimeout(() => {
                    this.overlay = false
                    this.appointmentUpdateError = "An Error occurred. Appointment not updated."
                    }, 2000);
                
            }
           
        },

        cancel () {
            this.$emit('close-reschedule')
            this.appointmentUpdated = false;
            this.appointmentUpdateError = null;
        },

        newDate () {
            console.log('date changed')
            this.initialize();
        }
    }
}
</script>