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
                    ></v-date-picker>
                </v-menu>
                <v-select
                    v-model="rescheduleAppointment.time"
                    :items="timeSlots"
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
import { mapActions, mapMutations } from 'vuex'
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
        }
    },

    watch: {
        openDialog: function (val) {
            if(val) this.rescheduleAppointment = this.appointment
        }
    },

    data: () => ({
        appointmentUpdated: false,
        appointmentUpdateError: null,
        menu: false,
        rescheduleAppointment: {},
        overlay: false,
        timeSlots:["11:00 am", "12:00 am", "1:00 pm", "2:00 pm"],
    }),

    methods: {
        ...mapActions({
            updateAppointment: 'appointment/updateAppointment',
        }),

        ...mapMutations({
            setAppointmentDetails: 'appointment/setAppointmentDetails',
        }),

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
        }
    }
}
</script>