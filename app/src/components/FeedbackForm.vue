<template>
    <v-app>
        <top-navigation></top-navigation>
        <layout-page>
            <v-card 
                class="mx-auto"
                width="400"
            >
                <v-card-title class="d-flex justify-center">
                    Feedback Form
                </v-card-title>
                <v-card-text>
                    <v-alert
                        v-if="errorMessage"
                        type="error"
                        text
                        outlined
                    >
                        {{ errorMessage }}
                    </v-alert>
                    <v-alert
                        v-if="successMessage"
                        type="success"
                        text
                        outlined
                    >
                        {{ successMessage }}
                    </v-alert>
                </v-card-text>
                <v-container>
                    <v-form
                        v-model="valid" 
                        ref="form" 
                        lazy-validation
                    >
                        <v-row>
                            <v-col>
                                <v-text-field
                                    v-model="feedback.name"
                                    label="Patient Name:"
                                    outlined
                                    clearable
                                    hide-details
                                    :rules="[ v => !!v || 'Item is required']"
                                ></v-text-field>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <v-text-field
                                    v-model="feedback.email"
                                    label="Patient E-mail:"
                                    outlined
                                    clearable
                                    hide-details
                                    :rules="[ v => !!v || 'Item is required']"
                                ></v-text-field>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <v-text-field
                                    v-model="feedback.contact"
                                    label="Patient Contact #:"
                                    outlined
                                    clearable
                                    hide-details
                                    :rules="[ v => !!v || 'Item is required']"
                                ></v-text-field>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <v-select
                                    v-model="feedback.doctor"
                                    label="Doctor:"
                                    :items="doctors"
                                    item-text="name"
                                    item-value="id"
                                    outlined
                                    clearable
                                    hide-details
                                    :rules="[ v => !!v || 'Item is required']"
                                ></v-select>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <v-text-field
                                    v-model="feedback.subject"
                                    label="Problem Subject"
                                    outlined
                                    clearable
                                    hide-details
                                    :rules="[ v => !!v || 'Item is required']"
                                ></v-text-field>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <v-textarea
                                    v-model="feedback.description"
                                    label="Problem Description"
                                    outlined
                                    clearable
                                    hide-details
                                    :rules="[ v => !!v || 'Item is required']"
                                    rows="3"
                                ></v-textarea>
                            </v-col>
                        </v-row>
                    </v-form>
                </v-container>
                <v-card-actions class="mb-2">
                    <v-btn
                        block
                        color="primary"
                        @click="validate"
                    >
                        Submit
                    </v-btn>
                </v-card-actions>
            </v-card>

            
        </layout-page>
        <v-overlay
            :value="overlay"
        >
            <v-progress-circular
                indeterminate
                size="64"
            ></v-progress-circular>
        </v-overlay>
    </v-app>
</template>

<script>
import TopNavigation from './TopNavigation.vue';
import LayoutPage from './LayoutPage.vue';
import { mapActions, mapGetters, mapMutations } from 'vuex';
export default {
   components: {
       TopNavigation,
       LayoutPage,
   },

   created: function () {
     this.initialize();  
   },

   data: () => ({
       feedback: {
           patient_id: "",
           name: "",
           email: "",
           contact: "",
           doctor: "",
           subject: "",
           description: ""
       },
       errorMessage: null,
       successMessage: null,
       valid: true,
       overlay: false,
       doctors: [],
   }),

   computed: {
       ...mapGetters({
           getUser: 'auth/getUser',
           userEmail: 'auth/getUserEmail',
       })
   },

   methods: {
       async initialize () {
           console.log('initializing feedback form...');
           this.setTab(4)
           this.overlay = true;
           let user = JSON.parse(this.getUser);
        //    console.log(user);
           this.feedback.name = user.first_name + " " + user.last_name;
           this.feedback.patient_id = user.id;
           this.feedback.email = this.userEmail;
           try {
               const { data } = await this.getDoctors();
               this.doctors = data;
           } catch (error) {    
               if(error.response) console.log(error.response);
               else console.log(error);
           }
           this.overlay = false;
       },

       ...mapMutations({
           setFeedback: 'feedback/setFeedback',
           setTab: 'navigation/setTab',
       }),

       ...mapActions({
           postFeedback: 'feedback/postFeedback',
           getDoctors: 'doctor/getDoctors',
       }),

       validate () {
           let formHasErrors = false;
           Object.keys(this.feedback).forEach(key => {
               if(!this.feedback[key]) formHasErrors = true;
           })
           
           if(formHasErrors){
               this.errorMessage = "Please fill in the missing fields."
               this.$refs.form.validate();
               return
           }

           this.errorMessage = null;
           this.overlay = true;
           setTimeout(() => {
               this.submitFeedBack();
           }, 2000);

           console.log(`Form has errors: ${formHasErrors}`);
       },

       async submitFeedBack () {
           console.log('posting feedback');
            try {
                this.setFeedback(this.feedback);
                const response = await this.postFeedback();
                if(response.data.message){
                    this.successMessage = response.data.message
                }
                console.log(response); 
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
                this.errorMessage = "Error occured feedback not submitted."
            }
            this.overlay = false;
       }

       
   }
}
</script>