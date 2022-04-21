<template>
    <v-container>
        <v-row
            v-if="appointmentCreated" 
            justify="center"
        >
            <v-alert
                dismissible
                type="success"
            >
                Appointment Successfully Created.
            </v-alert>
        </v-row>
        <v-row
            v-if="appointmentError" 
            justify="center"
        >
            <v-alert
                dismissible
                type="error"
            >
                Unable to create appointment, an error occured.
            </v-alert>
        </v-row>
        <v-row justify="center">
            <h1>Make Appointment</h1>
        </v-row>
        <v-row justify="center" class="font-weight-light">
            <p>Select Date and Time for Appointment</p>
        </v-row>
        <v-row justify="center">
            <v-alert type="info">Please Select Date First.</v-alert>
        </v-row>
        <v-row justify="center">
            <p class="font-weight-bold">Dr. {{ doctor.name }}</p>
        </v-row>
        <v-row justify="center">
            <v-col cols="4">
                <v-date-picker
                    v-model="date"
                    class="mt-4"
                    :allowed-dates="allowedDates"
                ></v-date-picker>
            </v-col>
            <v-col cols="4">
                <v-select
                    v-model="appointment.time"
                    :items="timeSlots"
                    item-value="time"
                    item-text="display"
                    label="Select an Available Time"
                    outlined
                    class="mt-4"
                    :disabled="disabledTime"
                ></v-select>
                <v-textarea
                    v-model="appointment.details"
                    label="Reason for appointment"
                    outlined
                    clearable
                ></v-textarea>
            </v-col>
        </v-row>
        <v-row justify="center" class="mt-4">
            <v-btn
                color="primary"
                rounded
                @click="makeAppointment"
            >
                Make Appointment
            </v-btn>
        </v-row>
        <v-overlay
            :value="overlay"
        >
            <v-progress-circular
                indeterminate
                size="64"
            ></v-progress-circular>
        </v-overlay>
    </v-container>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
export default {

    mounted: function () {
        this.initialize();
    },

    data: () => ({
        date: "",
        timeSlots:[],
        appointment:{
            patient_id: null,
            doctor_id: null,
            date: null,
            time: null,
            details: null
        },
        appointmentError: false,
        appointmentCreated: false,
        disabledTime: true,
        overlay: false,
    }),

    watch: {
        date: function (val) {
            if(val){
                // console.log('date selected');
                this.getAppointments();
            } 
            else console.log('no date selected');
        }
    },

    computed: {
        ...mapGetters({
            doctor: 'doctor/getSelectedDoctor',
            userId: 'auth/getUserId',
            appointmentDetails: 'appointment/getAppointmentDetails',
            patientId: 'auth/getPatientId',
        }),

        
    },

    methods: {
        ...mapMutations({
            setAppointmentDetails: 'appointment/setAppointmentDetails',
            setSelectedDoctor: 'doctor/setSelectedDoctor',
        }),

        ...mapActions({
            setAppointment: 'appointment/setAppointment',
            getDoctorAppointments: 'doctor/getDoctorAppointments',
        }),

        initialize () {
            // console.log(this.doctor);
            let { hours } = this.doctor;
            let startTime = new Date("01/01/2022 " + hours[0].start_time);
            let endTime = new Date("01/01/2022 " + hours[0].end_time);
            // let hourDiff = endTime.getHours() - startTime.getHours();
            // console.log(endTime.getHours());
            // console.log(hourDiff);
            for(let i = startTime.getHours(); i <= endTime.getHours(); i++){
                let meridiem = i < 12 ? 'am' : 'pm';
                let hour = i <= 12 ? i : i-12;
                let h = i < 10 ? "0" + i : i;
                this.timeSlots.push({
                    time: h + ":00:00",
                    display: hour + ":00 " + meridiem
                })
            }
            // console.log(this.timeSlots);
        },

        allowedDates () {
            // let selectedMonth = parseInt(val.split('-')[1]);
            // let selectedDay = parseInt(val.split('-')[2]);
            // let today = new Date();
            // if(selectedMonth >= today.getMonth() && selectedDay >= today.getDate()){
            //     console.log("true")
            //     return true
            // }
            
            // return false
            // console.log(val);
            return true;
        },

        async makeAppointment () {
            this.appointment.patient_id = this.patientId;
            this.appointment.doctor_id = this.doctor.id;
            this.appointment.date = this.date;
            this.$emit("loading", true);
            if(
                !this.userId ||
                !this.doctor.id ||
                !this.date ||
                !this.appointment.time
            ){
                this.$emit("loading", false);
                this.appointmentError = true;
                console.log(this.appointment);
                return;
            } 

            this.appointmentError = false;
            try {
                console.log(this.appointment);
                this.setAppointmentDetails(this.appointment);
                console.log(this.appointmentDetails);
                const response = await this.setAppointment();
                this.appointmentCreated = true;
                // this.setSelectedDoctor(null);
                console.log(response);
            } catch (error) {
                console.log(error);
                this.appointmentError = true;
            }
            this.$emit("loading", false);
        },

        async getAppointments () {
            this.appointment.patient_id = this.patientId;
            this.appointment.doctor_id = this.doctor.id;
            this.appointment.date = this.date;
            this.setAppointmentDetails(this.appointment);
            this.overlay = true;
            try {
                const { data } = await this.getDoctorAppointments();
                if(data.length != 0) this.setAllowedTimes(data)
                this.disabledTime = false;
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
            }
            setTimeout(() => {
                this.overlay = false;
            }, 2000)
        },

        setAllowedTimes (data) {
            data.forEach(appointment => {
                let { time } = appointment;
                this.timeSlots = this.timeSlots.filter(value => {
                    if(value.time != time) return value;
                })
            });
        }
    }
}
</script>