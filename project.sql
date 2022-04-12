SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
Casey Systema
David Geisel
Fabian Kirberg
Lin Hao Yuan
*/

--< The SQL/DDL code that creates your schema >
CREATE TABLE Employee (
	ssn	       char(9) PRIMARY KEY,
	start_date     char(8), --Dates are of the form XX/XX/XX--
	title          char(15),
	hourly_rate    number(2)
)
CREATE TABLE Location (
	locID          char(5) PRIMARY KEY,
	address        char(25),
	capacity       number(3)
)
CREATE TABLE Dish (
	dname          char(15) PRIMARY KEY,
	dprice         number(3),
	dcalories      number(4),
	allergies      char(25) --TODO: modify this so it's a MV attribute--
)
CREATE TABLE Vendor (
	vname          char(15),
	vid            number(5) PRIMARY KEY
)
--In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.
CONSTRAINT employeePayOverZero CHECK (Employee.hourly_rate > 0);
CONSTRAINT managerPay CHECK (NOT(Employee.title = 'Manager' AND Employee.hourly_rate <= 20));

--
SET FEEDBACK OFF

--< The INSERT statements that populate the tables>
--Important: Keep the number of rows in each table small enough so that the results of your
--queries can be verified by hand. See the Sailors database as an example.

SET FEEDBACK ON
COMMIT;
--

--< One query (per table) of the form: SELECT * FROM table; in order to display your database >
SELECT * from Employee;
SELECT * from Dish;
SELECT * from Vendor;
SELECT * from Location;
--
/*< The SQL queries>. Include the following for each query:
− A comment line stating the query number and the feature(s) it demonstrates
(e.g. -- Q25 – correlated subquery).
− A comment line stating the query in English.
− The SQL code for the query.
--
< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).
− A comment line stating: Testing: < IC name>
− A SQL INSERT, DELETE, or UPDATE that will test the IC.*/

COMMIT;
--
SPOOL OFF
