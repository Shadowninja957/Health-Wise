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
                    Cancel Appointment
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
                    Dr. {{ appointment.name }}
                </v-card-title>
            </v-card-title>
            <v-container>
                <v-row
                    v-if="appointmentCancelled" 
                    justify="center"
                >
                    <v-col>
                        <v-alert
                            dismissible
                            type="success"
                        >
                            Appointment Cancelled.
                        </v-alert>
                    </v-col>
                </v-row>
            </v-container>    
            <v-row
                v-if="appointmentCancellError" 
                justify="center"
            >
                <v-col>
                    <v-alert
                        dismissible
                        type="error"
                    >
                        {{ appointmentCancellError }}
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
                    disabled
                >
                    <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                            v-model="appointment.date"
                            label="Appoinment Date"
                            prepend-icon="mdi-calendar"
                            readonly
                            v-bind="attrs"
                            v-on="on"
                            filled
                        ></v-text-field>
                    </template>
                    <v-date-picker
                        v-model="appointment.date"
                        @input="menu = false"
                    ></v-date-picker>
                </v-menu>
                <v-select
                    v-model="appointment.time"
                    :items="timeSlots"
                    label="Time"
                    prepend-icon="mdi-clock-outline"
                    class="mt-4"
                    readonly
                    filled
                ></v-select>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="primary"
                    text
                    @click="close"
                >
                    Close
                </v-btn>
                <v-btn
                    color="primary"
                    outlined
                    @click="confirmCancel"
                >
                    Cancel Appointment
                </v-btn>
            </v-card-actions>

            <v-overlay
                :value="overlay"
            >
                <v-progress-circular
                    indeterminate
                    size="120"
                >
                    <span class="text-caption">Cancelling...</span>
                </v-progress-circular>
            </v-overlay>
        </v-card>
    </v-dialog>
</template>

<script>
import { mapActions, mapMutations } from 'vuex';
export default {
    props: {
        openDialog: {
            type: Boolean,
            default: false,
        },
        appointmentCancel: {
            type: Object,
            default: function () {
                return {};
            }
        },
    },

    watch: {
        openDialog: function (val) {
            console.log(`Cancel: ${val}`)
            if(val) this.appointment = this.appointmentCancel;
        },

       
    },
    
    computed: {
        dialog: function () {
            return this.openDialog;
        }
    },

    data: function () {
        return {
            appointment: {},
            overlay: false,
            appointmentCancelled: false,
            appointmentCancellError: null,
            menu: false,
            timeSlots:["11:00 am", "12:00 am", "1:00 pm", "2:00 pm"],
        }
    },

    methods: {
        ...mapActions({
            cancelAppointment: 'appointment/cancelAppointment',
        }),

        ...mapMutations({
            setAppointmentDetails: 'appointment/setAppointmentDetails',
        }),

        async confirmCancel () {
            this.overlay = true;
            this.setAppointmentDetails(this.appointment);
            try {
                await this.cancelAppointment();
                setTimeout(() => {
                    this.overlay = false
                    this.appointmentCancelled = true;
                    this.$emit('appointment-cancelled') 
                    }, 2000);
            } catch (error) {
                console.log(error);
                setTimeout(() => {
                    this.overlay = false
                    this.appointmentCancellError = "An Error occurred. Appointment not cancelled."; 
                    }, 2000);
            }
        },

        close () {
            this.appointmentCancelled = false;
            this.appointmentCancellError = "";
            this.$emit('close-cancel')
        }
    }
}
</script>