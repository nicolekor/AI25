const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// ✅ DB 연결
const db = mysql.createConnection({
  host: 'localhost',
  user: 'webuser',
  password: '54321',
  database: 'webdb'
});

// ✅ 전체 학생 조회 (Read)
app.get('/students', (req, res) => {
  db.query('SELECT * FROM students', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

// ✅ 학생 추가 (Create)
app.post('/students', (req, res) => {
  const { student_id, name, korean, english, math } = req.body;
  db.query(
    'INSERT INTO students (student_id, name, korean, english, math) VALUES (?, ?, ?, ?, ?)',
    [student_id, name, korean, english, math],
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.sendStatus(201);
    }
  );
});

// ✅ 학생 정보 수정 (Update)
app.put('/students/:id', (req, res) => {
  const { student_id, name, korean, english, math } = req.body;
  db.query(
    'UPDATE students SET student_id=?, name=?, korean=?, english=?, math=? WHERE id=?',
    [student_id, name, korean, english, math, req.params.id],
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.sendStatus(200);
    }
  );
});

// ✅ 학생 삭제 (Delete)
app.delete('/students/:id', (req, res) => {
  db.query('DELETE FROM students WHERE id = ?', [req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err });
    res.sendStatus(200);
  });
});

app.listen(3000, () => {
  console.log('서버 실행 중 http://localhost:3000');
});
