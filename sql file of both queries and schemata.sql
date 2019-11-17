CREATE TABLE departments(
dept_no VARCHAR(20) PRIMARY KEY,
dept_name VARCHAR(20)
);

CREATE TABLE employees(
emp_no INT PRIMARY KEY,	
birth_date VARCHAR(15),
first_name VARCHAR(20),
last_name VARCHAR(20),
gender VARCHAR(5),
hire_date VARCHAR(15)
);
select *
from employees

CREATE TABLE dept_emp(
emp_no INT,
dept_no VARCHAR(10) ,
from_date VARCHAR(15),
to_date VARCHAR(15),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE deptmanager(
dept_no VARCHAR(10),
emp_no INT,
from_date VARCHAR(15),
to_date VARCHAR(15),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

drop table deptmanager 

CREATE TABLE salaries(
emp_no INT,
salary INT,
from_date VARCHAR(15),
to_date VARCHAR(15),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

drop table salaries

CREATE TABLE titles(
emp_no INT,
title VARCHAR(30),
from_date VARCHAR(15),
to_date VARCHAR(15),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

drop table titles
--------------------------------------------------------------------
--------------------------------------------------------
------------------------------------------
--list the following details of each employee:
---- employee number, last name, first name, gender, and salary.
SELECT employees.emp_no,
		employees.last_name,
		employees.first_name,
		employees.gender,
		salaries.salary
	FROM employees
		INNER JOIN salaries ON
		employees.emp_no=salaries.emp_no;
---------------------------------------------------
----List employees who were hired in 1986.
select * 
from employees

SELECT employees.emp_no,
employees.hire_date, 
employees.first_name, 
employees.last_name
FROM employees
WHERE hire_date LIKE '1986%';
-----------------------------------------------------
----List the manager of each department with the following information: 
------department number, department name, the manager's employee number
-----------last name, first name, and start and end employment dates.
SELECT departments.dept_name,
		departments.dept_no,
		deptmanager.emp_no,
		deptmanager.from_date,
		deptmanager.to_date,
		employees.first_name,
		employees.last_name
	FROM deptmanager
	INNER JOIN departments ON deptmanager.dept_no=departments.dept_no
	INNER JOIN employees ON deptmanager.emp_no=employees.emp_no;
--List the department of each employee with the following information:
--employee number, last name, first name, and department name.
SELECT employees.emp_no,
		employees.first_name,
		employees.last_name,
		departments.dept_name
	FROM employees 
	INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments ON departments.dept_no = dept_emp.dept_no;
-------------------------------------------------------------

--List all employees whose first name is "Hercules"
--and last names begin with "B."
SELECT employees.first_name, employees.last_name
FROM employees
WHERE employees.first_name = 'Hercules' AND
employees.last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number,
--last name, first name, and department name.
SELECT employees.emp_no,
		employees.first_name,
		employees.last_name,
		departments.dept_name
	FROM employees
	JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	JOIN departments ON departments.dept_no = dept_emp.dept_no
	WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
		employees.first_name,
		employees.last_name,
		departments.dept_name
	FROM employees
	JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	JOIN departments ON departments.dept_no = dept_emp.dept_no
	WHERE departments.dept_name = 'Sales'
	OR departments.dept_name = 'Development';

--In descending order, list the frequency count
--of employee last names, i.e., how many employees share each last name.
select last_name, count (last_name) as name_count
from employees
group by last_name
order by name_count desc;
