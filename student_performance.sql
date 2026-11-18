-- =========================================================
-- PROJECT: STUDENT PERFORMANCE & ANALYTICS SYSTEM
-- Database: StudentPerformance
-- MySQL 8.0
-- =========================================================

CREATE DATABASE IF NOT EXISTS StudentPerformance;
USE StudentPerformance;

-- For a clean rerun, remove existing project tables in FK-safe order.
DROP VIEW IF EXISTS Student_Performance_Report;
DROP VIEW IF EXISTS Top_Performers;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

-- 1. CREATE TABLES

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    exam_type VARCHAR(30),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 2. INSERT STUDENT DATA

INSERT INTO Students VALUES
(1, 'Aarav', 20, 'CSE', 'Hyderabad'),
(2, 'Priya', 21, 'AI&ML', 'Warangal'),
(3, 'Rahul', 20, 'ECE', 'Hyderabad'),
(4, 'Sneha', 22, 'CSE', 'Karimnagar'),
(5, 'Kiran', 21, 'AI&ML', 'Nizamabad'),
(6, 'Ananya', 20, 'ECE', 'Vijayawada'),
(7, 'Varun', 22, 'CSE', 'Hyderabad'),
(8, 'Meghana', 21, 'AI&ML', 'Guntur'),
(9, 'Arjun', 20, 'ECE', 'Warangal'),
(10, 'Divya', 22, 'CSE', 'Hyderabad');

-- 3. INSERT COURSE DATA

INSERT INTO Courses VALUES
(101, 'SQL', 4),
(102, 'Python', 3),
(103, 'Machine Learning', 4),
(104, 'Data Analytics', 3);

-- 4. INSERT ENROLLMENT DATA

INSERT INTO Enrollments VALUES
(1, 1, 101), (2, 1, 102),
(3, 2, 101), (4, 2, 103),
(5, 3, 102), (6, 3, 104),
(7, 4, 101), (8, 4, 104),
(9, 5, 103), (10, 5, 101),
(11, 6, 102), (12, 6, 103),
(13, 7, 101), (14, 7, 102),
(15, 8, 104), (16, 8, 103),
(17, 9, 102), (18, 9, 104),
(19, 10, 101), (20, 10, 103);

-- 5. INSERT MARKS DATA

INSERT INTO Marks VALUES
(1, 1, 101, 92, 'Final'),
(2, 1, 102, 85, 'Final'),
(3, 2, 101, 88, 'Final'),
(4, 2, 103, 95, 'Final'),
(5, 3, 102, 76, 'Final'),
(6, 3, 104, 81, 'Final'),
(7, 4, 101, 90, 'Final'),
(8, 4, 104, 87, 'Final'),
(9, 5, 103, 78, 'Final'),
(10, 5, 101, 82, 'Final'),
(11, 6, 102, 91, 'Final'),
(12, 6, 103, 89, 'Final'),
(13, 7, 101, 65, 'Final'),
(14, 7, 102, 72, 'Final'),
(15, 8, 104, 94, 'Final'),
(16, 8, 103, 96, 'Final'),
(17, 9, 102, 58, 'Final'),
(18, 9, 104, 68, 'Final'),
(19, 10, 101, 98, 'Final'),
(20, 10, 103, 93, 'Final');

-- 6. VERIFY RECORD COUNTS

SELECT COUNT(*) AS total_students FROM Students;
SELECT COUNT(*) AS total_courses FROM Courses;
SELECT COUNT(*) AS total_enrollments FROM Enrollments;
SELECT COUNT(*) AS total_marks FROM Marks;

-- 7. PROJECT ANALYSIS QUERIES

-- Query 1: Student names, departments, courses and marks
SELECT
    s.student_name,
    s.department,
    c.course_name,
    m.marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
INNER JOIN Courses AS c ON m.course_id = c.course_id;

-- Query 2: Student-wise average marks
SELECT
    s.student_name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC;

-- Query 3: Top 3 students by average marks
SELECT
    s.student_name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC
LIMIT 3;

-- Query 4: Course-wise average marks
SELECT
    c.course_name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Courses AS c
INNER JOIN Marks AS m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name
ORDER BY average_marks DESC;

-- Query 5: Classify each student's performance
SELECT
    s.student_name,
    c.course_name,
    m.marks,
    CASE
        WHEN m.marks >= 75 THEN 'Pass'
        ELSE 'Needs Improvement'
    END AS performance_status
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
INNER JOIN Courses AS c ON m.course_id = c.course_id;

-- Query 6: Department-wise performance
SELECT
    s.department,
    COUNT(DISTINCT s.student_id) AS total_students,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
GROUP BY s.department
ORDER BY average_marks DESC;

-- Query 7: Students scoring below 75
SELECT
    s.student_name,
    c.course_name,
    m.marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
INNER JOIN Courses AS c ON m.course_id = c.course_id
WHERE m.marks < 75;

-- Query 8: Highest, lowest and average marks per course
SELECT
    c.course_name,
    MAX(m.marks) AS highest_marks,
    MIN(m.marks) AS lowest_marks,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Courses AS c
INNER JOIN Marks AS m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name;

-- Query 9: Students with marks above the overall average
SELECT
    s.student_name,
    c.course_name,
    m.marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
INNER JOIN Courses AS c ON m.course_id = c.course_id
WHERE m.marks > (SELECT AVG(marks) FROM Marks)
ORDER BY m.marks DESC;

-- Query 10: Highest individual mark
SELECT
    s.student_name,
    c.course_name,
    m.marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
INNER JOIN Courses AS c ON m.course_id = c.course_id
WHERE m.marks = (SELECT MAX(marks) FROM Marks);

-- 8. CREATE VIEWS

CREATE VIEW Student_Performance_Report AS
SELECT
    s.student_id,
    s.student_name,
    s.department,
    c.course_name,
    m.marks,
    m.exam_type
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
INNER JOIN Courses AS c ON m.course_id = c.course_id;

SELECT * FROM Student_Performance_Report;

CREATE VIEW Top_Performers AS
SELECT
    s.student_id,
    s.student_name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Students AS s
INNER JOIN Marks AS m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
HAVING AVG(m.marks) >= 90;

SELECT * FROM Top_Performers;

-- =========================================================
-- END OF PROJECT
-- =========================================================
