<script setup>
import { onBeforeMount  } from 'vue';
import dayjs from 'dayjs';
import { getImage } from '@/composables/helper.js';


</script>

<template>
  <header class="header">
    <!-- 지역 -->
    <h1 class="header__title">
      <span class="material-symbols-outlined">location_on</span>서울
    </h1>
    <h2 class="header__date">{{ dayjs().format('HH:mm') }}</h2>
  </header>
  <!-- 현재 날씨 -->
  <main class="main">
    <article class="weather">
      <section class="weather__info">
        <!-- 경로 수정 -->
        <img src="@/assets/images/icons/cloudy.png" alt="" class="weather__img" />
        <h3 class="weather__temp">28</h3>
        <p class="weather__summary">대체로 맑음</p>
        <ul class="weather__moreList">
          <li class="weather__moreListItem">
            <p class="weather__subtitle">습도</p>
            <p class="weather__desc">82%</p>
          </li>
          <li class="weather__moreListItem">
            <p class="weather__subtitle">풍속</p>
            <p class="weather__desc">4.12 m/s</p>
          </li>
          <li class="weather__moreListItem">
            <p class="weather__subtitle">체감</p>
            <p class="weather__desc">7 도</p>
          </li>
        </ul>
      </section>
    </article>
  </main>
  <!-- 하단 공통 영역 -->
  <!-- <footer class="footer">
    <ul class="footer__list">
      <li class="footer__item">
        <a href="/">
          <span class="material-symbols-outlined footer__icons">home</span>
        </a>
      </li>
      <li class="footer__item">
        <a href="forecast.html">
          <span class="material-symbols-outlined footer__icons">stacked_line_chart</span>
        </a>
      </li>
      <li class="footer__item">
        <a href="search.html">
          <span class="material-symbols-outlined footer__icons">search</span>
        </a>
      </li>
    </ul>
  </footer> -->
</template>

