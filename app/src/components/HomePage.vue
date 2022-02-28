<template>
    <v-app>
        <v-app-bar
        app
        color="white"
        
        flat
        >
        <div class="d-flex align-center font-weight-bold">
            <v-btn 
                text
                @click="landingPage"
            >Health Wise</v-btn>
        </div>

        <v-spacer></v-spacer>
        <v-btn
            class="mr-2"
            text
            color="primary"
        >
            Home
        </v-btn>
        <v-btn
            text
        >
            Find a doctor
        </v-btn>
        <v-btn
            text
        >
            Diagnosis
        </v-btn>
        <v-btn
            text
        >
            Appointment
        </v-btn>
        <v-btn
            text
        >
            Feedback Form
        </v-btn>
        
        </v-app-bar>

        <v-main>
            <v-container fluid class="fill-height justify center container-background">
                <v-row class="text-center">
                    <v-col>
                        <v-card 
                            max-width="300"
                            flat                            
                            class="mx-auto"
                        >
                            <v-card-title class="justify-center font-weight-bold">Diagnosis</v-card-title>
                            <v-card-text>
                                <v-autocomplete
                                    v-model="symptom"
                                    :items="symptoms"
                                    chips
                                    multiple
                                    outlined
                                    dense
                                    item-text="detail"
                                    item-value="id"
                                ></v-autocomplete>
                            </v-card-text>
                            <v-card-actions>
                                <v-btn color="primary" depressed block>
                                    Diagnose
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
export default {
    data: () => ({
        symptom: "",
        symptoms: [
            {id: 1, detail: "Itchy Skin"},
            {id: 2, detail: "Hives"},
            {id: 3, detail: "Red Spots"},
        ]

    }),

    methods: {
        landingPage () 
        {
            console.log("landing page")
            this.$router.replace('/')
        }
    }
}
</script>

<style scoped>
    .container-background{
        background-image: url("../assets/Vector.svg");
        background-position: center center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        filter:brightness(103%);
        position: absolute;
    }

    ::v-deep .theme--light.v-card{
        background-color:transparent;
    }
</style>