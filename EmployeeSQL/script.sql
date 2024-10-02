-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/lvdCt9
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE IF EXISTS "Titles" CASCADE;
CREATE TABLE "Titles" (
    "title_id" varchar(8)   NOT NULL,
    "title" varchar(32)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

DROP TABLE IF EXISTS "Salaries" CASCADE;
CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

DROP TABLE IF EXISTS "Dept_Manager" CASCADE;
CREATE TABLE "Dept_Manager" (
    "dept_no" varchar(8)   NOT NULL,
    "emp_no" int   NOT NULL
);

DROP TABLE IF EXISTS "Dept_Employee" CASCADE;
CREATE TABLE "Dept_Employee" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    CONSTRAINT "pk_Dept_Employee" PRIMARY KEY (
        "emp_no"
     )
);

DROP TABLE IF EXISTS "Departments" CASCADE;
CREATE TABLE "Departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(32)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

DROP TABLE IF EXISTS "Employees" CASCADE;
CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(8)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(64)   NOT NULL,
    "last_name" varchar(64)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "Titles" ADD CONSTRAINT "unq_Titles_title_id" UNIQUE ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "unq_Salaries_emp_no" UNIQUE ("emp_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "unq_Dept_Manager_emp_no" UNIQUE ("emp_no");

ALTER TABLE "Dept_Employee" ADD CONSTRAINT "unq_Dept_Employee_emp_no" UNIQUE ("emp_no");

ALTER TABLE "Departments" ADD CONSTRAINT "unq_Departments_dept_no" UNIQUE ("dept_no");

ALTER TABLE "Employees" ADD CONSTRAINT "unq_Employees_emp_no" UNIQUE ("emp_no");



-- ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "Employees" ("emp_no");



ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Employee" ADD CONSTRAINT "fk_Dept Employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Dept_Employee" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");



COPY "Titles" (title_id, title)
FROM '/tmp/titles.csv'
DELIMITER ','
CSV HEADER;

COPY "Salaries" (emp_no, salary)
FROM '/tmp/salaries.csv'
DELIMITER ','
CSV HEADER;
	
COPY "Dept_Manager" (dept_no, emp_no)
FROM '/tmp/dept_manager.csv'
DELIMITER ','
CSV HEADER;

COPY "Dept_Employee" (emp_no, dept_no)
FROM '/tmp/dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY "Departments" (dept_no, dept_name)
FROM '/tmp/departments.csv'
DELIMITER ','
CSV HEADER;

COPY "Employees" (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM '/tmp/employees.csv'
DELIMITER ','
CSV HEADER;