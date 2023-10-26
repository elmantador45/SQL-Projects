-- Question 1
USE ischool;
DROP VIEW IF EXISTS student_enrollment_details;

CREATE VIEW student_enrollment_details AS
SELECT CONCAT(p.fname, ' ', p.lname ) AS 'name',
       CONCAT(cs.semester, ' ', cs.year) AS 'term',
       COUNT(c.course_id),
       SUM(c.credits),
       COUNT(c.course_prereq)
FROM people p
JOIN enrollments e ON p.person_id = e.person_id
JOIN course_sections cs ON e.section_id = cs.section_id
JOIN courses c ON cs.course_id = c.course_id
WHERE cs.meeting_days != 'Online'
GROUP BY name, term
HAVING term = 'Fall 2021'
ORDER BY name;
SELECT * FROM student_enrollment_details