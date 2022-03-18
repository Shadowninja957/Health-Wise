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
                        >
                            <v-card-title class="justify-center text-h4 font-weight-bold">Create Account</v-card-title>
                            <v-card-text>Get your access today in one easy step</v-card-text>
                            <v-text-field
                                outlined
                                label="Email"
                                v-model="email"
                            ></v-text-field>
                            <v-text-field
                                label="Password"
                                v-model="password"
                                :append-icon="show? 'mdi-eye' : 'mdi-eye-off'"
                                :type="show ? 'text' : 'password'"
                                @click:append="show = !show"
                                outlined
                            ></v-text-field>
                            <v-card-actions>
                                <v-checkbox
                                    label="I agree to Terms & Conditions"
                                ></v-checkbox>
                                <v-spacer></v-spacer>
                                <v-btn color="primary" text>View Terms</v-btn>
                                
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
        overlay: false,
    }),

    methods: {
        ...mapActions({
            newUser: 'auth/signUp',
            logIn: 'auth/logIn',
            getPatient: 'auth/getPatient',
            postPatient: 'auth/postPatient',
        }),

        ...mapMutations({
            setCredentials: 'auth/setCredentials',
            setAuthenticated: 'auth/setAuthenticated',
            setUserId: 'auth/setUserId',
            setPatient: 'auth/setPatient',
        }),

        back ()
        {
            this.$router.replace('/')
        },

        validate () {
            if(!this.email && !this.password ) return
            this.overlay = true;
            setTimeout(this.signup, 2000)
        },

        async signup ()
        {
            console.log(`Email: ${this.email} Password: ${this.password}`);
            this.setCredentials({
                user_name: this.email,
                password: this.password,
                role_id: 1
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
                    password: this.password
                })
                try {
                    const { data } = await this.logIn();
                    console.log(`User ID: ${data.data[0].user_id}`);
                    this.setUserId(data.data[0].user_id);
                    sessionStorage.setItem('UserId', data.data[0].user_id);
                    this.setAuthenticated(true);
                    await this.postPatient();
                    const { data: dataPatient } = await this.getPatient();
                    console.log(dataPatient);
                    this.setPatient(dataPatient[0]);
                    sessionStorage.setItem('Patient', JSON.stringify(dataPatient[0]));
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
</style>