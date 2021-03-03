USE SampleDB
GO

SELECT * FROM Customers
GO

SELECT * FROM Products

CREATE TABLE Sales(
	SalesId int CONSTRAINT PKSalesID PRIMARY KEY,
	ProductID int CONSTRAINT FKProductID FOREIGN KEY REFERENCES Products(ProductID),
	CustomerID int CONSTRAINT FKCustomerID FOREIGN KEY REFERENCES Customers(CustID),
	ShopLocation varchar(50) CONSTRAINT CHKLocation CHECK(ShopLocation IN('AHMEDABAD', 'MUMBAI', 'CALCUTTA'))
)

SELECT * FROM Sales

ALTER TABLE Customers ADD ContactNo int CONSTRAINT CHKContactNo CHECK(ContactNo LIKE '[6-9][0-9][0-9][0-9]')

ALTER TABLE Customers ADD Age int CONSTRAINT CHKAge CHECK(Age BETWEEN 18 AND 80)

ALTER TABLE Customers DROP COLUMN CustAddress

ALTER TABLE Customers ADD CustAddress varchar(50) CONSTRAINT CHKCustAddress CHECK(CustAddress IN('AHMEDABAD', 'MUMBAI', 'CALCUTTA')) 
CONSTRAINT CHKDefAddress DEFAULT 'Ahmedabad'

ALTER TABLE Products ADD ProdQty varchar(50) CONSTRAINT CHKProdQty CHECK(ProdQty BETWEEN 0 AND 100) CONSTRAINT DefQty DEFAULT 0

INSERT INTO Products VALUES (4, 'Rope', 2.00, 'Long Rope', DEFAULT)
