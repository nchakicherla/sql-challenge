DROP TABLE IF EXISTS Titles CASCADE;
CREATE TABLE Titles (
    title_id varchar(8)   NOT NULL,
    title varchar(32)   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

DROP TABLE IF EXISTS Salaries CASCADE;
CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no
     )
);

DROP TABLE IF EXISTS Dept_Manager CASCADE;
CREATE TABLE Dept_Manager (
    dept_no varchar(8)   NOT NULL,
    emp_no int   NOT NULL
);

DROP TABLE IF EXISTS Dept_Employee CASCADE;
CREATE TABLE Dept_Employee (
    emp_no int   NOT NULL,
    dept_no varchar(4)   NOT NULL
);

DROP TABLE IF EXISTS Departments CASCADE;
CREATE TABLE Departments (
    dept_no varchar(4)   NOT NULL,
    dept_name varchar(32)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

DROP TABLE IF EXISTS Employees CASCADE;
CREATE TABLE Employees (
    emp_no int   NOT NULL,
    emp_title_id varchar(8)   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(64)   NOT NULL,
    last_name varchar(64)   NOT NULL,
    sex varchar(1)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

-- Add unique key constraints

ALTER TABLE Titles ADD CONSTRAINT unq_Titles_title_id UNIQUE (title_id);

ALTER TABLE Salaries ADD CONSTRAINT unq_Salaries_emp_no UNIQUE (emp_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT unq_Dept_Manager_emp_no UNIQUE (emp_no);

ALTER TABLE Departments ADD CONSTRAINT unq_Departments_dept_no UNIQUE (dept_no);

ALTER TABLE Employees ADD CONSTRAINT unq_Employees_emp_no UNIQUE (emp_no);

-- Add foreign key constraints

ALTER TABLE Dept_Employee ADD CONSTRAINT fk_Dept_Employee_dept_no FOREIGN KEY(dept_no)
	REFERENCES Departments (dept_no);

ALTER TABLE Dept_Employee ADD CONSTRAINT fk_Dept_Employee_emp_no FOREIGN KEY(emp_no)
	REFERENCES Employees (emp_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_dept_no FOREIGN KEY(dept_no)
	REFERENCES Departments (dept_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_emp_no FOREIGN KEY(emp_no)
	REFERENCES Employees (emp_no);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
	REFERENCES Employees (emp_no);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_no FOREIGN KEY(emp_title_id)
	REFERENCES Titles (title_id);

-- Import .csv data

COPY Titles (title_id, title)
FROM '/tmp/titles.csv'
DELIMITER ','
CSV HEADER;

COPY Employees (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM '/tmp/employees.csv'
DELIMITER ','
CSV HEADER;

COPY Departments (dept_no, dept_name)
FROM '/tmp/departments.csv'
DELIMITER ','
CSV HEADER;

COPY Salaries (emp_no, salary)
FROM '/tmp/salaries.csv'
DELIMITER ','
CSV HEADER;
	
COPY Dept_Manager (dept_no, emp_no)
FROM '/tmp/dept_manager.csv'
DELIMITER ','
CSV HEADER;

COPY Dept_Employee (emp_no, dept_no)
FROM '/tmp/dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- Analysis
--

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

-- SELECT * FROM Employees;