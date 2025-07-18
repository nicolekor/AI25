<script>
export default {
  data () {
    return {
      condition: true,
      
    };
  },
}
</script>
<template>
  <p v-show="condition"> 조건이 참이다.</p>
  <p v-show="!condition">조건이 거짓이다.</p> 
</template>
<style></style>