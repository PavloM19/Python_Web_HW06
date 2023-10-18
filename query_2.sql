SELECT st.surname, st.name, ROUND(AVG(g.grade), 2) AS avg_grade_subj_1
FROM students AS st
JOIN grades AS g ON st.id = g.student_id_fk
WHERE g.subject_id_fk = 1
GROUP BY st.surname, st.name
ORDER BY avg_grade_subj_1 DESC LIMIT 1;

