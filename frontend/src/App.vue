<template lang="pug">
  .text
  | ああああああああああああああああああああああああ
  .global_natvigation 
    GlobalNavigation
  .main
    img(:alt="Vue logo", :src="./assets/logo.png")
    HelloWorld(:msg="ようこそ")
</template>

<script>
import GlobalNavigation from "./components/global/GlobalNavigation.vue";
import HelloWorld from "./components/HelloWorld.vue";

export default {
  name: "App",
  components: {
    GlobalNavigation,
    HelloWorld,
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
