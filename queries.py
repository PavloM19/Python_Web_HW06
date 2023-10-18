import sqlite3


def execute_query(sql_file: str) -> list:
    with open(sql_file, 'r') as file:
        sql = file.read()
        
    with sqlite3.connect('univer.db') as conn:
        cursor = conn.cursor()
        cursor.execute(sql)
        return cursor.fetchall()
    
if __name__ == "__main__":
    for i in range(1, 10+1):
        sql_file = f'query_{str(i)}.sql'
        print('\n-----', sql_file, '----->\n', execute_query(sql_file))
    
    sql_file = f'query_add1.sql'
    print('\n-----', sql_file, '----->\n', execute_query(sql_file))