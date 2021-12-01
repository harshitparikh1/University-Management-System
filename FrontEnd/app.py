from flask import Flask, render_template,request

import pypyodbc as pyodbc
import pandas as pd
<<<<<<< Updated upstream
# Pratik connection
# conn = pyodbc.connect('Driver={SQL Server};'
# 'Server=LAPTOP-6QGV2OPK\MSSQLSERVER01;'
# 'Database=university_management;'
# 'Trusted_Connection=yes;')

# Harshit connection
=======
from werkzeug.utils import redirect
>>>>>>> Stashed changes
conn = pyodbc.connect('Driver={SQL Server};'
'Server=LAPTOP-07JMFG9U;'
'Database=university_management;'
'Trusted_Connection=yes;')

cursor = conn.cursor()

dept_df = pd.read_sql_query("SELECT * FROM Student where student_id = 'S9999'", conn)
print(dept_df)






app = Flask(__name__)


#insert into Student (student_id, first_name, last_name, email, gender, SSN, state, city, zip, mobile_number, date_of_birth, GPA) values ('S1', 'Frederich', 'Reiling', 'freiling0@techcrunch.com', 'M', 775867945, 'Alabama', 'Mobile', 77363, '2513338951', '09/26/2001', null);


@app.route('/insertData', methods = ['POST'])
def insertData():
    student_id = request.form['student_ID']
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
    cursor.close()
    conn.close()
    print(date_of_birth)
    return 'Success'


@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run()