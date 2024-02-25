DROP TABLE IF EXISTS Detail_Order;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS SupplierProducts;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS StaffAccount;
DROP TABLE IF EXISTS UserAccount;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Voucher;

Create table Voucher(
	VoucherID Varchar(20),
	VoucherStock Int,
	VoucherPercent Int,
	Constraint VoucherIDKey Primary Key (VoucherID)
);

CREATE TABLE Accounts (
    Username VARCHAR(20) PRIMARY KEY,
    Password VARCHAR(32) NOT NULL,
    Role VARCHAR(32) NOT NULL,
    UNIQUE (Username) -- Add UNIQUE constraint for additional safety
);

CREATE TABLE UserAccount (
    UserID VARCHAR(20) PRIMARY KEY,
    Fullname VARCHAR(20),
    Mail VARCHAR(20),
    Phone VARCHAR(20),
    Wallet DECIMAL(10, 2),
    VoucherID VARCHAR(20),
    CONSTRAINT UserAccount_FK1 FOREIGN KEY (UserID) REFERENCES Accounts(Username) ON DELETE CASCADE,
    CONSTRAINT UserAccount_FK2 UNIQUE (UserID) -- Add UNIQUE constraint for additional safety
);

CREATE TABLE StaffAccount (
    StaffID VARCHAR(20) PRIMARY KEY,
    Fullname VARCHAR(20),
    Mail VARCHAR(20),
    Phone VARCHAR(20),
    CONSTRAINT StaffAccount_FK1 FOREIGN KEY (StaffID) REFERENCES Accounts(Username) ON DELETE CASCADE,
    CONSTRAINT StaffAccount_FK2 UNIQUE (StaffID) -- Add UNIQUE constraint for additional safety
);

Create table Supplier(
	SupID Varchar(20),
	SupName Varchar(20),
	SupAddress varchar(100),
	SupPhone varchar(20),
	SupTaxID varchar(20),
	SupCountry varchar(50),
	SupContractStatus varchar(20),
	SupNotes text,
	SupPrice Float not null,
	SupType varchar(20) Not null,
	Constraint SupplierIDKey Primary Key (SupID),
);

Create table Products(
	ProID Varchar(20),
	ProStock Int,
	ProName Varchar(100) Not null,
	ProPic Varchar(100) Not null,
	ProDes Varchar(250) Not null,
	ProPrice Float not null,
	ProType varchar(20) Not null,
	Constraint ProIDKey Primary Key (ProID)
);

Create table SupplierProducts(
	SupID Varchar(20),
	ProID Varchar(20),
	Quality int,
	Constraint SupplierProductsKey Primary Key (SupID,ProID)
);
ALTER TABLE SupplierProducts ADD CONSTRAINT SupplierProducts_FK1 FOREIGN KEY(SupID) REFERENCES Supplier(SupID)
ALTER TABLE SupplierProducts ADD CONSTRAINT SupplierProducts_FK2 FOREIGN KEY(ProID) REFERENCES Products(ProID)

CREATE TABLE Orders(
	OrderID varchar(20),
	UserID varchar(20),
	StaffID varchar(20),
	Status nvarchar(50) NULL,
	TotalPrice Float NULL,
	VoucherID Varchar(20),
	OrderDate DateTime,
	Constraint OrderIDKey Primary Key (OrderID)
)
ALTER TABLE Orders ADD CONSTRAINT Orders_FK1 FOREIGN KEY(UserID) REFERENCES UserAccount(UserID)
ALTER TABLE Orders ADD CONSTRAINT Orders_FK2 FOREIGN KEY(StaffID) REFERENCES StaffAccount(StaffID)
ALTER TABLE Orders ADD CONSTRAINT Orders_FK3 FOREIGN KEY(VoucherID) REFERENCES Voucher(VoucherID)

CREATE TABLE Detail_Order(
	OrderID varchar(20),
	ProID Varchar(20),
	Quality int,
	Constraint Detail_OrderKey Primary Key (OrderID,ProID)
)
ALTER TABLE Detail_Order ADD CONSTRAINT Detail_Order_FK1 FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
ALTER TABLE Detail_Order ADD CONSTRAINT Detail_Order_FK2 FOREIGN KEY(ProID) REFERENCES Products(ProID)


insert into Accounts (Username, Password, Role)
Values
('Thong' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '123'), 2),'Admin'),
('Huy' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '234'), 2),'User'),
('Phung' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '345'), 2),'User'),
('Khoi' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '567'), 2),'User');

insert into SupplierProducts (SupID, ProID, Quality)
Values
('S01', 'P01', 1000),
('S02', 'P02', 1000),
('S03', 'P03', 1000),
('S04', 'P04', 1000);


SELECT * FROM Accounts
select * from Products
select * from Orders
select * from Detail_Order

drop table Detail_Order
drop table Orders
drop tABLE Products
drop table Accounts

SELECT * FROM Detail_Order WHERE OrderID='Order_1'
SELECT * FROM Detail_Order WHERE ProID='Pro_1'