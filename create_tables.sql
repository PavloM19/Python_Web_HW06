-- Table groups
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name_group CHAR(8) UNIQUE NOT NULL
);


-- Table students
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    surname CHAR(20) NOT NULL,
    name CHAR(20),    
    birthday CHAR(10),
    address VARCHAR(255),
    phone CHAR(13),
    group_id_fk INTEGER,
    FOREIGN KEY (group_id_fk) REFERENCES groups (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Table teachers
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    surname CHAR(20) NOT NULL,
    name CHAR(20),
    birthday CHAR(10),
    address VARCHAR(255),
    phone CHAR(13)   
);


-- Table subjects
DROP TABLE IF EXISTS subjects;
CREATE TABLE subjects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject VARCHAR(50) NOT NULL,
    teacher_id_fk INTEGER,
    FOREIGN KEY (teacher_id_fk) REFERENCES teachers (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


--Table grades
DROP TABLE IF EXISTS grades;
CREATE TABLE grades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    grade TINYINT UNSIGNED NOT NULL,
    date_grade DATE DEFAULT CURRENT_DATE,    
    student_id_fk INTEGER,    
    subject_id_fk INTEGER, 
    FOREIGN KEY (student_id_fk) REFERENCES students (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (subject_id_fk) REFERENCES subjects (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


