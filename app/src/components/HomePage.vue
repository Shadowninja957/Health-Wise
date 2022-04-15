<template>
    <v-app>
        <top-navigation></top-navigation>
        <v-main>
        <v-container>
            <v-row>

                <v-col cols="4" class="mb-4 d-flex flex-column justify-center align-left">
                    <h1 class="display-1 font-weight-bold mb-5">
                    Virtual healthcare for you
                    </h1>

                    <p class="subheading font-weight-light">
                    Health Wise provides progressive, and general 
                    healthcare, accessible on mobile and online 
                    for everyone
                    </p>

                
                </v-col>

                <v-col cols="8">
                    <v-img
                    :src="require('../assets/landing-page-illustration.svg')"
                    class="my-3"
                    contain
                    height="500"
                    />
                </v-col>
            </v-row>
        </v-container>
        </v-main>
    </v-app>
</template>

<script>
import TopNavigation from './TopNavigation.vue';

export default {
    components: {
        TopNavigation,
        
    },
    data: () => ({
        //

    }),

    methods: {
       //
    }
}
</script>

