<template>
    <v-app>
        <v-main>
            <v-container 
                fluid 
                class="fill-height justify center"
            >
                <v-fab-transition>
                    <v-btn
                        color="primary"
                        dark
                        fab
                        top
                        left
                        @click="back"
                    >
                        <v-icon>mdi-arrow-left</v-icon>
                    </v-btn>
                </v-fab-transition>

                <v-row class="text-center">
                    <v-col>
                        <v-card
                            max-width="500"
                            flat
                            class="mx-auto"
                            ref="form"
                        >
                            <v-card-title class="justify-center text-h4 font-weight-bold">Create Account</v-card-title>
                            <v-card-text>Get your access today in one easy step</v-card-text>
                            <v-text-field
                                outlined
                                label="First Name"
                                v-model="firstName"
                                :rules="[rules.required]"
                            ></v-text-field>
                            <v-text-field
                                outlined
                                label="Last Name"
                                v-model="lastName"
                                :rules="[rules.required]"
                            ></v-text-field>
                            <v-text-field
                                outlined
                                label="Email"
                                v-model="email"
                                :rules="[rules.required, rules.email]"
                            ></v-text-field>
                            <v-text-field
                                label="Password"
                                v-model="password"
                                :append-icon="show? 'mdi-eye' : 'mdi-eye-off'"
                                :type="show ? 'text' : 'password'"
                                @click:append="show = !show"
                                :rules="[rules.required]"
                                outlined
                                hide-details=""
                            ></v-text-field>
                            <v-card-actions class="flex-column justify-start">
                                <!-- <div>
                                    <v-checkbox
                                        label="Doctor"
                                        v-model="doctor"
                                    ></v-checkbox>
                                </div>     -->
                                <div class="d-flex">
                                    <v-checkbox
                                        label="I agree to Terms & Conditions"
                                    ></v-checkbox>
                                    <v-spacer></v-spacer>
                                    <v-btn 
                                        color="primary" 
                                        text
                                        class="mt-3"
                                    >
                                        View Terms
                                    </v-btn>
                                </div>
                                
                            </v-card-actions>
                            <v-row>
                                <v-col>
                                    <v-btn 
                                        color="primary" 
                                        block
                                        @click="validate"
                                    >
                                        Sign Up
                                    </v-btn>
                                </v-col>    
                            </v-row>
                        </v-card>
                       
                    </v-col>
                </v-row>
                
            </v-container>
            <v-overlay
            :value="overlay"
        >
            <v-progress-circular
                indeterminate
                size="64"
            ></v-progress-circular>
        </v-overlay>
        </v-main>
    </v-app>
</template>

<script>
import { mapActions, mapMutations } from 'vuex';
export default {
    data: () => ({
        show: false,
        email: "",
        password: "",
        firstName: "",
        lastName: "",
        overlay: false,
        rules: {
            required: value => !!value || 'Required.',
            email: value => {
                const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                return pattern.test(value) || 'Invalid e-mail.'
            }
        },
        doctor: false,
    }),

    methods: {
        ...mapActions({
            newUser: 'auth/signUp',
            logIn: 'auth/logIn',
            getPatient: 'auth/getPatient',
            postPatient: 'auth/postPatient',
            postDoctor: 'auth/postDoctor',
            getDoctor: 'auth/getDoctor',
        }),

        ...mapMutations({
            setCredentials: 'auth/setCredentials',
            setAuthenticated: 'auth/setAuthenticated',
            setUserId: 'auth/setUserId',
            setUser: 'auth/setUser',
            setUserEmail: 'auth/setUserEmail',
        }),

        back ()
        {
            this.$router.replace('/')
        },

        validate () {
            if(
                !this.email && 
                !this.password &&
                !this.firstName &&
                !this.lastName 
            ) return
            this.overlay = true;
            setTimeout(this.signup, 2000)
        },

        async signup ()
        {
            let role = this.doctor ? 2 : 1;
            this.setCredentials({
                user_name: this.email,
                password: this.password,                
                role_id: role
            })
            try {
                const response = await this.newUser();
                await this.signin();
                console.log(response);
            } catch (error) {
                if(error.response) console.log(error.response)
                else console.log(error)
            }
            this.overlay = false;
        },

        async signin ()
        {
            if(this.email && this.password)
            {
                this.setCredentials({
                    user_name: this.email,
                    password: this.password,
                    first_name: this.firstName,
                    last_name: this.lastName,
                })
                try {
                    const { data } = await this.logIn();
                    console.log(`User ID: ${data.data[0].user_id}`);
                    this.setUserId(data.data[0].user_id);
                    sessionStorage.setItem('UserId', data.data[0].user_id);
                    this.setUserEmail(this.email);
                    sessionStorage.setItem('UserEmail', this.email);
                    this.setAuthenticated(true);
                    let dataUser = null;
                    if(this.doctor){
                        await this.postDoctor();
                        const { data } = await this.getDoctor();
                        dataUser = data;
                    } 
                    else{
                        await this.postPatient();
                        const { data } = await this.getPatient();
                        console.log(data);
                        sessionStorage.setItem('PatientId',data[0].id )
                        dataUser = data;
                    } 
                    this.setUser(dataUser[0]);
                    sessionStorage.setItem('User', JSON.stringify(dataUser[0]));
                    // console.log(`Authenticated: ${this.authenticated}`);
                    sessionStorage.setItem('Authenticated', "true");
                    this.$router.replace('/home')
                } catch (error) {
                    if(error.response) console.log(error.response);
                    else console.log(error);
                }
            }
        }
    }
}
</script>

<style scoped>
    ::v-deep .v-btn--fab.v-size--default{
        position: absolute;
    }

    ::v-deep .v-card__actions{
        align-items: normal;
    }
</style>