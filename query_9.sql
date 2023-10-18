SELECT DISTINCT st.surname, st.name, s.subject
FROM students AS st
JOIN grades AS g ON st.id = g.student_id_fk
JOIN subjects AS s ON g.subject_id_fk = s.id
WHERE st.id = 3
ORDER BY st.surname, st.name;