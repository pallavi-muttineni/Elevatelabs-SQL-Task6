-- 🔄 Drop existing tables (for re-run safety)
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

-- 🏗️ Create Department table
CREATE TABLE Department (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT
);

-- 🏗️ Create Employee table
CREATE TABLE Employee (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT,
    salary INTEGER,
    dept_id INTEGER,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- 🏗️ Create Project table
CREATE TABLE Project (
    project_id INTEGER PRIMARY KEY,
    project_name TEXT,
    emp_id INTEGER,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

-- 📥 Insert sample data into Department
INSERT INTO Department (dept_id, dept_name) VALUES 
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- 📥 Insert sample data into Employee
INSERT INTO Employee (emp_id, emp_name, salary, dept_id) VALUES
(101, 'Alice', 70000, 2),
(102, 'Bob', 55000, 2),
(103, 'Charlie', 40000, 1),
(104, 'David', 90000, 3),
(105, 'Eve', 30000, 1);

-- 📥 Insert sample data into Project
INSERT INTO Project (project_id, project_name, emp_id) VALUES
(201, 'Website Redesign', 101),
(202, 'App Development', 102),
(203, 'Audit Preparation', 104),
(204, 'Recruitment Drive', 103);

-- 🔍 A. Subquery in SELECT Clause (Scalar Subquery)
SELECT 
    emp_name,
    (SELECT dept_name FROM Department d WHERE d.dept_id = e.dept_id) AS department_name
FROM Employee e;

-- 🔍 B. Subquery in WHERE Clause using IN
SELECT emp_name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id FROM Project
);

-- 🔍 C. Subquery in WHERE Clause using EXISTS (Correlated Subquery)
SELECT dept_name
FROM Department d
WHERE EXISTS (
    SELECT 1 FROM Employee e WHERE e.dept_id = d.dept_id
);

-- 🔍 D. Scalar Subquery with =
SELECT emp_name, salary
FROM Employee
WHERE salary = (
    SELECT MAX(salary) FROM Employee
);

-- 🔍 E. Subquery in FROM Clause (Derived Table)
SELECT d.dept_name, avg_salaries.avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Employee
    GROUP BY dept_id
) AS avg_salaries
JOIN Department d ON d.dept_id = avg_salaries.dept_id;

-- 🔍 F. Correlated Subquery in SELECT Clause
SELECT 
    emp_name,
    (SELECT COUNT(*) FROM Project p WHERE p.emp_id = e.emp_id) AS project_count
FROM Employee e;
