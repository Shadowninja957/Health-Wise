<template>
    <v-app>
        <top-navigation></top-navigation>

        <layout-page>
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
        </layout-page>   
    </v-app>
</template>

<script>
import TopNavigation from './TopNavigation.vue';
import LayoutPage from './LayoutPage.vue';
export default {
    components: {
        TopNavigation,
        LayoutPage,
    },
    data: () => ({
        symptom: "",
        symptoms: [
            {id: 1, detail: "Itchy Skin"},
            {id: 2, detail: "Hives"},
            {id: 3, detail: "Red Spots"},
        ]

    }),

    methods: {
       //
    }
}
</script>

