SELECT st.surname, st.name, ROUND(AVG(g.grade), 2) AS avg_grade
FROM students AS st
JOIN grades AS g ON st.id = g.student_id_fk
GROUP BY st.surname, st.name
ORDER BY avg_grade DESC LIMIT 5;
