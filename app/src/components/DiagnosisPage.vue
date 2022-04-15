<template>
    <v-app>
        <top-navigation></top-navigation>
        <layout-page>
            <v-container>
                <v-row class="text-center">
                    <v-col>
                        <h1>Diagnosis</h1>
                    </v-col>
                </v-row>  
                <v-row>
                    <v-col>
                        <v-card
                            width="500"
                            class="mx-auto"
                        >
                        <v-text-field
                            v-model="searchPhrase"
                            placeholder="Search for diagnosis"
                            outlined
                            hide-details=""
                            clearable
                            prepend-inner-icon="mdi-magnify"
                            @keydown="keyCheck"                        
                        ></v-text-field>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row v-if="results.length > 0">
                    <v-col>
                        <v-expansion-panels multiple>
                            <v-expansion-panel 
                                v-for="(result, i) in results"
                                :key="i"
                            >
                                <v-expansion-panel-header 
                                    class=""
                                >
                                    {{ result.diagnosis }}
                                </v-expansion-panel-header>
                                <v-expansion-panel-content>
                                    <v-list>
                                        <v-list-item>
                                            <v-list-item-content>
                                                <v-list-item-title class="primary--text">Description</v-list-item-title>
                                                <div>{{ result.description }}</div>
                                            </v-list-item-content>
                                        </v-list-item>

                                        <v-list-item>
                                            <v-list-item-content>
                                                <v-list-item-title class="primary--text">Symptoms</v-list-item-title>
                                                <div>{{ result.symptoms }}</div>
                                            </v-list-item-content>
                                        </v-list-item>

                                        <v-list-item>
                                            <v-list-item-content>
                                                <v-list-item-title class="primary--text">Treatments</v-list-item-title>
                                            </v-list-item-content>
                                        </v-list-item>    
                                    </v-list>

                                    <v-list v-if="result.treatments">
                                        <template v-for="(treatment,index) in result.treatments">
                                            <v-list-item :key="treatment.id">
                                                <v-list-item-avatar>
                                                    <v-icon
                                                        class="primary"
                                                        dark
                                                    >
                                                        mdi-medical-bag
                                                    </v-icon>
                                                </v-list-item-avatar>
                                                <v-list-item-content>
                                                    <v-list-item-title v-text="treatment.description">

                                                    </v-list-item-title>
                                                </v-list-item-content>
                                            </v-list-item>
                                            <v-divider
                                                v-if="index < result.treatments.length -1"
                                                :key="index"
                                            ></v-divider>
                                        </template>
                                    </v-list>                                
                                </v-expansion-panel-content>
                            </v-expansion-panel>
                        </v-expansion-panels>
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
import { mapActions, mapMutations } from 'vuex';
export default {
    components: {
        TopNavigation,
        LayoutPage,
    },

    data: () => ({
        overlay: false,
        searchPhrase: null,
        results: [],
    }),

    methods: {
        ...mapMutations({
            setSearchPhrase: 'diagnosis/setSearchPhrase',
        }),

        ...mapActions({
            getDiagnosis: 'diagnosis/getDiagnosis',
        }),

        keyCheck ({ keyCode }) {
            if(keyCode == 13){
                this.search();
                this.overlay = true;
                setTimeout(() => {
                    this.overlay = false;
                }, 2000);
            }
        },

        async search () {
            console.log("searching...")
            console.log(this.searchPhrase);
            this.setSearchPhrase(this.searchPhrase);
            try {
                const { data } = await this.getDiagnosis();
                this.results = data;
                console.log(this.results);
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
            }
        }
    }
}
</script>