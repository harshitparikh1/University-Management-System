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










CREATE OR ALTER TRIGGER trig_InsertCustomerData
ON Customer
AFTER INSERT
AS

UPDATE Customer set
[Encrypted_Email] = EncryptByKey(Key_GUID('EmailPass_SM'), CONVERT(varbinary,[CustomerEmail]) )
UPDATE Customer set
[Encrypted_Phone] = EncryptByKey(Key_GUID('PhonePass_SM'), CONVERT(varbinary,[CustomerContact]) )

GO