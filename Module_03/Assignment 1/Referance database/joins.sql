create database school;
use school;

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50),
  course_id INT
);

INSERT INTO students (student_id, student_name, course_id) VALUES
(1, 'Arun', 101),
(2, 'Banu', 102),
(3, 'Chitra', 103),
(4, 'Dinesh', NULL),
(5, 'Esha', 105);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(50)
);

INSERT INTO courses (course_id, course_name) VALUES
(101, 'Python'),
(102, 'SQL'),
(103, 'Power BI'),
(104, 'Excel'),
(106, 'Tableau');

SELECT s.student_id S_ID, s.course_id C_ID, c.course_name Name 
FROM students AS s
RIGHT JOIN courses c
ON s.course_id = c.course_id
WHERE c.course_id > 101;

SELECT students.student_name, courses.course_name 
FROM students
INNER JOIN courses
ON students.course_id = courses.course_id;








SELECT * FROM students;
SELECT * FROM courses;
TRUNCATE TABLE students;
TRUNCATE TABLE courses;
DROP TABLE students;
DROP TABLE courses;
DROP DATABASE school;


CREATE TABLE courses2 (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(50)
);

INSERT INTO courses2 (course_id, course_name) VALUES
(101, 'Python'),
(102, 'C#'),
(109, 'Java'); 

SELECT * FROM courses
UNION
SELECT * FROM courses2;

SELECT * FROM courses
UNION ALL
SELECT * FROM courses2;