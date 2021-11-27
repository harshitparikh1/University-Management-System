-- Get number of rows from all tables
SELECT
      QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [TableName]
      , SUM(sdmvPTNS.row_count) AS [RowCount]
FROM
      sys.objects AS sOBJ
      INNER JOIN sys.dm_db_partition_stats AS sdmvPTNS
            ON sOBJ.object_id = sdmvPTNS.object_id
WHERE 
      sOBJ.type = 'U'
      AND sOBJ.is_ms_shipped = 0x0
      AND sdmvPTNS.index_id < 2
GROUP BY
      sOBJ.schema_id
      , sOBJ.name
ORDER BY [TableName]
GO


-- Unique departments
select dept_name, count(dept_name) from DEPARTMENT
group by dept_name
having count(dept_name) > 1
go


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
	group by s.student_id, s.first_name, s.last_name

	return @total_GPA
end;

select dbo.getStudentGPA('S2');



-- View to get TOP 10 students based on their GPA
drop view if exists top_10_student_GPA;
go

create view top_10_student_GPA as
with all_students as
(select concat(s.first_name, ' ', s.last_name) student_full_name, coalesce(round(avg(grade), 2), 0) as total_GPA,
		rank() over (order by coalesce(round(avg(grade), 2), 0) desc) rank_of_student
from student s
join ENROLLS e
on s.student_id = e.student_id
group by s.student_id, s.first_name, s.last_name
order by total_gpa desc
offset 0 rows)

select * 
from all_students
where rank_of_student >= 1 and  rank_of_student < 11;
go

select * from top_10_student_GPA;




-- View to display college name of students
drop view if exists student_college_name;
go

create view student_college_name as
(select s.student_id, c.college_name
from STUDENT s
join registration r on s.student_id = r.student_id
join DEPARTMENT d on s.dept_id = d.dept_id
join COLLEGE c on d.college_id = c.college_id
where s.student_id in ('S163', 'S220', 'S221', 'S412', 'S413', 'S414', 'S415', 'S483', 'S484', 'S365', 'S366', 'S367')
group by s.student_id, c.college_name);

select * from student_college_name;


-- Total rooms booked by professor within a date frame

-- popular student clubs college wise?

-- popular courses at your university?

-- popular departments at your university?

-- Average GPA per university

-- Average students per course

-- total students per course // popular courses

-- total students per department

-- percentage of students taking this course/department

-- total grad students per college

-- total TA's in the college

-- % of professor_types

-- average professors per college

-- total students enroller per spring/fall/summer








select student_id, count(1) from registration group by student_id having count(student_id) > 1






