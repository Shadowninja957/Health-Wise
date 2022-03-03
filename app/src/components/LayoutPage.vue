<template>
    <v-main>
        <v-container fluid class="fill-height justify center container-background">
            <slot></slot>
        </v-container>
    </v-main>
</template>

<style scoped>
    .container-background{
        background-image: url("../assets/Vector.svg");
        background-position: center center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        filter:brightness(103%);
        position: absolute;
    }
</style>