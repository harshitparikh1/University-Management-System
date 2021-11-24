USE MASTER
GO

DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('university_management')

EXEC(@kill);

DROP DATABASE IF EXISTS university_management
GO
CREATE DATABASE [university_management]
go
USE [university_management]
GO

create table COLLEGE (
	college_id VARCHAR(10),
	city VARCHAR(50),
	address VARCHAR(50),
	state VARCHAR(50),
	college_name VARCHAR(50)
	constraint PK_College PRIMARY KEY (college_id)
);
GO

create table BUILDING (
	building_id varchar(20),
	building_name VARCHAR(50),
	address VARCHAR(50),
	college_id VARCHAR(10)
	constraint PK_Building PRIMARY KEY (building_id)
	constraint FK_Building FOREIGN KEY (college_id) REFERENCES college(college_id)
);
GO

create table DEPARTMENT (
	college_id VARCHAR(10),
	dept_id VARCHAR(10),
	dept_name VARCHAR(50),
	constraint PK_DEPARTMENT PRIMARY KEY (dept_id),
	constraint FK_Department Foreign Key (college_id) REFERENCES COLLEGE(college_id)
);
GO

create table building_department(
	building_id varchar(20),
	dept_id VARCHAR(10),
	start_date date,
	end_date date,
	constraint PK_BUILDING_DEPARTMENT PRIMARY KEY (building_id, dept_id, start_date),
	constraint FK_BUILDING_DEPARTMENT1 FOREIGN KEY (building_id) REFERENCES BUILDING(building_id),
	constraint FK_BUILDING_DEPARTMENT2 FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);

create table room(
	room_id varchar(10),
	building_id varchar(20),
	room_number int,
	[floor] int,
	room_type varchar(20),
	constraint PK_ROOM PRIMARY KEY (room_id),
	constraint FK_ROOM1 FOREIGN KEY (building_id) REFERENCES BUILDING(building_id)
);

create table STUDENT (
	student_id varchar(10),
	dept_id varchar(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	gender VARCHAR(50),
	SSN INT,
	[state] VARCHAR(50),
	city VARCHAR(50),
	zip VARCHAR(50),
	mobile_number BIGINT,
	date_of_birth DATE,
	GPA DECIMAL(3,2),
	constraint PK_Student PRIMARY KEY (student_id),
	constraint FK_Student Foreign Key (dept_id) REFERENCES DEPARTMENT(dept_id)
);
GO

create table registration (
	registration_id varchar(10),
	college_id VARCHAR(10),
	student_id varchar(10),
	admission_status varchar(20),
	year_of_application varchar(10),
	degree_type varchar(20),
	constraint PK_Registration PRIMARY KEY (registration_id),
	constraint FK_Registration1 FOREIGN KEY (college_id) REFERENCES College(college_id),
	constraint FK_Registration2 FOREIGN KEY (student_id) REFERENCES Student(student_id)
);
GO

CREATE TABLE COURSE (
	course_id varchar(10),
	course_name varchar(250),
	start_date date,
	end_date date,
	credits int,
	constraint PK_Course PRIMARY KEY (course_id)
); 
GO

CREATE TABLE STAFF (
	staff_id varchar(10),
	first_name varchar(50),
	last_name varchar(50),
	staff_type varchar(30),
	phone_number bigint,
	ssn int,
	[state] varchar(30),
	city varchar(30),
	zip int,
	date_of_birth date,
	email_id varchar(50),
	constraint PK_Staff PRIMARY KEY (staff_id)
); 
GO

CREATE TABLE STAFF_DEPT (
	staff_id varchar(10),
	dept_id VARCHAR(10),
	start_date date,
	end_date date,
	position varchar(50)
	constraint pk_staff_dept PRIMARY KEY (staff_id, dept_id),
	constraint FK_staff_dept1 FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
	constraint FK_staff_dept2 FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)	
);
GO

CREATE TABLE SCHEDULES (
	staff_id varchar(10),
	room_id varchar(10),
	[start_date] datetime,
	end_date datetime,
	isAvailable int, 
	constraint pk_schedules PRIMARY KEY (staff_id, room_id),
	constraint fk_schedules1 FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
	constraint fk_schedules2 FOREIGN KEY (room_id) REFERENCES ROOM(room_id),
	constraint isAvailableChk CHECK (isAvailable in (0, 1))
);
GO

CREATE TABLE COURSE_STAFF (
	staff_id varchar(10),
	course_id varchar(10),
	availability_in_hours_per_week int,	
	constraint pk_course_staff PRIMARY KEY (staff_id, course_id),
	constraint fk_course_staff1 FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
	constraint fk_course_staff2 FOREIGN KEY (course_id) REFERENCES COURSE(course_id),
);
GO

CREATE TABLE ENROLLS (
	student_id varchar(10),
	course_id varchar(10),
	grade float,	
	constraint pk_enrolls PRIMARY KEY (student_id, course_id),
	constraint fk_enrolls1 FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
	constraint fk_enrolls2 FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);
GO

CREATE TABLE CLUB (
	club_id varchar(10),
	club_name varchar(30),
	club_type varchar(25),
	activity varchar(10),
	constraint pk_club primary key (club_id)
);
GO

CREATE TABLE PARTICIPATES (
	club_id varchar(10),
	student_id varchar(10),
	position varchar(25),
	join_date date,
	left_date date,
	constraint pk_participates primary key (club_id, student_id),
	constraint fk_participates1 FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
	constraint fk_participates2 FOREIGN KEY (club_id) REFERENCES CLUB(club_id),

);
GO











