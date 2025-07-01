
# 📊 Subqueries and Nested Queries – SQL Project

## 🎯 Objective
Demonstrate the use of **scalar and correlated subqueries** in various SQL clauses:  
- `SELECT`
- `WHERE`
- `FROM`

Using tools like:
- ✅ DB Browser for SQLite
- ✅ MySQL Workbench

---

## 🛠️ Tools & Technologies
- SQL (Standard compatible with SQLite/MySQL)
- DB Browser for SQLite or MySQL Workbench
- Git/GitHub

---

## 📁 Project Structure


---

## 🧱 Database Schema

- **Department**
  - `dept_id` (PK)
  - `dept_name`

- **Employee**
  - `emp_id` (PK)
  - `emp_name`
  - `salary`
  - `dept_id` (FK)

- **Project**
  - `project_id` (PK)
  - `project_name`
  - `emp_id` (FK)

---

## 📥 Sample Data

Example entries include:
- Employees: Alice, Bob, Charlie, David, Eve
- Departments: HR, IT, Finance
- Projects: Website Redesign, App Development, etc.

---

## 🔍 SQL Features Demonstrated

### ✅ Subqueries in SELECT Clause
```sql
SELECT emp_name, 
       (SELECT dept_name FROM Department WHERE dept_id = e.dept_id) AS department
FROM Employee e;
---
SELECT dept_name, avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Employee
    GROUP BY dept_id
) AS dept_avg
JOIN Department d ON d.dept_id = dept_avg.dept_id;
