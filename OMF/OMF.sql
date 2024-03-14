DROP TABLE IF EXISTS Detail_Order;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS SupplierProducts;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS StaffAccount;
DROP TABLE IF EXISTS Voucher;
DROP TABLE IF EXISTS UserAccount;
DROP TABLE IF EXISTS Accounts;

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
    Mail VARCHAR(50),
	Address VARCHAR(50),
	City VARCHAR(50),
    Phone VARCHAR(20),
    Wallet DECIMAL(10, 2),
    CONSTRAINT UserAccount_FK1 FOREIGN KEY (UserID) REFERENCES Accounts(Username) ON DELETE CASCADE,
    CONSTRAINT UserAccount_FK2 UNIQUE (UserID) -- Add UNIQUE constraint for additional safety
);

Create table Voucher(
	VoucherID Varchar(20) Primary Key,
	VoucherStock Int,
	VoucherPercent Int,
	Username VARCHAR(20),
	FOREIGN KEY (Username) REFERENCES Accounts(Username),
);

CREATE TABLE StaffAccount (
    StaffID VARCHAR(20) PRIMARY KEY,
    Fullname VARCHAR(20),
    Mail VARCHAR(50),
    Phone VARCHAR(20),
    CONSTRAINT StaffAccount_FK1 FOREIGN KEY (StaffID) REFERENCES Accounts(Username) ON DELETE CASCADE,
    CONSTRAINT StaffAccount_FK2 UNIQUE (StaffID) -- Add UNIQUE constraint for additional safety
);

Create table Supplier(
	SupID Varchar(20) Primary Key,
	SupName Varchar(20),
	SupAddress varchar(100),
	SupPhone varchar(20),
	SupTaxID varchar(20),
	SupCountry varchar(50),
	SupContractStatus varchar(20),
	SupNotes text,
	SupPrice Float not null,
	SupType varchar(20) Not null,
);

Create table Products(
	ProID Varchar(20) Primary Key,
	ProStock Int,
	ProName Varchar(100) Not null,
	ProPic Varchar(100) Not null,
	ProDes Varchar(250) Not null,
	ProPrice Float not null,
	ProType varchar(20) Not null,
);

CREATE TABLE Cart(
	CartID VARCHAR(20) PRIMARY KEY,
	Username VARCHAR(20),
	ProID Varchar(20),
	Quality int,
	FOREIGN KEY (ProID) REFERENCES Products(ProID),
	FOREIGN KEY (Username) REFERENCES Accounts(Username)
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
	StaffID varchar(20) NULL,
	Status nvarchar(50) NULL,
	TotalPrice Float NULL,
	VoucherID Varchar(20) NULL,
	VoucherPercent int NULL,
	OrderDate DateTime,
	Constraint OrderIDKey Primary Key (OrderID)
)
ALTER TABLE Orders ADD CONSTRAINT Orders_FK1 FOREIGN KEY(UserID) REFERENCES UserAccount(UserID)
ALTER TABLE Orders ADD CONSTRAINT Orders_FK2 FOREIGN KEY(StaffID) REFERENCES StaffAccount(StaffID)

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
('Thong' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '123'), 2),'Admin', 'https://i.imgur.com/JOKsNeT.jpeg'),
('Huy' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '234'), 2),'Staff', 'https://i.imgur.com/JOKsNeT.jpeg'),
('Phung' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '345'), 2),'User', 'https://i.imgur.com/JOKsNeT.jpeg'),
('Khoi' , CONVERT(VARCHAR(32), HASHBYTES('MD5', '567'), 2),'User', 'https://i.imgur.com/JOKsNeT.jpeg');

INSERT INTO UserAccount (UserID, Fullname, Mail, Address, City, Phone, Wallet) VALUES
('Thong', 'John Doe', 'johndoe@example.com', 'Some Address', 'Some City', '0123456789', 100.00),
('Huy', 'Jane Smith', 'janesmith@example.com', 'Another Address', 'Another City', '9876543210', 150.50);

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
('Pro_10','aRoll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_11','s Roll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_12','v Roll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_13','boll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_14','cc Roll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_15','xxoll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_16','LzRoll','https://i.imgur.com/5cjaTBg.jpg','Plump lobster meat, mayo and crisp lettuce on a toasted bulky roll','12.95','specialty'),
('Pro_17','Red Wine','https://i.imgur.com/zI5C6ia.jpg','A luxurious light wine.','25.0','starters');

INSERT INTO Voucher (VoucherID, VoucherStock, VoucherPercent, Username) VALUES
('V001', 2, 10, 'Thong'),
('V002', 3, 15, 'Huy'),
('V003', 4, 5, 'Huy'),
('V004', 5, 20, 'Thong'),
('V005', 6, 25, 'Huy');


INSERT INTO StaffAccount (StaffID, Fullname, Mail, Phone) VALUES
('Thong', 'Alice Martin', 'alicemartin@example.com', '2223334445'),
('Huy', 'Chris Lee', 'chrislee@example.com', '3334445556');

INSERT INTO Supplier (SupID, SupName, SupAddress, SupPhone, SupTaxID, SupCountry, SupContractStatus, SupNotes, SupPrice, SupType) VALUES
('Sup01', 'Supplier A', 'Address A', '1002003001', 'TAX001', 'Country A', 'Active', 'Notes A', 100.00, 'Type A'),
('Sup02', 'Supplier B', 'Address B', '2003004002', 'TAX002', 'Country B', 'Inactive', 'Notes B', 200.00, 'Type B'),
('Sup03', 'Supplier C', 'Address C', '3004005003', 'TAX003', 'Country C', 'Active', 'Notes C', 300.00, 'Type C'),
('Sup04', 'Supplier D', 'Address D', '4005006004', 'TAX004', 'Country D', 'Inactive', 'Notes D', 400.00, 'Type D'),
('Sup05', 'Supplier E', 'Address E', '5006007005', 'TAX005', 'Country E', 'Active', 'Notes E', 500.00, 'Type E');

INSERT INTO SupplierProducts (SupID, ProID, Quality) VALUES
('Sup01', 'Pro_1', 95),
('Sup02', 'Pro_2', 90),
('Sup03', 'Pro_3', 85),
('Sup04', 'Pro_4', 80),
('Sup05', 'Pro_5', 75);

INSERT INTO Orders (OrderID, UserID, StaffID, Status, TotalPrice, VoucherID, VoucherPercent, OrderDate) VALUES
('Order01', 'Thong', 'Thong', 'Pending', 100.00, 'V001', 10, '2024-01-01'),
('Order02', 'Thong', 'Thong', 'Completed', 200.00, 'V002', 15, '2024-01-02'),
('Order03', 'Thong', 'Thong', 'Shipped', 300.00, 'V003', 5, '2024-01-03'),
('Order04', 'Thong', 'Thong', 'Cancelled', 400.00, 'V004', 20, '2024-01-04'),
('Order05', 'Thong', 'Thong', 'Pending', 500.00, 'V005', 25, '2024-01-05');

INSERT INTO Detail_Order (OrderID, ProID, Quality) VALUES
('Order01', 'Pro_1', 1),
('Order02', 'Pro_2', 2),
('Order03', 'Pro_3', 3),
('Order04', 'Pro_4', 4),
('Order05', 'Pro_5', 5);

SELECT * FROM Accounts
SELECT * FROM UserAccount
select * from Products
select * from Orders
select * from Detail_Order
select * from Voucher
select * from Cart


INSERT INTO Cart VALUES('Thong_Pro_1', 'Thong', 'Pro_1', 10)
INSERT INTO Cart VALUES('Thong_Pro_2', 'Thong', 'Pro_2', 10)
INSERT INTO Cart VALUES('Cart03', 'Huy', 'Pro_2', 10)

UPDATE Cart SET Quality=11  WHERE Username='Thong' AND ProID='Pro_1'
SELECT * FROM Cart WHERE Username='Thong'
SELECT COUNT(*) FROM Cart WHERE Username='Thong'