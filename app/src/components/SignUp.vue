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
                                        @click="signup"
                                    >
                                        Sign Up
                                    </v-btn>
                                </v-col>    
                            </v-row>
                        </v-card>
                       
                    </v-col>
                </v-row>
                
            </v-container>
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
    }),

    methods: {
        ...mapActions({
            newUser: 'auth/signUp',
        }),

        ...mapMutations({
            setCredentials: 'auth/setCredentials',
            setAuthenticated: 'auth/setAuthenticated',
        }),

        back ()
        {
            this.$router.replace('/')
        },

        async signup ()
        {
            console.log(`Email: ${this.email} Password: ${this.password}`);
            if(this.email && this.password)
            {
                this.setCredentials({
                    user_name: this.email,
                    password: this.password,
                    role_id: 1
                })
                try {
                    const response = await this.newUser();
                    this.setAuthenticated(true);
                    this.$router.replace('/home')
                    console.log(response);
                } catch (error) {
                    if(error.response) console.log(error.response)
                    else console.log(error)
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