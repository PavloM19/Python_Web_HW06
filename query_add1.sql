SELECT st.surname, st.name, ROUND(AVG(g.grade), 2), t.surname, t.name
FROM grades AS g
JOIN students AS st ON st.id = g.student_id_fk
JOIN subjects AS s ON g.subject_id_fk = s.id
JOIN teachers AS t ON s.teacher_id_fk = t.id
WHERE st.id = 3 AND t.id = 3
GROUP BY st.surname, st.name, t.surname, t.name;