from flask import Flask, render_template,request

import pypyodbc as pyodbc
import pandas as pd
conn = pyodbc.connect('Driver={SQL Server};'
'Server=LAPTOP-6QGV2OPK\MSSQLSERVER01;'
'Database=university_management;'
'Trusted_Connection=yes;')
cursor = conn.cursor()

dept_df = pd.read_sql_query("SELECT * FROM Student where student_id = 'S9999'", conn)
print(dept_df)






app = Flask(__name__)





@app.route('/', methods=['GET', 'POST'])
def index():
    if(request.method == "POST"):
        student_id = request.args['student_id'],first_Name = request.args['first_Name'] ,last_Name = request.args['last_Name'],gender = request.args['gender'],email_id = request.args['email_id'],ssn = request.args['ssn'],state = request.args['state'],city = request.args['city'],zip = request.args['zip'],mobile_number = request.args['mobile_number'],date_of_birth = request.args['date_of_birth']
        query = "insert into Student (student_id, first_name, last_name, email, gender, SSN, state, city, zip, mobile_number, date_of_birth, GPA) values ({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, null)".format(student_id, first_Name, last_Name, email_id, gender, ssn, state, city, zip, mobile_number, date_of_birth)
        cursor.execute(query)
        conn.commit()
        cursor.close()
        conn.close()
        return render_template('success.html')
    return render_template('index.html')

if __name__ == '__main__':
    app.run()