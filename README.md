# Student Performance & Analytics System

A beginner-friendly relational database project built with **MySQL 8.0**. It stores student, course, enrollment, and marks data, then uses SQL queries and views to analyse academic performance.

## Project objectives

- Store student and course information in related tables.
- Connect students to courses using primary and foreign keys.
- Analyse individual, course-wise, and department-wise performance.
- Identify top performers and students who may need improvement.
- Create reusable SQL views for reporting.

## Database schema

| Table | Purpose |
|---|---|
| `Students` | Student details, department, and city |
| `Courses` | Course names and credit values |
| `Enrollments` | Student-to-course enrollment relationships |
| `Marks` | Student marks for each course and exam type |

The database contains 10 students, 4 courses, 20 enrollments, and 20 marks records.

## SQL concepts demonstrated

- Database and table creation
- Primary keys and foreign keys
- `INSERT`, `SELECT`, and `WHERE`
- `INNER JOIN`
- Aggregate functions: `COUNT`, `AVG`, `MAX`, and `MIN`
- `GROUP BY` and `HAVING`
- `ORDER BY` and `LIMIT`
- Subqueries
- `CASE WHEN`
- SQL views

## Project reports

The SQL script includes reports for:

1. Student-wise course and marks details
2. Average marks for each student
3. Top three students by average marks
4. Course-wise average marks
5. Pass / needs-improvement classification
6. Department-wise average performance
7. Students scoring below 75
8. Highest, lowest, and average marks per course
9. Students scoring above the overall average
10. Student(s) with the highest individual mark

It also creates two views: `Student_Performance_Report` and `Top_Performers`.

## How to run

1. Install MySQL 8.0 and open MySQL Workbench.
2. Open `student_performance.sql`.
3. Execute the script from top to bottom.
4. Review the result grids and query the two views.

**Note:** The script drops and recreates the project tables and views to provide a clean, repeatable setup. Do not run it in a database containing data you need to preserve.

## Repository structure

```text
Student-Performance-Analytics/
├── student_performance.sql
├── README.md
└── screenshots/
```

## Future improvements

- Add constraints such as `NOT NULL`, `UNIQUE`, and `CHECK`.
- Add more students, courses, and exam types.
- Build a dashboard using Power BI or Python.
- Add stored procedures for frequently used reports.

## Author

Add your name and GitHub profile link here.
