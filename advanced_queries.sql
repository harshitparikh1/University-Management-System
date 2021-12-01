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

-- Check all constraints
SELECT 
  Name,
  OBJECT_NAME(parent_object_id) AS 'Table',
  ISNULL(name, '(n/a)') AS 'Column',
  parent_column_id,
  CASE WHEN parent_column_id = 0
    THEN 'Table-level'
    ELSE 'Column-level'
    END AS 'Table/Column',
  Definition
FROM sys.check_constraints;



-- Check all triggers
SELECT name, is_instead_of_trigger
FROM sys.triggers  
WHERE type = 'TR';



-- Percentage of staff working in that particular university among all the other staffs.
select c.college_name, s.staff_type, count(s.staff_type) count_staff_type,
	sum(count(s.staff_type)) over (partition by college_name) total_staffs,
	concat(round(cast(cast(count(s.staff_type) as float) / cast(sum(count(s.staff_type)) over (partition by college_name) as float) as float ) * 100, 2), '%') percent_of_staff_type
from staff s
join STAFF_DEPT sd on s.staff_id = sd.staff_id
join DEPARTMENT d on sd.dept_id = d.dept_id
join college c on d.college_id = c.college_id
group by c.college_name, s.staff_type;


-- Get age from date of birth of Student
select concat(s.first_name, ' ', s.last_name) full_name, date_of_birth, 
	DATEDIFF(yy, date_of_birth, GETDATE()) - 
		CASE WHEN (MONTH(date_of_birth) >= MONTH(GETDATE())) 
					AND DAY(date_of_birth) > DAY(GETDATE()) 
			 THEN 1 
			 ELSE 0 
		END age
from student s
order by age desc, date_of_birth
;



-- Number of professors per college
select c.college_name, count(s.staff_type) number_of_professors
from STAFF s
join STAFF_DEPT sd on s.staff_id = sd.staff_id
join DEPARTMENT d on d.dept_id = sd.dept_id
join COLLEGE c on c.college_id = d.college_id
where lower(s.staff_type) like lower('%prof%')
group by c.college_name
order by number_of_professors desc



