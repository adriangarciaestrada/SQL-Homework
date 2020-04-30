DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);

CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
	dept_man VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_man) REFERENCES departments(dept_no)
);

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS employee_details;

CREATE VIEW employee_details AS
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;

SELECT * FROM employee_details;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS year_employees;

CREATE VIEW year_employees AS
SELECT * FROM employees WHERE employees.hire_date >= '1986-1-1' and employees.hire_date <= '1986-12-31';

SELECT * FROM year_employees;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS dept_man_details;

CREATE VIEW dept_man_details AS
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM dept_manager
JOIN departments ON departments.dept_no = dept_manager.dept_man
JOIN employees ON employees.emp_no = dept_manager.emp_no;

SELECT * FROM dept_man_details;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS emp_dept;

CREATE VIEW emp_dept AS
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

SELECT * FROM emp_dept;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS emp_hercules_b;

CREATE VIEW emp_hercules_b AS
SELECT * FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

SELECT * FROM emp_hercules_b;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS sales_emp;

CREATE VIEW sales_emp AS
SELECT * FROM emp_dept
WHERE dept_name = 'Sales';

SELECT * FROM sales_emp;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS sales_dev_emp;

CREATE VIEW sales_dev_emp AS
SELECT * FROM emp_dept
WHERE dept_name = 'Sales' or dept_name = 'Development';

SELECT * FROM sales_dev_emp;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS last_name_counts;

CREATE VIEW last_name_counts AS
SELECT COUNT(emp_no), last_name FROM employees
GROUP BY last_name
ORDER BY COUNT(emp_no) DESC;

SELECT * FROM last_name_counts;