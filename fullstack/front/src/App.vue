<!-- src/App.vue -->
<template>
  <div id="app">
    <h1>성적처리 프로그램</h1>
    <router-view /> <!-- 페이지 라우팅 영역 -->
  </div>
</template>

<script setup>
// 컴포넌트 없이 깔끔한 기본 구조
</script>

<style scoped>
#app {
  max-width: 800px;
  margin: auto;
  padding: 20px;
  font-family: 'Noto Sans KR', sans-serif;
}
</style>
