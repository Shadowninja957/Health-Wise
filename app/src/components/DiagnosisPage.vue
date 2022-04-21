<template>
    <v-app>
        <top-navigation></top-navigation>
        <layout-page>
            <v-container>
                <v-row class="text-center primary--text">
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
                            @click:clear="clear"                        
                        ></v-text-field>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row v-if="results.length > 0">
                    <v-col>
                        <v-card 
                            max-width="900" 
                            class="mx-auto px-3"
                            rounded="lg"
                            outlined
                            flat
                        >
                            <v-card-title 
                                v-if="results[0].id== -1"
                                class="mx-auto"
                            >
                                <span class="mx-auto">{{ results[0].diagnosis }}</span>
                            </v-card-title>
                            <v-expansion-panels 
                                v-else
                                flat
                            >
                                <v-expansion-panel 
                                    v-for="(result, i) in results"
                                    :key="i"
                                    class="mb-3"
                                    :style="i < results.length -1 ? 'border-bottom: 1px solid gainsboro' : ''"
                                >
                                    <v-expansion-panel-header >
                                        <v-list>
                                            <v-list-item two-line>
                                                <v-list-item-content>
                                                    <v-list-item-title 
                                                        v-text="result.diagnosis"
                                                        class="text-h5 primary--text"
                                                    ></v-list-item-title>
                                                    <!-- <v-list-item-subtitle
                                                        v-text="result.description"
                                                        class="font-weight-light"
                                                    ></v-list-item-subtitle> -->
                                                </v-list-item-content>
                                                <v-list-item-action></v-list-item-action>
                                            </v-list-item>
                                        </v-list>
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
                        </v-card>
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
        noResult: {
            diagnosis: "No Results Found",
            id: -1,
        }
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
            this.results = [];
            console.log(this.searchPhrase);
            this.setSearchPhrase(this.searchPhrase);
            try {
                const { data } = await this.getDiagnosis();
                this.results.push(this.noResult);
                if(data.length > 0){
                    this.results = data;
                }
                
                console.log(this.results);
            } catch (error) {
                if(error.response) console.log(error.response);
                else console.log(error);
            }
        },

        clear () {
            this.results = [];
        }
    }
}
</script>