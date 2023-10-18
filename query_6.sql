SELECT st.surname, st.name, gr.name_group
FROM students AS st
JOIN groups AS gr ON gr.id = st.group_id_fk
WHERE gr.id = 1;