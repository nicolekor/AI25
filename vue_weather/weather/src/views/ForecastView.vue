<script setup></script>

<template>
  <article class="forecast">
    <!-- 시간별 예보 -->
    <section class="forecast_today">
      <strong class="forecast__title">시간별</strong>
      <ul class="week__list">
        <!-- 시간별 예보 상세 아이템 -->
        <li class="week__list_item">
          <span>9시</span>
          // 경로 수정
          <img src="@/assets/images/icons/hail.png" alt="" class="week_icons" />
          <span>18°</span>
        </li>
      </ul>
    </section>
    <!-- 중기 예보 -->
    <section class="forecast_week">
      <strong class="forecast__title">중기 예보</strong>
      <ul class="forecast__weekList">
        <!-- 중기 예보 상세 아이템 -->
        <li class="forecast__weekListItem">
          <div class="forecast__itemLeft">
            <strong class="forecast__day">월요일</strong>
            <span class="forecast__date">2024.07.01</span>
          </div>
          <div class="forecast__itemMiddle">
            <strong class="forecast__tmp">32°</strong>
          </div>
          <div class="forecast__itemRight">
            <img
              src="@/assets/images/icons/hail.png"  
              alt=""
              class="forecast__weekListImg"
            />
          </div>
        </li>
      </ul>
    </section>
  </article>
  <!-- 하단 공통 영역 -->
  <!-- <footer class="footer">
    <ul class="footer__list">
      <li class="footer__item">
        <a href="/">
          <span class="material-symbols-outlined footer__icons">home</span>
        </a>
      </li>
      <li>
        <a href="forecast.html">
          <span class="material-symbols-outlined footer__icons">stacked_line_chart</span>
        </a>
      </li>
      <li>
        <a href="search.html">
          <span class="material-symbols-outlined footer__icons">search</span>
        </a>
      </li>
    </ul>
  </footer> -->
</template>

