drop trigger if exists dbo.SendEmail
go 

CREATE TRIGGER dbo.SendEmail   
   ON  dbo.Student
   AFTER INSERT
AS 

BEGIN        

BEGIN

	DECLARE @recipients nvarchar(1000);
	DECLARE @body nvarchar(1000);

	select @recipients = email from inserted i;
	select @body = concat('Welcome to our university - ', first_name, ' ', last_name, '. Have a good time over here.') from inserted i;

    EXEC msdb.dbo.sp_send_dbmail
      @recipients = @recipients, 
	  @copy_recipients = 'parikh.ha@northeastern.edu', 
      @subject = 'New Student Added', 
      @body = @body;
END
END
GO



insert into student (student_id, first_name, last_name, email) values ('S5000', 'Harshit', 'Parikh', 'harshitparikh12@gmail.com');

delete from student where student_id = 'S5000';



EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO


EXEC sp_configure 'Database Mail XPs', 1
GO
RECONFIGURE
GO


EXEC sp_configure 'Database Mail XPs'
GO


EXEC sp_configure 'show advanced options', 0
GO
RECONFIGURE
GO




EXEC sp_configure 'show advanced', 1;  
RECONFIGURE; 
EXEC sp_configure; 
GO



EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'Mail';

EXECUTE msdb.dbo.sysmail_help_queue_sp ;  
GO 







