/*
Sample Data
-----------
                      teacher
------------------------------------------------
id    dept    name        phone   mobile
101   1       Shrivell    2753    07986 555 1234
102   1       Throd       2754    07122 555 1920
103   1       Splint      2293
104           Spiregrain  3287
105   2       Cutflower   3212    07996 555 6574
106           Deadyawn    3345
...

  dept
-----------
id    name
1     Computing
2     Design
3     Engineering
...
*/

-- 1. List the teachers who have NULL for their department.
SELECT teacher.name
FROM teacher
WHERE dept IS NULL;

-- 2. Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
ON (teacher.dept = dept.id);
/*
answer:
-------
name        name
--------------------
Shrivell    Computing
Throd       Computing
Splint      Computing
Cutflower   Design
*/

-- 3. Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
ON (teacher.dept = dept.id);
-- OR
SELECT teacher.name, dept.name
FROM dept RIGHT JOIN teacher
ON (teacher.dept = dept.id);


-- 4. Use a different JOIN so that all departments are listed.
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept
ON (teacher.dept = dept.id);
-- OR
SELECT teacher.name, dept.name
FROM dept LEFT JOIN teacher
ON (teacher.dept = dept.id);

-- 5. Use COALESCE to print the mobile number, Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'.
SELECT teacher.name, COALESCE(mobile, '07986 444 2266') AS mobile
FROM teacher;

-- 6. Use COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT teacher.name, COALESCE(dept.name, 'None') AS dept
FROM teacher LEFT JOIN dept ON (dept.id = teacher.dept);

-- 7. Use COUNT to show the number of teachers and the number of mobile phones.
SELECT COUNT(teacher.name) as teachers, COUNT(teacher.mobile) as mobile
FROM teacher;

-- 8. Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT dept.name, COUNT(teacher.name) as count
FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept
GROUP BY dept.name;

-- 9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT teacher.name, (CASE
  WHEN teacher.dept IN (1, 2) THEN 'Sci'
  ELSE 'Art'
  END) as name
FROM teacher;

-- 10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
SELECT teacher.name, (CASE
  WHEN teacher.dept IN (1, 2) THEN 'Sci'
  WHEN teacher.dept = 3 THEN 'Art'
  ELSE 'None'
  END) as name
FROM teacher;
