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
                            <v-text-field
                                v-model="profile.email_address"
                                label="Email Address"
                            ></v-text-field>
                            <v-text-field
                                v-model="profile.work_number"
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
                                        ref="menu"
                                        v-model="menuTimeStart"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        :return-value.sync="profile.time_start"
                                        transition="scale-transition"
                                        offset-y
                                        max-width="290px"
                                        min-width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="profile.time_start"
                                                label="Start Time"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-time-picker
                                            v-if="menuTimeStart"
                                            v-model="profile.time_start"
                                            full-width
                                            @click:minute="$refs.menu.save(profile.time_start)"
                                        ></v-time-picker>    
                                    </v-menu>
                                </v-col>
                                <v-col cols="6">
                                    <v-menu
                                        ref="menu"
                                        v-model="menuTimeStart"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        :return-value.sync="profile.time_start"
                                        transition="scale-transition"
                                        offset-y
                                        max-width="290px"
                                        min-width="290px"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="profile.time_start"
                                                label="End Time"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-time-picker
                                            v-if="menuTimeStart"
                                            v-model="profile.time_start"
                                            full-width
                                            @click:minute="$refs.menu.save(profile.time_start)"
                                        ></v-time-picker>    
                                    </v-menu>
                                </v-col>
                            </v-row>

                            <v-combobox
                                label="Office Days"
                            ></v-combobox>
                            
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
        </v-card>
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
            return JSON.parse(this.getUser);
        }
    },

    data: function () {
        return {
            tab: null,
            profile: {},
            menu: false,
            menuTimeStart: false,
            genders: [
                { abbr: "M", detail: "Male" },
                { abbr: "F", detail: "Female" },
            ],
        }
    },

    methods: {
        ...mapMutations({
            setDoctorProfile: 'doctor/setDoctorProfile',
            setUser: 'auth/setUser',
        }),

        ...mapActions({
            postUpdateDoctor: 'doctor/postUpdate',
        }),

        initialize () {
            console.log('initializing profile...')
            // console.log(this.user);
            this.profile = {...this.user};
            console.log(`Doctor: ${this.doctor}`)
            
        },

        async updateProfile () {
            // console.log(this.profile)
            try {
                this.setDoctorProfile(this.profile);
                const { data: { doctor } } = await this.postUpdateDoctor();
                console.log(doctor);
                this.setUser(JSON.stringify(doctor))
                sessionStorage.setItem('User', JSON.stringify(doctor));
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
            }
        },

        close () {
            this.$emit('close-profile');
        }
    }
}
</script>