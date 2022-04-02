<template>
    
        <v-dialog
            v-model="dialog"
            width="800"
        >
            <template v-slot:activator="{ on, attrs }">
                <v-btn
                    color="primary"
                    dark
                    small
                    :block="block"
                    class="ml-0"
                    rounded
                    v-bind="attrs"
                    v-on="on"
                    :disabled="disabled"                    
                >
                    {{ buttonText }}
                </v-btn>
            </template>
            <v-card>
                <GmapMap
                    :center='location'
                    :zoom='12'
                    style='width:100%; height:500px'
                >
                    <GmapMarker
                        :key="index"
                        v-for="(m, index) in markers"
                        :position="m.position"
                        @click="center=m.position"
                    ></GmapMarker>
                </GmapMap>
            </v-card>
        </v-dialog> 
    
</template>

<script>
export default {
    name: 'GoogleMap',
    props: {
        buttonText: String,
        block: Boolean,
        disabled: Boolean,
    },

    data: () => ({
        location: { lat:10.630718186341424, lng:-61.427479431019876},
        dialog: false,
        currentPlace: null,
        markers: [],
        places: []
    }),

    watch: {
        dialog: function (val) {
            if(val) this.addMarker();
        }
    },
    
    methods: {
        addMarker () {
            if(this.location){
                const marker = {
                    lat: this.location.lat,
                    lng: this.location.lng
                }
                this.markers.push({ 
                    position: marker
                })
                
            }
        }
    }
}
</script>