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
                    v-on:refresh-feedback="getFeedbackRecords"
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
import { mapActions, mapGetters, mapMutations } from 'vuex';
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
           this.setTab(4);
           this.overlay = true
           setTimeout(this.getFeedbackRecords, 2000)
       },

       ...mapActions({
           getFeedback: 'feedback/getFeedback',
       }),

       ...mapMutations({
           setTab: 'navigation/setTab',
           setFeedbackSelected: 'feedback/setFeedbackSelected',
       }),

       async getFeedbackRecords () {
           console.log('getting feedback...')
           try {
               const { data } = await this.getFeedback();
            //    console.log(data);
               this.feedbackRecords = data;
           } catch (error) {
               if(error.response) console.log(error.response);
               console.log(error);
           }

           this.overlay = false;
       },

       async feedbackReplies () {
           try {
               const { data } = await this.getFeedbackReplies();
               return data;
           } catch (error) {
               if(error.response) console.log(error.response);
               console.log(error);
           }
           
       }

       
       
   }
}
</script>