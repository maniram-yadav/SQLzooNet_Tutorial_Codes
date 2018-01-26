Using Null
teacher
id	dept	name	phone	mobile
101	1	Shrivell	2753	07986 555 1234
102	1	Throd	2754	07122 555 1920
103	1	Splint	2293	
104		Spiregrain	3287	
105	2	Cutflower	3212	07996 555 6574
106		Deadyawn	3345	
...
dept
id	name
1	Computing
2	Design
3	Engineering
...
Teachers and Departments
The school includes many departments. Most teachers work exclusively for a single department. Some teachers have no department.

Selecting NULL values.









1.
List the teachers who have NULL for their department.

Why we cannot use =
You might think that the phrase dept=NULL would work here but it doesn't - you can use the phrase dept IS NULL

That's not a proper explanation.

select t.name from teacher as t where t.dept is NULL










2.
Note the INNER JOIN misses the teachers with no department and the departments with no teacher.


SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)









3.
Use a different JOIN so that all teachers are listed.


select t.name,d.name from teacher as t LEFT JOIN dept as d on t.dept=d.id 









4.
Use a different JOIN so that all departments are listed.


select t.name,d.name from teacher as t RIGHT JOIN dept as d on t.dept=d.id 










5.
Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'


select name,COALESCE(mobile,'07986 444 2266' ) AS mobile from teacher











6.
Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.


select t.name,COALESCE(d.name,'None' ) from teacher as t LEFT JOIN dept as d on t.dept=d.id 








7.
Use COUNT to show the number of teachers and the number of mobile phones.


select count(name),count(mobile) from teacher 










8.
Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.


select dept.name,count(teacher.name) from teacher RIGHT JOIN dept on teacher.dept=dept.id group by dept.name










9.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.


select 
 teacher.name,(CASE WHEN teacher.dept in (1,2) THEN 'Sci' ELSE 'Art' END ) from teacher









10.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.


select 
 teacher.name,
CASE WHEN teacher.dept in (1,2) THEN 'Sci'
     WHEN teacher.dept=3 THEN 'Art' ELSE 'None' END  from teacher







