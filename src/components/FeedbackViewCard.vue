<template>
    <div>
        <v-card width="350" >
            <v-system-bar 
                color="primary"
                dark
            >
                Feedback
            </v-system-bar>
            
            <v-card-text>
                <div class="text-h6">{{ feedback.doctor }}</div>
                <div>Contact: {{ feedback.contact }}</div>
                <div>Email: {{ feedback.email }}</div>
                <div class="mt-3">Problem: {{ feedback.subject }}</div>
                <div class="mt-2">Problem Description: </div>
                <div>{{ feedback.description }}</div>
                
            </v-card-text>
            <v-card-actions >
                <v-btn text>
                    <span class="font-weight-bold">Replies 0</span>
                </v-btn>
                
                <v-spacer></v-spacer>
                <v-btn
                    color="primary"
                    dark
                    small
                    width="100"
                    class="mb-3"
                    rounded
                    @click="feedbackReply"
                >
                    Reply
                </v-btn>

            </v-card-actions>
        </v-card>
        <v-card 
            v-if="reply"
            width="350"
        >
            <v-card-text class="pb-0">
                <v-row>
                    <v-col>
                        <v-textarea
                            rows="2"
                            outlined
                            hide-details=""
                        ></v-textarea>
                    </v-col>
                </v-row>
            </v-card-text> 
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn 
                    text
                    @click="cancelReply"
                >
                    Cancel
                </v-btn>
                <v-btn
                    icon
                    color="primary"
                >
                    <v-icon>mdi-send</v-icon>
                </v-btn>
            </v-card-actions>   
        </v-card>
    </div>
</template>

<script>
export default {
    props: {
        feedback: Object,
    },

    data: () => ({
        reply: false,
    }),

    methods: {
        feedbackReply () {
           this.reply = true;
       },

       cancelReply () {
           this.reply = false;
       }
    }
}
</script>