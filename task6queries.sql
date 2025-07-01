mysql> use mysql
Database changed
mysql> CREATE TABLE Department (
    ->     dept_id INTEGER PRIMARY KEY,
    ->     dept_name TEXT
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE Employee (
    ->     emp_id INTEGER PRIMARY KEY,
    ->     emp_name TEXT,
    ->     salary INTEGER,
    ->     dept_id INTEGER,
    ->     FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE Project (
    ->     project_id INTEGER PRIMARY KEY,
    ->     project_name TEXT,
    ->     emp_id INTEGER,
    ->     FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO Department (dept_id, dept_name) VALUES
    -> (1, 'HR'),
    -> (2, 'IT'),
    -> (3, 'Finance');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Employee (emp_id, emp_name, salary, dept_id) VALUES
    -> (101, 'Alice', 70000, 2),
    -> (102, 'Bob', 55000, 2),
    -> (103, 'Charlie', 40000, 1),
    -> (104, 'David', 90000, 3),
    -> (105, 'Eve', 30000, 1);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Project (project_id, project_name, emp_id) VALUES
    -> (201, 'Website Redesign', 101),
    -> (202, 'App Development', 102),
    -> (203, 'Audit Preparation', 104),
    -> (204, 'Recruitment Drive', 103);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT
    ->     emp_name,
    ->     (SELECT dept_name FROM Department d WHERE d.dept_id = e.dept_id) AS department_name
    -> FROM Employee e;
+----------+-----------------+
| emp_name | department_name |
+----------+-----------------+
| Alice    | IT              |
| Bob      | IT              |
| Charlie  | HR              |
| David    | Finance         |
| Eve      | HR              |
+----------+-----------------+
5 rows in set (0.00 sec)

mysql> SELECT emp_name
    -> FROM Employee
    -> WHERE emp_id IN (
    ->     SELECT emp_id FROM Project
    -> );
+----------+
| emp_name |
+----------+
| Alice    |
| Bob      |
| Charlie  |
| David    |
+----------+
4 rows in set (0.00 sec)

mysql> SELECT dept_name
    -> FROM Department d
    -> WHERE EXISTS (
    ->     SELECT 1 FROM Employee e WHERE e.dept_id = d.dept_id
    -> );
+-----------+
| dept_name |
+-----------+
| HR        |
| IT        |
| Finance   |
+-----------+
3 rows in set (0.00 sec)

mysql> SELECT emp_name, salary
    -> FROM Employee
    -> WHERE salary = (
    ->     SELECT MAX(salary) FROM Employee
    -> );
+----------+--------+
| emp_name | salary |
+----------+--------+
| David    |  90000 |
+----------+--------+
1 row in set (0.00 sec)

mysql> SELECT d.dept_name, avg_salaries.avg_salary
    -> FROM (
    ->     SELECT dept_id, AVG(salary) AS avg_salary
    ->     FROM Employee
    ->     GROUP BY dept_id
    -> ) AS avg_salaries
    -> JOIN Department d ON d.dept_id = avg_salaries.dept_id;
+-----------+------------+
| dept_name | avg_salary |
+-----------+------------+
| HR        | 35000.0000 |
| IT        | 62500.0000 |
| Finance   | 90000.0000 |
+-----------+------------+
3 rows in set (0.00 sec)

mysql> SELECT
    ->     emp_name,
    ->     (SELECT COUNT(*) FROM Project p WHERE p.emp_id = e.emp_id) AS project_count
    -> FROM Employee e;
+----------+---------------+
| emp_name | project_count |
+----------+---------------+
| Alice    |             1 |
| Bob      |             1 |
| Charlie  |             1 |
| David    |             1 |
| Eve      |             0 |
+----------+---------------+
5 rows in set (0.00 sec)