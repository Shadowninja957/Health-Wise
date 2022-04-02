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
                <v-tab>Work Info</v-tab>
            </v-tabs>

            <v-tabs-items v-model="tab">
                <v-tab-item>
                    <v-card height="450">
                        <v-card-text>
                            <v-text-field
                                label="First Name"
                            ></v-text-field>
                            <v-text-field
                                label="Last Name"
                            ></v-text-field>
                            <v-select
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
                            
                        </v-card-text>
                    </v-card>
                </v-tab-item>

                <v-tab-item>
                    <v-card height="450">
                        <v-card-text>
                            <v-text-field
                                label="Work Address"
                            ></v-text-field>
                            <v-text-field
                                label="Email Address"
                            ></v-text-field>
                            <v-text-field
                                label="Work Number"
                            ></v-text-field>
                            <div>Work Location</div>
                            <v-row>
                                <v-col cols="6">
                                    <v-text-field label="Latitude"></v-text-field>
                                </v-col>
                                <v-col cols="6">
                                    <v-text-field label="Longitude"></v-text-field>
                                </v-col>
                            </v-row>
                            <div>Work Hours</div>
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
                >
                    Update
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script>
export default { 
    props: {
        openDialog: {
            type: Boolean,
            default: false,
        }
    },

    computed: {
        dialog () {
            return this.openDialog;
        }
    },

    data: function () {
        return {
            tab: null,
            profile: {
                date_of_birth: null,
            },
            menu: false,
            menuTimeStart: false,
        }
    },

    methods: {
        close () {
            this.$emit('close-profile');
        }
    }
}
</script>