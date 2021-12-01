-- Trigger to check student changed course

-- Drop and create student_change_course_history table
drop table if exists StudentChangeCourseHistory
go

CREATE TABLE [dbo].StudentChangeCourseHistory(
    StudentChangeCourseID int  not null primary key identity(1,1),
student_id varchar(10) NOT NULL,
[Old_Course] varchar(10),
[New_Course] varchar(10) NULL,
ChangeDate datetime null
)

-- Drop trigger and create new trigger
drop trigger if exists StudentChangeCourse;
go

CREATE TRIGGER StudentChangeCourse
   ON  dbo.enrolls
  FOR UPDATE
AS 
BEGIN
IF UPDATE(course_id) 
  begin
INSERT INTO  StudentChangeCourseHistory ( 
student_id ,
[Old_Course] ,
[New_Course] ,
ChangeDate )
  SELECT d.student_id
  ,d.course_id
  ,i.course_id,
  GETDATE()
   FROM DELETED d join INSERTED i on d.student_id = i.student_id
end
END
GO

-- Check records in student id S102
select * from dbo.enrolls WHERE student_id = 'S102';

-- Modify course because that student took a new course
update dbo.enrolls set course_id ='CO45' WHERE student_id = 'S102';

-- Check the new table 
select * from StudentChangeCourseHistory;



-- Trigger 2 

DROP TRIGGER IF EXISTS UpdateStudentGPA
go

CREATE TRIGGER UpdateStudentGPA
on Enrolls
AFTER UPDATE
AS

update student
set student.GPA = student_GPA_table.total_GPA
from STUDENT 
join 
(	select s.student_id, coalesce(round(avg(grade), 2), 0) as total_GPA
	from student s
	join ENROLLS e
	on s.student_id = e.student_id
	group by s.student_id
) student_GPA_table
on student.student_id = student_GPA_table.student_id

GO


-- GPA of student S1 is 2.96
select GPA from STUDENT where student_id = 'S1';

-- S1 course CO107 GPA is 2.95 
select * from ENROLLS where student_id = 'S1';

-- Updating student S1 - course CO107 to 4.00.
update enrolls 
set grade = 4.00
where student_id = 'S1' and course_id = 'CO107'

-- NEW GPA of student S1 is 3.31
select GPA from STUDENT where student_id = 'S1';

