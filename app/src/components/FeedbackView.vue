<template>
    <v-app>
        <top-navigation></top-navigation>
        <layout-page>          
            <v-container>
                 <v-row >
            <v-col 
                
                v-for="feedback in feedbackRecords"
                :key="feedback.id"
            >
                <feedback-card
                    v-bind:feedback="feedback"
                ></feedback-card>
            </v-col>
        </v-row>
            </v-container>
            
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
import FeedbackCard from './FeedbackViewCard.vue';
import { mapActions, mapGetters } from 'vuex';
export default {
   components: {
       TopNavigation,
       LayoutPage,
       FeedbackCard,
   },

   created: function () {
     this.initialize();  
   },

   data: () => ({
       overlay: false,
       feedbackRecords: [],
       reply: false,
   }),

   computed: {
       ...mapGetters({
           getPatient: 'auth/getPatient',
       })
   },

   methods: {
       initialize () {
           console.log('initializing feedback view...');
           this.overlay = true
           setTimeout(this.getFeedbackRecords, 2000)
       },

       ...mapActions({
           getFeedback: 'feedback/getFeedback',
       }),

       async getFeedbackRecords () {
           try {
               const { data } = await this.getFeedback();
               this.feedbackRecords = data
           } catch (error) {
               if(error.response) console.log(error.response);
               console.log(error);
           }

           this.overlay = false;
       },

       
       
   }
}
</script>