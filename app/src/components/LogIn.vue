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
import { mapActions, mapMutations } from 'vuex'
export default {
    data: () => ({
        show: false,
        email: "",
        password: "",
    }),

    methods: {
        ...mapActions({
            logIn: 'auth/logIn'
        }),

        ...mapMutations({
            setCredentials: 'auth/setCredentials',
            setAuthenticated: 'auth/setAuthenticated',
        }),

        back ()
        {
            this.$router.replace('/')
        },

        signup ()
        {
            this.$router.replace('/signup')
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
                    const response = await this.logIn();
                    console.log(response);
                    this.setAuthenticated(true);
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