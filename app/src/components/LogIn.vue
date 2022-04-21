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
                            <v-card-title class="justify-center text-h4 font-weight-bold">Sign In</v-card-title>
                            <v-card-text>
                                <span>Welcome, please login or </span> 
                                <v-btn 
                                    color="primary" 
                                    text
                                    class="pa-0 text-lowercase"
                                    @click="signup"
                                >
                                    sign up
                                </v-btn> 
                                <span>for a new acount.</span>
                            </v-card-text>
                            <v-text-field
                                v-model="email"
                                outlined
                                label="Email"
                            ></v-text-field>
                            <v-text-field
                                v-model="password"
                                label="Password"
                                :append-icon="show? 'mdi-eye' : 'mdi-eye-off'"
                                :type="show ? 'text' : 'password'"
                                @click:append="show = !show"
                                @keydown="keyCheck"
                                outlined
                            ></v-text-field>
                            <v-card-actions>
                                <v-btn text>Forgot Password?</v-btn>
                                <v-spacer></v-spacer>
                                <v-btn 
                                    color="primary" depressed
                                    @click="signin"
                                >
                                    Sign In
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                       
                    </v-col>
                </v-row>
                
            </v-container>
        </v-main>
    </v-app>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
export default {
    data: () => ({
        show: false,
        email: "",
        password: "",
    }),

    computed: {
        ...mapGetters({
            authenticated: 'auth/getAuthenticated',
            patientId: 'auth/getPatientId',
        })
    },

    methods: {
        ...mapActions({
            logIn: 'auth/logIn',
            getPatient: 'auth/getPatient',
            getDoctor: 'auth/getDoctor',
        }),

        ...mapMutations({
            setCredentials: 'auth/setCredentials',
            setAuthenticated: 'auth/setAuthenticated',
            setUserId: 'auth/setUserId',
            setUser: 'auth/setUser',
            setUserEmail: 'auth/setUserEmail',
            setDoctor: 'auth/setDoctor',
            setDoctorId: 'auth/setDoctorId',
            setPatientId: 'auth/setPatientId',
        }),

        back ()
        {
            this.$router.replace('/')
        },

        signup ()
        {
            this.$router.replace('/signup')
        },

        keyCheck ({ keyCode }) {
            if(keyCode == 13){
                this.signin();
            }
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
                    // console.log(`User ID: ${data.data[0].user_id}`);
                    this.setUserId(data.data[0].user_id);
                    sessionStorage.setItem('UserId', data.data[0].user_id);
                    this.setUserEmail(this.email);
                    sessionStorage.setItem('UserEmail', this.email);
                    this.setAuthenticated(true);
                    let dataUser = null;
                    console.log(`RoleID: ${data.data[0].role_id}`)
                    if(data.data[0].role_id == 2){
                        //doctor
                        const { data } = await this.getDoctor();
                        // console.log(data);
                        this.setUser(JSON.stringify(data[0]));
                        sessionStorage.setItem('User', JSON.stringify(data[0]));
                        sessionStorage.setItem('Authenticated', "true");
                        this.setDoctor(true);
                        this.setDoctorId(data[0].id);
                        sessionStorage.setItem('DoctorId',data[0].id )
                        sessionStorage.setItem('Doctor', true);
                        this.$router.replace('/home')
                    } 
                    else{
                        const { data } = await this.getPatient();
                        dataUser = data;
                        this.setUser(JSON.stringify(dataUser[0]));
                        sessionStorage.setItem('User', JSON.stringify(dataUser[0]));
                        sessionStorage.setItem('Authenticated', "true");
                        this.setPatientId(dataUser[0].id);
                        sessionStorage.setItem('PatientId',dataUser[0].id )
                        this.$router.replace('/home')
                    } 
                    
                    // console.log(`Authenticated: ${this.authenticated}`);
                    
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