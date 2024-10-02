-- List the employee number, last name, first name, sex, and salary of each employee
SELECT 
	Employees.emp_no, 
	Employees.first_name, 
	Employees.last_name,
	Employees.sex,
	Salaries.salary
FROM 
	Employees
INNER JOIN
	Salaries
ON
	Salaries.emp_no = Employees.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986
SELECT
	Employees.first_name,
	Employees.last_name,
	Employees.hire_date
FROM
	Employees
WHERE
	EXTRACT(YEAR FROM hire_date) = 1986
;

-- List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name
SELECT
	Dept_Manager.dept_no,
	Departments.dept_name,
	Employees.emp_no,
	Employees.last_name,
	Employees.first_name
FROM
	Dept_Manager
INNER JOIN
	Departments
ON
	Departments.dept_no = Dept_Manager.dept_no
INNER JOIN
	Employees
ON
	Employees.emp_no = Dept_Manager.emp_no
;


-- List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name
SELECT 
	Dept_Employee.dept_no,
	Employees.emp_no,
	Employees.last_name,
	Employees.first_name,
	Departments.dept_name
FROM
	Employees
INNER JOIN
	Dept_Employee
ON
	Employees.emp_no = Dept_Employee.emp_no
INNER JOIN
	Departments
ON
	Dept_Employee.dept_no = Departments.dept_no
;

-- List first name, last name, and sex of each employee whose first name is Hercules 
-- and whose last name begins with the letter B

SELECT 
	Employees.first_name,
	Employees.last_name,
	Employees.sex
FROM
	Employees
WHERE
	Employees.first_name = 'Hercules'
	AND
	Employees.last_name LIKE 'B%'
;

-- List each employee in the Sales department, including their employee number, last name, 
-- and first name
SELECT
	Employees.emp_no,
	Employees.last_name,
	Employees.first_name
FROM
	Employees
INNER JOIN
	Dept_Employee
ON
	Dept_Employee.emp_no = Employees.emp_no
INNER JOIN
	Departments
ON
	Departments.dept_no = Dept_Employee.dept_no
WHERE
	Departments.dept_name = 'Sales'
;

-- List each employee in the Sales and Development departments, including their employee 
-- number, last name, first name, and department name
SELECT
	Employees.emp_no,
	Employees.last_name,
	Employees.first_name,
	Departments.dept_name
FROM 
	Employees
INNER JOIN
	Dept_Employee
ON
	Dept_Employee.emp_no = Employees.emp_no
INNER JOIN
	Departments
ON
	Departments.dept_no = Dept_Employee.dept_no
WHERE
	Departments.dept_name = 'Sales'
	OR
	Departments.dept_name = 'Development'
;

-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name)
SELECT 
	last_name, COUNT(*) AS frequency
FROM
	Employees
GROUP BY
	last_name
ORDER BY 
	frequency DESC
;