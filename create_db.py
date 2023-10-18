from faker import Faker
import random
from datetime import datetime
import sqlite3


fake = Faker(['uk_UA'])

STUDENTS = 45
TEACHERS = 5
GROUPS = 3
GRADES = 20
SUBJECTS = [
    'Вища математика', 
    'Філософія', 
    'Фізика', 
    'Історія України', 
    'Ділова українська мова', 
    'Англійська мова', 
    'Архітектура', 
    'Містецтво'
    ]


def generate_phone_number():
    list_codes = ['050', '066', '095', '099', '067', '068', '096', '097', '063', '073', '093']
    phone_number = '+38' + str(random.choice(list_codes)) + str(random.randint(1000000, 9999999))    
    return phone_number

def create_fake_person(fake, span_age=(18, 30)):    
    person = dict()          
    person["surname"], person["name"] = fake.name().split()[::-1][:2]
    person["birthday"] = fake.date_of_birth(None, *span_age).strftime('%d.%m.%Y') # вік від 18 до 30 років
    person["address"] =  fake.address()
    person["phone"] = generate_phone_number()      
    return person

def generate_name_group() -> str:
    return fake.pystr_format(string_format='????-##', letters="АБВГДЕЄЖЗИІКЛМНОПРСТУФХЦЧШЩЮЯ")


# Створення таблиць в базі даних
def create_tables_db():
    with open('create_tables.sql') as file:
        sql = file.read()

    with sqlite3.connect('univer.db') as conn:
        cursor = conn.cursor()
        cursor.executescript(sql)


# Створення фейкових даних для бази даних
def generate_data():
    groups = list()
    students = list()
    teachers = list()
    subjects = list()
    grades = list()
    
    for _ in range(GROUPS):
        group = generate_name_group()
        groups.append((group,))
        
    for _ in range(STUDENTS):
        student = create_fake_person(fake)
        student["group_id"] = random.randint(1, GROUPS)
        students.append(tuple(student.values()))
        
    for _ in range(TEACHERS):
        teacher = create_fake_person(fake, (30, 60))        
        teachers.append(tuple(teacher.values()))        
        
    for subject in SUBJECTS:
        subjects.append((subject, random.randint(1, TEACHERS)))

    for _ in range(GRADES * STUDENTS):
        grade = (random.randint(2,12), fake.date_between(start_date="-45d", end_date="today").strftime('%d.%m.%Y'), random.randint(1, STUDENTS), random.randint(1, len(SUBJECTS)))
        grades.append(grade)
        
    return groups, students, teachers, subjects, grades


# Наповнення бази даних
def filling_db(groups, students, teachers, subjects, grades):
    with sqlite3.connect('univer.db') as conn:
        cursor = conn.cursor()

        to_groups = """INSERT INTO groups(name_group) VALUES (?)"""
        cursor.executemany(to_groups, groups)

        to_students = "INSERT INTO students(surname, name, birthday, address, phone, group_id_fk) VALUES (?, ?, ?, ?, ?, ?)"
        cursor.executemany(to_students, students)

        to_teachers = "INSERT INTO teachers(surname, name, birthday, address, phone) VALUES (?, ?, ?, ?, ?)"
        cursor.executemany(to_teachers, teachers)

        to_subjects = "INSERT INTO subjects(subject, teacher_id_fk) VALUES (?, ?)"
        cursor.executemany(to_subjects, subjects)

        to_grades = "INSERT INTO grades(grade, date_grade, student_id_fk, subject_id_fk) VALUES (?, ?, ?, ?)"
        cursor.executemany(to_grades, grades)

        
        conn.commit()



if __name__ == "__main__":
    create_tables_db()
    filling_db(*generate_data())
