SELECT t.surname, t.name, ROUND(AVG(g.grade), 2)
FROM teachers AS t
JOIN subjects AS s ON t.id = s.teacher_id_fk
JOIN grades AS g ON s.id = g.subject_id_fk
WHERE t.id = 4
GROUP BY t.surname, t.name;