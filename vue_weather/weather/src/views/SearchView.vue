<script setup></script>

<template>
  <main class="weather-city">
    <!-- 검색 영역 -->
    <section class="weather__search">
      <input
        type="text"
        class="weather__searchBar"
        placeholder="검색할 지역을 입력해 주세요."
      />
    </section>

    <!-- 검색 데이터가 있으면 -->
    <section class="weather__city">
      <div class="weather__cityLeft">
        <strong class="weather__cityTmp">25°</strong>
        <p class="weather__cityTmpMore">H: 27 / L: 19</p>
        <p>Montréal, Canada</p>
      </div>
      <div class="weather__cityRight">
        <img
          src="@/assets/images/icons/cloudy.png"  
          alt=""
          class="weather__cityImg"
        />
      </div>
      <span class="material-symbols-outlined weather__cancel">cancel</span>
    </section>

    <!-- 검색 데이터가 없으면 -->
    <section class="no-data" style="display: none">
      <p>검색한 지역이 없습니다.</p>
    </section>
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

