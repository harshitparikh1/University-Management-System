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






-- trigger - student registers for course, student participates/leaves a club
-- compute age from dob





-- Total rooms booked by professor within a date frame

-- popular student clubs college wise?;

-- popular courses at your university?

-- popular departments at your university?

select d.dept_name, count(1)
from registration r
join student s on r.student_id = s.student_id
join DEPARTMENT d on r.dept_id = d.dept_id
join college c on d.college_id = c.college_id
group by d.dept_name
order by count(1) desc
;




select * from staff;

-- Average GPA per university

-- Average students per course

-- total students per course // popular courses

-- total students per department

-- percentage of students taking this course/department

select * from course where course_name like '%1%';

-- total grad students per college

-- total TA's in the college

-- % of professor_types

-- average professors per college

-- total students enroller per spring/fall/summer











