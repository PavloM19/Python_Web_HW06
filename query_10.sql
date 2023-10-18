SELECT DISTINCT s.subject, st.surname, st.name, t.surname, t.name
FROM students AS st
JOIN grades AS g ON st.id = g.student_id_fk
JOIN subjects AS s ON g.subject_id_fk = s.id
JOIN teachers AS t ON s.teacher_id_fk = t.id
WHERE st.id = 3 AND t.id = 3;