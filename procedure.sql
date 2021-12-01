-- Procedures

-- 1. Procedure to fetch GPA of a student
drop procedure if exists getGPAofStudent;
go

create procedure getGPAofStudent(@student_id varchar(10), @total_GPA float output) as
	select @total_GPA = coalesce(round(avg(grade), 2), 0)
	from student s
	join ENROLLS e
	on s.student_id = e.student_id
	where s.student_id = @student_id
	group by s.student_id, s.first_name, s.last_name
	begin
	return @total_GPA
	end

declare @GPA float;
exec getGPAofStudent 'S2', @total_GPA = @GPA output;
select @gpa as total_GPA


-- 2. Procedure to get total number of courses taken by a student
drop procedure if exists getCoursesByStudent;
go

create procedure getCoursesByStudent(@student_id varchar(10), @number_of_courses int output) as

select @number_of_courses = cast(count(distinct(course_id)) as int) 
from ENROLLS
where student_id = @student_id
group by student_id
begin
return @number_of_courses
end;

declare @course_count int;
exec getCoursesByStudent @student_id = 'S2', @number_of_courses = @course_count output
select @course_count as 'Number of courses enrolled'



-- 3. Procedure to fetch number of rooms booked by a professor
drop procedure if exists getTotalRoomsBookedByProfessor;
go

create procedure getTotalRoomsBookedByProfessor(@staff_id varchar(10), @number_of_rooms_booked int output) as

select @staff_id = sch.staff_id, @number_of_rooms_booked = cast(count(room_id) as int)
from schedules sch
join STAFF st on sch.staff_id = st.staff_id
where isAvailable = 1
and st.staff_id = @staff_id
and upper(st.staff_type) like upper('%prof%')
group by sch.staff_id

begin 
return @number_of_rooms_booked
end;

declare @rooms_booked_count int;
exec getTotalRoomsBookedByProfessor @staff_id = 'ST45', @number_of_rooms_booked = @rooms_booked_count output
select @rooms_booked_count as 'Number of rooms booked'



-- 4. Procedure to update all GPA's in the student table
update student
set gpa = student_GPA_table.total_GPA
from STUDENT 
join 
(	select s.student_id, coalesce(round(avg(grade), 2), 0) as total_GPA
	from student s
	join ENROLLS e
	on s.student_id = e.student_id
	group by s.student_id
) student_GPA_table
on student.student_id = student_GPA_table.student_id
