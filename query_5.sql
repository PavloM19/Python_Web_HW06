SELECT t.surname, t.name, s.subject
FROM teachers AS t
JOIN subjects AS s ON t.id = s.teacher_id_fk
WHERE t.id = 3;
