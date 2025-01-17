CREATE DATABASE PRACTICE8;
USE PRACTICE8;
CREATE TABLE Employee
(
	EmployeeID INT PRIMARY KEY,
	FirstName VARCHAR(20) DEFAULT NULL,
	LastName VARCHAR(20) DEFAULT NULL,
	Salary NUMERIC DEFAULT NULL,
	JoiningDate DATETIME DEFAULT NULL,
	Department VARCHAR(20) DEFAULT NULL,
	ManagerID INT DEFAULT NULL
);
DROP TABLE Employee;
CREATE TABLE Incentives
(
	EmployeeRefID INT FOREIGN KEY REFERENCES Employee(EmployeeID),
	IncentiveDate DATE,
	IncentiveAmount NUMERIC
);
DROP TABLE Incentives;
INSERT INTO Employee VALUES(1,'John','Abraham',1000000,'2013-01-01 00:00:00','Banking',NULL);
INSERT INTO Employee VALUES(2,'Michale','Clarke',800000,'2013-01-01 00:00:00','Insurance',1);
INSERT INTO Employee VALUES(3,'Roy','Thomas',700000,'2013-02-01 00:00:00','Banking',1);
INSERT INTO Employee VALUES(4,'Tom','Jose',600000,'2013-02-01 00:00:00','Insurance',2);
INSERT INTO Employee VALUES(5,'Jerry','Pinto',650000,'2013-02-01 00:00:00','Insurance',3);
INSERT INTO Employee VALUES(6,'Philip','Mathew',750000,'2013-01-01 00:00:00','Service',3);
INSERT INTO Employee VALUES(7,'TestName1','123',650000,'2013-01-01 00:00:00','Service',2);
INSERT INTO Employee VALUES(8,'TestName2','Lname%',600000,'2013-02-01 00:00:00','Insurance',2);
SELECT * FROM Employee;
INSERT INTO Incentives VALUES(1,'2013-02-01',5000);
INSERT INTO Incentives VALUES(2,'2013-02-01',3000);
INSERT INTO Incentives VALUES(3,'2013-02-01',4000);
INSERT INTO Incentives VALUES(1,'2013-01-01',4500);
INSERT INTO Incentives VALUES(2,'2013-01-01',3500);
DROP TABLE Employee
SELECT * FROM Incentives;
DROP TABLE Incentives
-->1 Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table
SELECT *, DATEDIFF(DAY,e.JoiningDate ,i.IncentiveDate) AS DATEDIFFERNCE FROM Employee e FULL OUTER JOIN Incentives i ON e.EmployeeID = i.EmployeeRefID;
-->2 Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000
SELECT e.FirstName,i.IncentiveAmount FROM Employee e RIGHT JOIN Incentives i ON e.EmployeeID = i.EmployeeRefID WHERE i.IncentiveAmount > 3000;
-->3 Select first_name, incentive amount from employee and incentives table for all employees even if they didn�t get incentives.
SELECT e.FirstName,i.IncentiveAmount FROM Employee e LEFT JOIN Incentives i ON e.EmployeeID = i.EmployeeRefID;
-->4 Select EmployeeName, ManagerName from the employee table.
SELECT M.EmployeeID,M.FirstName,E.EmployeeID,E.FirstName FROM Employee M JOIN Employee E ON M.EmployeeID = E.ManagerID
-->5 Select first_name, incentive amount from employee and incentives table for all employees even if they didn�t get incentives and set incentive amount as 0 for those employees who didn�t get incentives.
SELECT  ISNULL(i.IncentiveAmount,0),* FROM Incentives i RIGHT JOIN Employee e ON e.EmployeeID = i.EmployeeRefID ;





