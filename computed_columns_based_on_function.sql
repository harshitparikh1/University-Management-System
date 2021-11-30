-- Function to get a Student's GPA 
drop function if exists getStudentGPA;
go

create function getStudentGPA (@student_id varchar(10))
returns float 
as
begin
	declare @total_GPA float;
	
	select @total_GPA = coalesce(round(avg(grade), 2), 0)
	from student s
	join ENROLLS e
	on s.student_id = e.student_id
	where s.student_id = @student_id
	group by s.student_id, s.first_name, s.last_name;
	return @total_GPA
end;

select dbo.getStudentGPA('S2');



-- Procedure to update GPA through a function
drop procedure if exists update_GPA;
go

create procedure Update_GPA(@student_id varchar(10), @message varchar(100)) as
begin
update STUDENT
set GPA = (select dbo.getStudentGPA(@student_id))
where student_id = @student_id;
set @message = 'Updated successfully'
end;

exec Update_GPA 'S2', output;