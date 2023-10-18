SELECT st.surname, st.name, gr.name_group, s.subject, g.grade
FROM students AS st
JOIN groups AS gr ON gr.id = st.group_id_fk
JOIN grades AS g ON st.id = g.student_id_fk
JOIN subjects AS s ON g.subject_id_fk = s.id
WHERE gr.id = 1 AND s.id = 1;