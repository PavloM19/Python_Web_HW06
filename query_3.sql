SELECT gr.name_group, s.subject, ROUND(AVG(g.grade), 2) AS avg_grade
FROM groups AS gr
JOIN students AS st ON gr.id = st.group_id_fk
JOIN grades AS g ON st.id = g.student_id_fk
JOIN subjects AS s ON g.subject_id_fk = s.id
WHERE g.subject_id_fk = 3 
GROUP BY gr.name_group, s.subject
ORDER BY avg_grade DESC;
