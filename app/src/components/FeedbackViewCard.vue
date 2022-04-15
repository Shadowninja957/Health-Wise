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
                <v-spacer></v-spacer>
                <v-btn
                    color="primary"
                    dark
                    small
                    width="100"
                    class="mb-3"
                    rounded
                    @click="displayFeedbackReply"
                >
                    Reply
                </v-btn>
            </v-card-actions>

            <v-expansion-panels>
                <v-expansion-panel>
                    <v-expansion-panel-header>
                        <span class="font-weight-bold">Replies {{ repliesCount }} </span>
                    </v-expansion-panel-header>
                    <v-expansion-panel-content>
                        <v-divider></v-divider>
                        <v-list>
                            <v-list-item-group>
                                <template v-for="(reply, index) in feedback.replies">
                                    <v-menu 
                                        :key="reply.subject"
                                        :nudge-width="200"
                                        offset-x
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                    <v-list-item 
                                        v-bind="attrs"
                                        v-on="on"
                                    >                                        
                                        <v-list-item-avatar>
                                            <v-icon
                                                v-if="reply.doctor_id"
                                                dark
                                                class="primary"
                                            >
                                                mdi-stethoscope
                                            </v-icon>
                                            <v-icon
                                                v-else
                                                dark
                                                class="grey lighten-1"
                                            >
                                                mdi-account-circle
                                            </v-icon>
                                            
                                        </v-list-item-avatar>
                                        <v-list-item-content>
                                            <v-list-item-title></v-list-item-title>
                                            <v-list-item-subtitle>
                                                {{ reply.detail }}
                                            </v-list-item-subtitle>                                        
                                        </v-list-item-content>
                                        <v-list-item-action>
                                            <v-list-item-action-text>
                                                {{ reply.created_at }}
                                            </v-list-item-action-text>
                                        </v-list-item-action>
                                        <v-menu
                                            v-model="reply.menu"
                                            bottom
                                            
                                            transition="scale-transition"
                                        >
                                            <v-card>
                                                <v-card-text>
                                                    {{ reply.detail }}
                                                </v-card-text>
                                            </v-card>
                                        </v-menu>
                                    </v-list-item>
                                        </template>
                                        <v-card>
                                            <v-card-text>
                                                <v-avatar class="mr-2">
                                                    <v-icon
                                                        v-if="reply.doctor_id"
                                                        dark
                                                        class="primary"
                                                    >
                                                        mdi-stethoscope
                                                    </v-icon>
                                                    <v-icon
                                                        v-else
                                                        dark
                                                        class="grey lighten-1"
                                                    >
                                                        mdi-account-circle
                                                    </v-icon>
                                                    
                                                </v-avatar>
                                                {{ reply.detail }}
                                                <span
                                                    v-if="reply.doctor_id"
                                                    class="font-weight-light font-italic ml-2"
                                                >
                                                   - Dr. {{ feedback.doctor }}
                                                </span>
                                            </v-card-text>
                                        </v-card>
                                    </v-menu>    
                                    <v-divider
                                        v-if="index < replies.length - 1"
                                        :key="index"
                                    ></v-divider>
                                </template>
                            </v-list-item-group>    
                        </v-list>
                    </v-expansion-panel-content>
                </v-expansion-panel>
            </v-expansion-panels>

            <v-overlay
                :value="overlay"
                absolute
            >
                <v-progress-circular
                    indeterminate
                    size="64"
                    color="primary"
                ></v-progress-circular>
            </v-overlay>

        </v-card>
        <v-card 
            v-if="reply"
            width="350"
        >
            <v-card-text class="pb-0">
                <v-row>
                    <v-col>
                        <v-textarea
                            v-model="feedbackReply.detail"
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
                    @click="sendReply"
                >
                    <v-icon>mdi-send</v-icon>
                </v-btn>
            </v-card-actions>   
        </v-card>
        
    </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
export default {
    props: {
        feedback: {
            type: Object,
            default: function () {
                return {}
            }
        }
    },

    data: function (){
        return {
            reply: false,
            replies: [],
            feedbackReply: {
                detail: null,
            },
            menu: false,
            overlay: false,
        }
    },

    created: function () {
        this.initialize();
    },

    computed: {
        repliesCount: function () {
            if(this.replies)
            return this.replies.length;
            else return 0;
        },

        ...mapGetters({
            patientId: 'auth/getPatientId',
            doctorId: 'auth/getDoctorId',
        })
    },

    methods: {
        ...mapActions({
            postFeedbackReply: 'feedback/postFeedbackReply',
        }),

        ...mapMutations({
            setFeedbackReply: 'feedback/setFeedbackReply',
        }),

        initialize () {
            this.replies = this.feedback.replies;
            this.feedbackReply.patient_feedback_id = this.feedback.id;
            this.feedbackReply.patient_id = this.patientId;
            this.feedbackReply.doctor_id = this.doctorId;
        },

        displayFeedbackReply () {
           this.reply = true;
        },

        cancelReply () {
            this.reply = false;
        },

        async sendReply () {
            this.overlay = true;
            this.reply = false;
            this.setFeedbackReply(this.feedbackReply);
            try {
                const response = await this.postFeedbackReply();
                console.log(response);
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
            }
            this.$emit('refresh-feedback');
            setTimeout(()=>{
                this.overlay = false;
            }, 2000)
        },

        showReplyDetail (reply) {
            // console.log(reply);
            console.log("show reply detail");            
            let index = this.replies.indexOf(reply);
            // console.log(index);
            this.replies[index].menu = true;
            // console.log(this.replies);
            this.menu = true;
        }
    }
}
</script>