-- 1. View to get TOP 10 students based on their GPA
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



-- 2. View to display college name of students
drop view if exists student_college_name;
go

create view student_college_name as
(select s.student_id, c.college_name
from STUDENT s
join registration r on s.student_id = r.student_id
join DEPARTMENT d on s.dept_id = d.dept_id
join COLLEGE c on d.college_id = c.college_id
group by s.student_id, c.college_name);



-- 3. Best departments from the university

drop view if exists best_departments_college;
go

create view best_departments_in_college as
(select c.college_name, d.dept_name, count(1) total_students_enrolled
from registration r
join student s on r.student_id = s.student_id
join DEPARTMENT d on r.dept_id = d.dept_id
join college c on d.college_id = c.college_id
group by c.college_name, d.dept_name
order by count(1) desc
offset 0 rows)
go

select * from best_departments_in_college


