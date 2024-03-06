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
	AccPic Varchar(100) Not null,
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



insert into Accounts (Username, Password, Role, AccPic)
Values
('Thong' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '123'), 2),'Admin', https://i.imgur.com/JOKsNeT.jpeg),
('Huy' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '234'), 2),'User', https://i.imgur.com/JOKsNeT.jpeg),
('Phung' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '345'), 2),'User', https://i.imgur.com/JOKsNeT.jpeg),
('Khoi' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '567'), 2),'User', https://i.imgur.com/JOKsNeT.jpeg);

insert into Products(ProID, ProName, ProPic ,ProDes, ProPrice, ProType)
values
('Pro_1','Lobster Bisque','https://i.imgur.com/zc55clt.jpg','Lorem, deren, trataro, filede, nerada','5.95','starters'),
('Pro_2','Bread Barrel','https://i.imgur.com/yicFuFS.jpg','Lorem, deren, trataro, filede, nerada','6.95','specialty'),
('Pro_3','Crab Cake','https://i.imgur.com/VkZat6d.jpg','A delicate crab cake served on a toasted roll with lettuce and tartar sauce','7.95','starters'),
('Pro_4','Caesar Selections','https://i.imgur.com/Xql8ge7.jpg','Lorem, deren, trataro, filede, nerada','8.95','salads'),
('Pro_5','Tuscan Grilled','https://i.imgur.com/HYc0syV.jpg','Grilled chicken with provolone, artichoke hearts, and roasted red pesto','9.95','specialty'),
('Pro_6','Mozzarella Stick','https://i.imgur.com/r2Y9Da5.jpg','Lorem, deren, trataro, filede, nerada','4.95','starters'),
('Pro_7','Greek Salad','https://i.imgur.com/7E357qW.jpg','Fresh spinach, crisp romaine, tomatoes, and Greek olives','9.95','salads'),
('Pro_8','Spinach Salad','https://i.imgur.com/TzKIyxe.jpg','Fresh spinach with mushrooms, hard boiled egg, and warm bacon vinaigrette','9.95','salads'),
('Pro_9','Lobster Roll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_10','Red Wine','https://i.imgur.com/zI5C6ia.jpg','A luxurious light wine.','25.0','starters');

INSERT INTO Orders (OrderID, Username, Status, TotalPrice) VALUES 
('Order_1', 'Hoa', 'Confirming', 10000),
('Order_2', 'Tan', 'Delivered', 1500),
('Order_3', 'Tan', 'Delivered', 900),
('Order_4', 'Thong', 'Delivering', 5000),
('Order_5', 'Thong', 'Confirmed', 2000);

INSERT INTO Detail_Order (OrderID, ProID, Quality) VALUES 
('Order_1', 'Pro_1', 2),
('Order_1', 'Pro_2', 2),
('Order_1', 'Pro_6', 2),
('Order_2', 'Pro_3', 1),
('Order_2', 'Pro_1', 1),
('Order_3', 'Pro_2', 3),
('Order_3', 'Pro_1', 3),
('Order_4', 'Pro_5', 2),
('Order_4', 'Pro_8', 2),
('Order_5', 'Pro_4', 1);

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