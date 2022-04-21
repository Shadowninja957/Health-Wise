<template>
    <v-dialog
        v-model="dialog"
        persistent
        width="500"
    >
        <v-card >
            <v-card-title class="text-h5 primary  lighten-2">
                Profile
            </v-card-title>
            <v-tabs
                v-model="tab"
                grow
                class="px-4"
            >
                <v-tab>Personal Info</v-tab>
                <v-tab v-if="doctor">Work Info</v-tab>
            </v-tabs>

            <v-tabs-items v-model="tab">
                <v-tab-item>
                    <v-card height="450">
                        <v-card-text>
                            <v-text-field
                                v-model="profile.first_name"
                                label="First Name"
                            ></v-text-field>
                            <v-text-field
                                v-model="profile.last_name"
                                label="Last Name"
                            ></v-text-field>
                            <v-select
                                v-model="profile.gender"
                                :items="genders"
                                item-text="detail"
                                item-value="abbr"
                                label="Gender"
                            ></v-select>
                            <v-menu
                                v-model="menu"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                min-width="auto"
                            >
                                <template
                                    v-slot:activator="{ on, attrs }"
                                >
                                    <v-text-field
                                        v-model="profile.date_of_birth"
                                        label="Date of Birth"
                                        readonly
                                        v-bind="attrs"
                                        v-on="on"
                                    ></v-text-field>
                                </template>
                                <v-date-picker
                                    v-model="profile.date_of_birth"
                                    @input="menu = false"
                                ></v-date-picker>
                            </v-menu>
                            <!-- <v-text-field
                                v-model="profile.email_address"
                                label="Email Address"
                                disabled
                                filled
                            ></v-text-field> -->
                            <v-text-field
                                v-if="doctor"
                                v-model="profile.work_number"
                                label="Phone Number"
                            ></v-text-field>
                            <v-text-field
                                v-else
                                v-model="profile.contact_number"
                                label="Phone Number"
                            ></v-text-field>
                            
                        </v-card-text>
                    </v-card>
                </v-tab-item>

                <v-tab-item v-if="doctor">
                    <v-card height="450">
                        <v-card-text class="pb-0">
                            <v-select
                                label="Speciality"
                                v-model="profile.speciality_id"
                                :items="specialities"
                                item-text="detail"
                                item-value="id"
                                clearable
                            ></v-select>
                            <v-text-field
                                v-model="profile.work_address"
                                label="Work Address"
                            ></v-text-field>
                            
                            <div>Work Location</div>
                            <v-row>
                                <v-col cols="6">
                                    <v-text-field
                                        v-model="profile.location_lat" 
                                        label="Latitude"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="6">
                                    <v-text-field
                                        v-model="profile.location_lng" 
                                        label="Longitude"
                                    ></v-text-field>
                                </v-col>
                            </v-row>
                            <div>Office Hours</div>
                            <v-row>
                                <v-col cols="6">
                                    <v-menu
                                        ref="menu1"
                                        v-model="menuTimeStart"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        :return-value.sync="profile.start_time"
                                        transition="scale-transition"
                                        offset-y
                                        max-width="290px"
                                        min-width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="profile.start_time"
                                                label="Start Time"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-time-picker
                                            v-if="menuTimeStart"
                                            v-model="profile.start_time"
                                            full-width
                                            @click:minute="$refs.menu1.save(profile.start_time)"
                                        ></v-time-picker>    
                                    </v-menu>
                                </v-col>
                                <v-col cols="6">
                                    <v-menu
                                        ref="menu2"
                                        v-model="menuTimeEnd"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        :return-value.sync="profile.end_time"
                                        transition="scale-transition"
                                        offset-y
                                        max-width="290px"
                                        min-width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="profile.end_time"
                                                label="End Time"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-time-picker
                                            v-if="menuTimeEnd"
                                            v-model="profile.end_time"
                                            full-width
                                            @click:minute="$refs.menu2.save(profile.end_time)"
                                        ></v-time-picker>    
                                    </v-menu>
                                </v-col>
                            </v-row>

                            <v-combobox
                                label="Office Days"
                                v-model="officeDays"
                                :items="days"
                                multiple
                                chips
                            >
                                <template v-slot:selection="data">
                                    <v-chip
                                        :key="JSON.stringify(data.item)"
                                        v-bind="data.attrs"
                                        :input-value="data.selected"
                                        @click:close="data.parent.selectItem(data.item)"
                                    >
                                        <v-avatar
                                            class="accent white--text"
                                            left
                                            v-text="data.item.slice(0, 2)"
                                        ></v-avatar>
                                        {{ data.item }}
                                    </v-chip>

                                </template>
                            </v-combobox>
                            
                        </v-card-text>    
                    </v-card>
                </v-tab-item>
            </v-tabs-items>
            
            <v-divider></v-divider>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="primary"
                    text
                    @click="close"
                    class="mr-4"
                >
                    Close
                </v-btn>
                <v-btn
                    color="primary"
                    elevation="0"
                    @click="updateProfile"
                >
                    Update
                </v-btn>
            </v-card-actions>
             <v-overlay
                :value="overlay"
            >
                <v-progress-circular
                    indeterminate
                    size="64"
                ></v-progress-circular>
            </v-overlay>
        </v-card>
        <v-snackbar
            v-model="snackbar.display"
            :color="snackbar.color"
        >
            {{ snackbar.text }}
            <template v-slot:action="{ attrs }">
                <v-btn
                    color="white"
                    text
                    v-bind="attrs"
                    @click="snackbar.display = false"
                >
                    Close
                </v-btn>
            </template>
        </v-snackbar>
    </v-dialog>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
export default { 
    props: {
        openDialog: {
            type: Boolean,
            default: false,
        }
    },

    watch: {
        openDialog: function (val) {
            if(val) this.initialize();
        }
    },

    computed: {
        dialog () {
            return this.openDialog;
        },

        ...mapGetters({
            profileDoctor: 'doctor/getProfile',
            getUser: 'auth/getUser',
            doctor: 'auth/getDoctor',
        }),

        user () {
            // console.log(this.getUser);
            return JSON.parse(this.getUser);
        }
    },

    data: function () {
        return {
            tab: null,
            profile: {
                first_name: '',
                last_name: '',
                gender: '',
                date_of_birth: null,
                contact_number: null,
            },
            menu: false,
            menuTimeStart: false,
            menuTimeEnd: false,
            genders: [
                { abbr: "M", detail: "Male" },
                { abbr: "F", detail: "Female" },
            ],
            snackbar: {
                display: false,
                text: null,
                color: 'primary',
            },
            overlay: false,
            days: [
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday'
            ],
            officeDays: [],
            specialities: [],
        }
    },

    methods: {
        ...mapMutations({
            setDoctorProfile: 'doctor/setDoctorProfile',
            setUser: 'auth/setUser',
            setPatientProfile: 'patient/setProfile',
        }),

        ...mapActions({
            postUpdateDoctor: 'doctor/postUpdate',
            postUpdatePatient: 'patient/postProfile',
            getSpecialities: 'doctor/getDoctorSpecialities',
        }),

        async initialize () {
            console.log('initializing profile...')
            try {
                const { data } = await this.getSpecialities();
                this.specialities = data;
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error)
            }
            this.profile = {...this.user};
            console.log(`Doctor: ${this.doctor}`)            
        },

        async updateProfile () {
            // console.log(this.profile)
            console.log(this.officeDays);
            this.profile.office_days = this.officeDays
            this.overlay = true;
            try {
                if(this.doctor){
                    this.setDoctorProfile(this.profile);
                    const { data: { doctor } } = await this.postUpdateDoctor();
                    this.snackbar.text = "Profile updated successfully."
                    this.snackbar.color = "primary"
                    // this.snackbar.display = true;
                    // console.log(doctor);
                    this.setUser(JSON.stringify(doctor))
                    sessionStorage.setItem('User', JSON.stringify(doctor));
                    setTimeout(() => {
                        this.snackbar.display = true;
                        this.overlay = false;
                    }, 2000)
                    return;
                }
                
                this.profile.contact_number = this.profile.work_number;
                this.setPatientProfile(this.profile);
                const { data: { patient }} = await this.postUpdatePatient();
                console.log(patient);
                let user = {...this.user, ...patient};
                // console.log(user);
                this.setUser(JSON.stringify(user));
                sessionStorage.setItem('User', JSON.stringify(user));
                this.snackbar.text = "Profile updated successfully."
                this.snackbar.color = "primary"

                
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
                this.snackbar.text = "Error occurred. Profile not updated";
                this.snackbar.color = "red"
                // this.snackbar.display = true;
            }
            setTimeout(() => {
                this.snackbar.display = true;
                this.overlay = false;
            }, 2000)
        },

        close () {
            this.$emit('close-profile');
        }
    }
}
</script>