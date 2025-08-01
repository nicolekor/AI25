<template>
  <div>
    <h1>성적처리 프로그램</h1>

    <!-- ✅ 추가 입력 폼 -->
    <input v-model="form.student_id" placeholder="학번" />
    <input v-model="form.name" placeholder="이름" />
    <input type="number" v-model.number="form.korean" placeholder="국어" />
    <input type="number" v-model.number="form.english" placeholder="영어" />
    <input type="number" v-model.number="form.math" placeholder="수학" />
    <button @click="submitForm">학생 {{ form.id ? '수정' : '등록' }}</button>

    <hr />

    <!-- ✅ 학생 목록 -->
    <table border="1">
      <thead>
        <tr>
          <th>학번</th><th>이름</th><th>국어</th><th>영어</th><th>수학</th><th>작업</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="s in students" :key="s.id">
          <td>{{ s.student_id }}</td>
          <td>{{ s.name }}</td>
          <td>{{ s.korean }}</td>
          <td>{{ s.english }}</td>
          <td>{{ s.math }}</td>
          <td>
            <button @click="editStudent(s)">수정</button>
            <button @click="deleteStudent(s.id)">삭제</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const students = ref([])
const form = ref({
  id: null,
  student_id: '',
  name: '',
  korean: 0,
  english: 0,
  math: 0
})

const fetchStudents = async () => {
  const res = await axios.get('http://localhost:3000/students')
  students.value = res.data
}

const submitForm = async () => {
  if (form.value.id) {
    // 수정
    await axios.put(`http://localhost:3000/students/${form.value.id}`, form.value)
  } else {
    // 등록
    await axios.post('http://localhost:3000/students', form.value)
  }
  resetForm()
  fetchStudents()
}

const editStudent = (student) => {
  form.value = { ...student }
}

const deleteStudent = async (id) => {
  await axios.delete(`http://localhost:3000/students/${id}`)
  fetchStudents()
}

const resetForm = () => {
  form.value = {
    id: null,
    student_id: '',
    name: '',
    korean: 0,
    english: 0,
    math: 0
  }
}

onMounted(fetchStudents)
</script>
