from flask import Flask, render_template,request

import pypyodbc as pyodbc
import pandas as pd

#Harshit's Connection
conn = pyodbc.connect('Driver={SQL Server};'
'Server=LAPTOP-07JMFG9U;'
'Database=university_management;'
'Trusted_Connection=yes;')

from werkzeug.utils import redirect

# conn = pyodbc.connect('Driver={SQL Server};'
# 'Server=LAPTOP-6QGV2OPK\MSSQLSERVER01;'
# 'Database=university_management;'
# 'Trusted_Connection=yes;')
cursor = conn.cursor()

dept_df = pd.read_sql_query("SELECT * FROM Student", conn)
df_html = dept_df.to_html()
# print(dept_df)




app = Flask(__name__)


#insert into Student (student_id, first_name, last_name, email, gender, SSN, state, city, zip, mobile_number, date_of_birth, GPA) values ('S1', 'Frederich', 'Reiling', 'freiling0@techcrunch.com', 'M', 775867945, 'Alabama', 'Mobile', 77363, '2513338951', '09/26/2001', null);


def getStudentId(conn):
	student_id_df = pd.read_sql_query('select student_id from student', conn);
	new_student_id = 'S' + str(len(student_id_df) + 1)
	return new_student_id



@app.route('/insertData', methods = ['POST'])
def insertData():
    student_id = getStudentId(conn)
    first_Name = request.form['first_Name'] 
    last_Name = request.form['last_Name']  
    gender = request.form['gender']
    email_id = request.form['email_id']
    ssn = request.form['ssn']
    state = request.form['state']
    city = request.form['city']
    zip = request.form['zip']
    mobile_number = request.form['mobile_number']
    date_of_birth = request.form['date_of_birth']

    query = "insert into Student (student_id, first_name, last_name, email, gender, SSN, state, city, zip, mobile_number, date_of_birth) values ('{}', '{}', '{}', '{}', '{}', {}, '{}', '{}', {}, '{}', '{}')".format(student_id, first_Name, last_Name, email_id, gender, ssn, state, city, zip, mobile_number, date_of_birth)
    print(query)
    cursor.execute(query)
    conn.commit()
    # cursor.close()
    # conn.close()
    print(date_of_birth)
    return 'Success'



@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@app.route('/table')
def display_table():
    return render_template('success.html', table_html = df_html)



if __name__ == '__main__':
    app.run()