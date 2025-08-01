// src/router/index.js
import { createRouter, createWebHistory } from 'vue-router'

// 라우터가 렌더링할 페이지 컴포넌트는 나중에 추가하면 됨
const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/StudentView.vue')  // 예: 학생 목록 및 성적 그래프 화면
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('@/views/AboutView.vue') // 추가 페이지 예시
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
