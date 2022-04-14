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
	ssn	       INTEGER PRIMARY KEY,
	start_date     char(8), --Dates are of the form XX/XX/XX--
	title          char(15),
	hourly_rate    INTEGER,
);
CREATE TABLE Location (
	locID          char(5) PRIMARY KEY,
	address        char(25),
	capacity       INTEGER,
	mgr_ssn        INTEGER,
	num_employees  INTEGER
);
CREATE TABLE Dish (
	dname          char(30) PRIMARY KEY,
	dprice         INTEGER,
	dcalories      INTEGER,
	allergies      char(25) --TODO: modify this so it's a MV attribute--
);
CREATE TABLE Vendor (
	vname          char(15),
	vid            INTEGER PRIMARY KEY
);
CREATE TABLE Ingredient (
	name           char(20) PRIMARY KEY
);
CREATE TABLE Supply (
	vendor_id      INTEGER,
	location_id    char(5),
	ingredient     char(20),
	date_supplied  char(8),
	quantity       INTEGER,
	PRIMARY KEY (vendor_id, location_id, ingredient, date_supplied)
);
CREATE TABLE Allergies (
	dish_name      char(30),
	allergies      char(25),
	PRIMARY KEY (dish_name, allergies)
);
CREATE TABLE Suppliers (
	vendor_id      INTEGER,
	location_id    char(5),
	PRIMARY KEY (vendor_id, location_id)
);
CREATE TABLE DishIngredients (
	dish_name      char(30),
	ingredient     char(20),
	PRIMARY KEY (dish_name, ingredient)
);
CREATE TABLE OnMenu (
	location_id    char(5),
	dish_name      char(30),
	date_added     char(8),
	PRIMARY KEY (location_id, dish_name)
);
CREATE TABLE WorksAt (
	essn           INTEGER,
	location_id    INTEGER,
	PRIMARY KEY (essn, location_id)
);
ALTER TABLE WorksAt
ADD FOREIGN KEY (essn) references Employee(ssn)
Deferrable initially deferred;
--
ALTER TABLE WorksAt
ADD FOREIGN KEY (location_id) references Location(locID)
Deferrable initially deferred;
--
ALTER TABLE Location
ADD FOREIGN KEY (mgr_ssn) references Employee(ssn)
Deferrable initially deferred;
--
ALTER TABLE Supply
ADD FOREIGN KEY (vendor_id) references Vendor(vid)
Deferrable initially deferred;
--
ALTER TABLE Supply
ADD FOREIGN KEY (location_id) references Location(locID)
Deferrable initially deferred;
--
ALTER TABLE Allergies
ADD FOREIGN KEY (dish_name) references Dish(dname)
Deferrable initially deferred;
--
ALTER TABLE Suppliers
ADD FOREIGN KEY (vendor_id) references Vendor(vid)
Deferrable initially deferred;
--
ALTER TABLE Suppliers
ADD FOREIGN KEY (location_id) references Location(locID)
Deferrable initially deferred;
--
ALTER TABLE DishIngredients
ADD FOREIGN KEY (dish_name) references Dish(dname)
Deferrable initially deferred;
--
/*
This causes commit errors, however removing it unlinks the Ingredient table from the rest of the database. Not sure what to do. -Fabian

ALTER TABLE DishIngredients
ADD FOREIGN KEY (ingredient) references Ingredient(name)
Deferrable initially deferred;
*/
--
ALTER TABLE OnMenu
ADD FOREIGN KEY (dish_name) references Dish(dname)
Deferrable initially deferred;
--
ALTER TABLE OnMenu
ADD FOREIGN KEY (location_id) references Location(locID)
Deferrable initially deferred;
--In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.
CONSTRAINT employeePayOverZero CHECK (Employee.hourly_rate > 0);
CONSTRAINT managerPay CHECK (NOT(Employee.title = 'Manager' AND Employee.hourly_rate <= 20));
--
SET FEEDBACK OFF
--< The INSERT statements that populate the tables>
--Important: Keep the number of rows in each table small enough so that the results of your
--queries can be verified by hand. See the Sailors database as an example.
--
--
INSERT INTO Employee VALUES (111111111, '01-14-15', 'Manager', 25, '1');
INSERT INTO Employee VALUES (222222222, '03-22-16', 'Cook', 15, '2');
INSERT INTO Employee VALUES (333333333, '03-08-16', 'Waiter', 10, '2');
INSERT INTO Employee VALUES (444444444, '01-30-15', 'Waiter', 10, '1');
INSERT INTO Employee VALUES (555555555, '03-19-16', 'Manager', 25, '2');
INSERT INTO Employee VALUES (666666666, '01-11-15', 'Cook', 17, '1');
INSERT INTO Employee VALUES (777777777, '05-02-17', 'Hostess', 13, '1');
INSERT INTO Employee VALUES (888888888, '06-15-17', 'Hostess', 12, '2');
--
--
INSERT INTO Location VALUES ('1', '123 Main Street', 100, 111111111, 4);
INSERT INTO Location VALUES ('2', '456 North Avenue', 80, 555555555, 4);
--
--
INSERT INTO Dish VALUES ('Spaghetti Bolognese', 15, 1000, NULL);
INSERT INTO Dish VALUES ('Chicken Alfredo', 20, 1250, NULL);
INSERT INTO Dish VALUES ('Shrimp Pesto', 22, 850, 'Shellfish');
INSERT INTO Dish VALUES ('Thai Peanut Chicken Noodles', 20, 1100, 'Peanut');
INSERT INTO Dish VALUES ('Pasta Primavera', 18, 950, NULL);
--
--
INSERT INTO Vendor VALUES ('Neds Noodles', 1);
INSERT INTO Vendor VALUES ('Martys Meats', 2);
INSERT INTO Vendor VALUES ('Franks Fish', 3);
INSERT INTO Vendor VALUES ('Vinces Veggies', 4);
INSERT INTO Vendor VALUES ('Normans Nuts', 5);
INSERT INTO Vendor VALUES ('Sams Sauces', 6);
--
--
INSERT INTO Ingredient VALUES ('Spaghetti');
INSERT INTO Ingredient VALUES ('Penne');
INSERT INTO Ingredient VALUES ('Fettuccine');
INSERT INTO Ingredient VALUES ('Beef');
INSERT INTO Ingredient VALUES ('Chicken');
INSERT INTO Ingredient VALUES ('Shrimp');
INSERT INTO Ingredient VALUES ('Marinara Sauce');
INSERT INTO Ingredient VALUES ('Alfredo Sauce');
INSERT INTO Ingredient VALUES ('Pesto Sauce');
INSERT INTO Ingredient VALUES ('Mixed Vegetables');
INSERT INTO Ingredient VALUES ('Peanut Sauce');
--
--
INSERT INTO Supply VALUES (1, '1', 'Spaghetti', '01-12-22', 50);
INSERT INTO Supply VALUES (1, '2', 'Spaghetti', '01-12-22', 40);
INSERT INTO Supply VALUES (1, '1', 'Penne', '01-12-22', 50);
INSERT INTO Supply VALUES (1, '2', 'Penne', '01-12-22', 40);
INSERT INTO Supply VALUES (1, '1', 'Fettuccine', '01-12-22', 50);
INSERT INTO Supply VALUES (1, '2', 'Fettuccine', '01-12-22', 40);
INSERT INTO Supply VALUES (2, '1', 'Beef', '01-25-22', 25);
INSERT INTO Supply VALUES (2, '2', 'Beef', '01-25-22', 20);
INSERT INTO Supply VALUES (2, '1', 'Chicken', '01-25-22', 25);
INSERT INTO Supply VALUES (2, '2', 'Chicken', '01-25-22', 20);
INSERT INTO Supply VALUES (3, '1', 'Shrimp', '01-27-22', 25);
INSERT INTO Supply VALUES (3, '2', 'Shrimp', '01-27-22', 20);
INSERT INTO Supply VALUES (6, '1', 'Marinara Sauce', '01-16-22', 60);
INSERT INTO Supply VALUES (6, '2', 'Marinara Sauce', '01-16-22', 50);
INSERT INTO Supply VALUES (6, '1', 'Pesto Sauce', '01-16-22', 48);
INSERT INTO Supply VALUES (6, '2', 'Pesto Sauce', '01-16-22', 38);
INSERT INTO Supply VALUES (6, '1', 'Alfredo Sauce', '01-16-22', 60);
INSERT INTO Supply VALUES (6, '2', 'Alfredo Sauce', '01-16-22', 50);
INSERT INTO Supply VALUES (5, '1', 'Peanut Sauce', '01-19-22', 45);
INSERT INTO Supply VALUES (5, '2', 'Peanut Sauce', '01-19-22', 35);
INSERT INTO Supply VALUES (4, '1', 'Mixed Vegetables', '01-26-22', 50);
INSERT INTO Supply VALUES (4, '2', 'Mixed Vegetables', '01-26-22', 40);
--
--
INSERT INTO Allergies VALUES ('Shrimp Pesto', 'Shellfish');
INSERT INTO Allergies VALUES ('Thai Peanut Chicken Noodles', 'Peanut');
--
--
INSERT INTO Suppliers VALUES (1, '1');
INSERT INTO Suppliers VALUES (1, '2');
INSERT INTO Suppliers VALUES (2, '1');
INSERT INTO Suppliers VALUES (2, '2');
INSERT INTO Suppliers VALUES (3, '1');
INSERT INTO Suppliers VALUES (3, '2');
INSERT INTO Suppliers VALUES (4, '1');
INSERT INTO Suppliers VALUES (4, '2');
INSERT INTO Suppliers VALUES (5, '1');
INSERT INTO Suppliers VALUES (5, '2');
INSERT INTO Suppliers VALUES (6, '1');
INSERT INTO Suppliers VALUES (6, '2');
--
--
INSERT INTO DishIngredients VALUES ('Spaghetti Bolognese', 'Spaghetti');
INSERT INTO DishIngredients VALUES ('Spaghetti Bolognese', 'Beef');
INSERT INTO DishIngredients VALUES ('Spaghetti Bolognese', 'Marinara Sauce');
INSERT INTO DishIngredients VALUES ('Chicken Alfredo', 'Fettuccine');
INSERT INTO DishIngredients VALUES ('Chicken Alfredo', 'Chicken');
INSERT INTO DishIngredients VALUES ('Chicken Alfredo', 'Alfredo');
INSERT INTO DishIngredients VALUES ('Shrimp Pesto', 'Penne');
INSERT INTO DishIngredients VALUES ('Shrimp Pesto', 'Shrimp');
INSERT INTO DishIngredients VALUES ('Shrimp Pesto', 'Pesto');
INSERT INTO DishIngredients VALUES ('Thai Peanut Chicken Noodles', 'Spaghetti');
INSERT INTO DishIngredients VALUES ('Thai Peanut Chicken Noodles', 'Chicken');
INSERT INTO DishIngredients VALUES ('Thai Peanut Chicken Noodles', 'Peanut Sauce');
INSERT INTO DishIngredients VALUES ('Pasta Primavera', 'Penne');
INSERT INTO DishIngredients VALUES ('Pasta Primavera', 'Mixed Vegetables');
--
--
INSERT INTO OnMenu VALUES ('1', 'Spaghetti Bolognese', '01-31-15');
INSERT INTO OnMenu VALUES ('1', 'Chicken Alfredo', '01-31-15');
INSERT INTO OnMenu VALUES ('1', 'Shrimp Pesto', '01-31-15');
INSERT INTO OnMenu VALUES ('1', 'Thai Peanut Chicken Noodles', '01-31-15');
INSERT INTO OnMenu VALUES ('1', 'Pasta Primavera', '01-31-15');
INSERT INTO OnMenu VALUES ('2', 'Spaghetti Bolognese', '03-25-15');
INSERT INTO OnMenu VALUES ('2', 'Chicken Alfredo', '03-25-15');
INSERT INTO OnMenu VALUES ('2', 'Shrimp Pesto', '03-25-15');
INSERT INTO OnMenu VALUES ('2', 'Thai Peanut Chicken Noodles', '03-25-15');
INSERT INTO OnMenu VALUES ('2', 'Pasta Primavera', '03-25-15');
--
SET FEEDBACK ON
COMMIT;
--< One query (per table) of the form: SELECT * FROM table; in order to display your database >
SELECT * from Employee;
SELECT * from Dish;
SELECT * from Vendor;
SELECT * from Location;
SELECT * FROM Ingredient;
SELECT * FROM Supply;
SELECT * FROM Allergies;
SELECT * FROM Suppliers;
SELECT * FROM OnMenu;
SELECT * FROM DishIngredients;
--
/*< The SQL queries>. Include the following for each query:
− A comment line stating the query number and the feature(s) it demonstrates
(e.g. -- Q25 – correlated subquery).
− A comment line stating the query in English.
− The SQL code for the query */
--
-- Q1 - A join involving at least four relations.
-- Select the location id, location address, and employee ssn of location that were supplied by 'Neds Noodles'.
SELECT DISTINCT L.locID, L.address
FROM   Employee E, Location L, Vendor V, Suppliers S
WHERE  E.location_id = L.locID AND L.locID = S.location_id AND S.vendor_id = V.vid AND V.vname = 'Neds Noodles';
--
--
-- Q2 - A self-join.
-- Select non equals pairs of ingredients that were supplied to Location 2 where ingredient 1 was supplied on 01-12-22 and has a lower quantity that ingredient 2.
SELECT DISTINCT S1.ingredient, S2.ingredient
FROM Supply S1, Supply S2
WHERE S1.location_id = '2' AND S2.location_id = '2' AND S1.ingredient != S2.ingredient AND S1.quantity < S2.quantity AND S1.date_supplied = '01-12-22'
ORDER BY S1.ingredient;
--
--
-- Q3 - UNION, INTERSECT, and/or MINUS.
-- Select all employees with an hourly rate above 15 and don't work at location 2.
SELECT E.ssn
FROM   Employee E
WHERE  E.hourly_rate > 15
MINUS
SELECT E.ssn
FROM   Employee E
WHERE  E.location_id = '2';
-- Q4 - SUM, AVG, MAX, and/or MIN.
-- Select the sum of the calories of all dishs that include the 'Penne' ingredient.
SELECT SUM(D.dcalories) AS "Total Calories of Penne dishes"
FROM   Dish D, DishIngredients I
WHERE  D.dname = I.dish_name AND I.ingredient = 'Penne';
-- Q5 - GROUP BY, HAVING, and ORDER BY, all appearing in the same query.
-- Select the name and price of all dishes that have more than 2 ingredients and order them by price.
SELECT D.dname, D.dprice
FROM   Dish D, DishIngredients I
WHERE  D.dname = I.dish_name
GROUP BY D.dname, D.dprice
HAVING COUNT(*) > 2
ORDER BY D.dprice;
-- Q6 - A correlated subquery.
-- Select the ssn of each employee who has the highest salary in their restaurant
SELECT E1.ssn
FROM Employee E1
WHERE E1.hourly_rate = 
	(SELECT MAX(E2.hourly_rate)
	 FROM Employee E2
	 WHERE E1.location_id = E2.location_id)
ORDER BY E1.ssn;
-- Q7 - A non-correlated subquery.
-- Select the dish name of all dishes that do not rely on ingredients being supplied by Martys Meats.
SELECT D.dname, D.dprice
FROM Dish D
WHERE D.dname NOT IN
	(SELECT D.dname
	 FROM Dish D, DishIngredients DI, Supply Sup, Suppliers S, Vendor V
	 WHERE D.dname = DI.dish_name AND DI.ingredient = Sup.ingredient AND Sup.vendor_id = S.vendor_id AND 
	       S.vendor_id = V.vid AND V.vname = 'Martys Meats')
ORDER BY D.dname;
-- Q8 - A relational DIVISION query.
-- Q9 - An outer join query.
--
/*< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).
− A comment line stating: Testing: < IC name>
− A SQL INSERT, DELETE, or UPDATE that will test the IC.*/
--
--
-- Testing: employeePayOverZero
INSERT INTO Employee Values(111111112, '08/08/08', 'Line Cook', 0, 12345);

-- Testing: managerPay
INSERT INTO Employee Values(222222223, '07/07/07', 'Manager', 19, 12345);
COMMIT;
--
SPOOL OFF
