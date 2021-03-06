-- database company
CREATE DATABASE company;

-- TAbles
-- employee table
CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

-- branch table

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(20),
    mgr_id INT,
    mgr_start_date,
    FOREIGN KEY(mgr_id) REFERENCES epmloyee(empi_id) ON DELETE SET NULL
);

-- relation of employee table and branch table by foreign key 

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(empi_id) ON DELETE SET NULL;

-- client table

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(20),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- works_with table the relationship table

CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id,client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- branch_ supplier table

CREATE TABLE branch_supplier(
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id,supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- insertion of values to the tables 

INSERT INTO employee VALUES(100,'David','wallece','1967-11-17','M',25000,NULL,Null);

INSERT INTO branch VALUES(1,'Corporate',100,'2006-02-09');

UPDATE employee 
SET branch_id=1
WHERE emp_id=100;

INSERT INTO employee VALUES(101,'Jan','Levison','1961-05-11','F',11000,100,1);

-- Scranton

INSERT INTO employee VALUES(102,'Michael','Scott','1964-03-15','M',75000,100,NULL);
INSERT INTO branch VALUES(2,'Scranton',102,'1992-04-06');

UPDATE employee
SET branch_id=2
WHERE emp_id=102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford

INSERT INTO employee VALUES(106,'Josh','Potter','1969-09-05','M',75000,100,NULL);
INSERT INTO branch VALUES(3,'Stamford',106,'1998-02-13');

UPDATE employee
SET branch_id=3
WHERE emp_id=106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- -- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- -- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- -- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- task 1 find all employees

SELECT * FROM employee;

-- tas2 final all clients

SELECT * FROM client;

-- Task to find all employee order by salary

SELECT * FROM employee ORDER BY salary;

-- order by salary in descinding order

SELECT * FROM employee ORDER BY salary DESC;

-- TASk find all employees orderd by SEX and name

SELECT * FROM employee ORDER BY sex,first_name,last_name;

-- TASK find first_name and last_name of all salary

SELECT first_name,last_name from employee;

-- TAsk find the forename and surname of all employee `branch`

SELECT first_name AS forename , last_name AS surname FROM employee;

-- TASK  to find different genders using DISTINCT keyword

SELECT DISTINCT sex FROM employee;


-- TAsk to find different branch_id from employee table

SELECT DISTINCT branch_id FROM employee;


-- ---------------------------------------------------------------   FUNCTIONS    ------------------------------------------------------------------------------

-- COUNT FUNC()
-- TASK Find the number of employees 

SELECT COUNT(emp_id) FROM employee;

-- TAsk to find number of supervisor in emplyoee;

SElECT COUNT(super_id) FROM employee;

-- TASk to find number of female employee born after 1970 `branch`

SELECT COUNT(emp_id) FROM employee WHERE sex='F' AND birth_day >'1970-01-01';

-- AVG FUNC()
-- TASK tol find the avg of salary of all the employee
SELECT AVG(salary) FROM employee;

-- TASK to find avg of salary of all male `employee'

SELECT AVG(salary) FROM employee WHERE sex='M';


-- SUM () FUNCTION ()

SELECT SUM(salary) FROM employee;

-- TASK to find how many males and females there are

SELECT COUNT(sex),sex FROM employee GROUP BY sex;


-- ------------------------ AGGREGATION -------------------------------

-- TASK to find how many males and females there are

SELECT COUNT(sex),sex FROM employee GROUP BY sex;


-- TAsk to find the tootal sales of salesman 

SELECT SUM(total_Sales),emp_id FROM works_with GROUP BY emp_id;

-- TAsk to find how much each client has spent

SELECT SUM(total_sales),client_id FROM works_with GROUP BY client_id;



------------------------------------- WILD CARDS ---------------------------------------

-- % = any character , _ = one character

-- TAsk to find any clients who are LLC

SELECT * FROM client WHERE client_name LIKE '%LLC';

-- TAsk to find any branch supplier who are in Label businnes

SElECT * FROM branch_supplier WHERE supplier_name LIKE '% Label%';

-- TAsk to find any employee born in October

SELECT * FROM employee WHERE birth_day LIKE '____-10%';

-- TAsk to find any employee born in feb

SELECT * FROM employee WHERE birth_day LIKE '____-02%';

--Task to find any clients who are schools 

SELECT * FROM client WHERE client_name LIKE '%school%';

-- --------------------------------------------- UNIONS -----------------------------
-- in sql UNION is a special operator USED to combine two or more SELECT statements 

-- TAsk to find list of all employee and branch names 

SELECT first_name  AS company_names FROM employee UNION SELECT branch_name FROM branch;

-- find a list of all clients and `branch_supplier` 

SELECT client_name,branch_id FROM client  UNION SELECT supplier_name,branch_id FROM branch_supplier;

-- rule
-- 1 same number of columns
-- 2 similar Datatype 

SELECT client_name,client.branch_id From client UNION SELECT supplier_name,branch_supplier.branch_id FROM branch_supplier; --recommended 

-- Task  to find a list of all money spent or caused by company `branch`

SELECT salary FROM employee UNION SELECT total_sales FROM works_with;

-- ---------------------------------------------- JOINS --------------------------------------
-- Join is basically used to combine two or more rows of differenttables on related columns

INSERT INTO branch VALUES(4,'Buffalo',NULL,NULL);

-- 4 TYPES of JOINS 
-- 1. General JOIN - Inner JOIN
-- 2.LEFT JOIN
-- 3. RIGHT JOIN
-- 4. OUTER JOIN 

-- GENERAL JOIN -JOIN ON (coloumns)

-- TAsk to find all branches and the names of their managers

SELECT employee.emp_id,employee.first_name,branch.branch_name
FROM employee -- left tabble
JOIN branch  -- right table
ON employee.emp_id=branch.mgr_id;  -- clause


-- LEFT JOIN ON

-- TAsk to find all branches and names of their managers

SELECT employee.emp_id,employee.first_name,branch.branch_name 
FROM employee -- left table
LEFT JOIN branch -- right table
ON employee.emp_id=branch.mgr_id;

-- RIGHT JOIN ON 

-- TAsk to find all branches and names of thier names

SELECT employee.emp_id,employee.first_name,branch.branch_name 
FROM employee 
RIGHT JOIN branch 
ON employee.emp_id=branch.mgr_id;

-- ------------------------------------------ NESTED QUERIES ------------------------------------------------

-- multiple SELECT STATEMENTS ;
-- using IN keyword

-- TAsk to find names of all employees who have sold over 30,000 to a single client 

SELECT employee.first_name AS forename,employee.last_name AS surname
FROM employee 
WHERE employee.emp_id IN(
    SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales>30000
);

-- TAsk to find all Cllients who are handeled by the `branch`
-- that michael Scott Manages
-- Assume you know MIchales ID

-- STEP 1

SELECT branch.branch_id FROM branch WHERE branch.mgr_id=102;

-- STEP 2

SELECT client.client_name FROM client 
WHERE client.branch_id=(
    SELECT branch.branch_id FROM branch WHERE branch.mgr_id=102
    LIMIT 1
);


-- --------------------------------------------- ON DELETE -------------------------------------------------------

-- CREATE TABLE branch(
--     branch_id INT PRIMARY KEY,
--     branch_name VARCHAR(40),
--     mgr_id INT,
--     mgr_start_date Date,
--     FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
-- )

-- DELETEING ENTRIES WHEN WE HAVE FOREGIN KEY LINKED UP 

-- TYPES OF ON DELETE
-- ON DELETE SET NULL
-- ON DELETE CASADE


-- FOREGIN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

DELETE FROM employee WHERE emp_id=102; -- sets mgr id = null in branch when deleted in employee;

SELECT * FROM branch; -- results affected

SELECT * FROM employee;

-- ON DELETE CASCADE
-- is used to delete a row based on relation on foregin key

-- CREATE TABLE branch_supplier(
--     branch_id INT,
--     supplier_name VARCHAR(40),
--     supply_type VARCHAR(40),
--     PRIMARY KEY(branch_id,supplier_name), -- composite key
--     FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
-- );

DELETE FROM branch WHERE branch_id=2;  

-- deleteing the branch with branch_id =2 affects the branch supplier as branch supplier is connected to the branch table

SELECT * FROM branch_supplier;
