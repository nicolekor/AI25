<script setup></script>
<template>
    <footer class="footer">
        <ul class="footer__list">
            <li class="footer__item">
                <RouterLink to="/">
                    <span class="material-symbols-outlined footer__icons">home</span>
                </RouterLink>
            </li>
            <li class="footer__item">
                <RouterLink to="/forecast">
                    <span class="material-symbols-outlined footer__icons">stacked_line_chart</span>
                </RouterLink>
            </li>
            <li class="footer__item">
                <RouterLink to="/search">
                    <span class="material-symbols-outlined footer__icons">search</span>
                </RouterLink>
            </li>
        </ul>
    </footer>
</template>