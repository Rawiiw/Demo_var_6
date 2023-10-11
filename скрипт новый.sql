create database [Trade]
go
use [Trade]
go
create table [Role]
(
	RoleID int primary key identity,
	RoleName nvarchar(100) not null
)
go
create table [User]
(
	UserID int primary key identity,
	UserSurname nvarchar(100) not null,
	UserName nvarchar(100) not null,
	UserPatronymic nvarchar(100) not null,
	UserLogin nvarchar(max) not null,
	UserPassword nvarchar(max) not null,
	UserRole int foreign key references [Role](RoleID) not null
)
go
create table [Order]
(
	OrderID int primary key identity,
	OrderStatus nvarchar(max) not null,
	OrderDeliveryDate datetime not null,
	OrderPickupPoint nvarchar(max) not null
)
go
create table Product
(
	ProductArticleNumber nvarchar(100) primary key,
	ProductName nvarchar(max) not null,
	ProductDescription nvarchar(max) not null,
	ProductCategory nvarchar(max) not null,
	ProductPhoto image not null,
	ProductManufacturer nvarchar(max) not null,
	ProductCost decimal(19,4) not null,
	ProductDiscountAmount tinyint null,
	ProductQuantityInStock int not null,
	ProductStatus nvarchar(max) not null,
)
go
create table OrderProduct
(
	OrderID int foreign key references [Order](OrderID) not null,
	ProductArticleNumber nvarchar(100) foreign key references Product(ProductArticleNumber) not null,
	Primary key (OrderID,ProductArticleNumber)
)


INSERT INTO [User] (UserSurname, UserName, UserPatronymic, UserLogin, UserPassword, UserRole)
VALUES
('������', '����', '�����������', 'pixil59@gmail.com', '2L6KZG', 1),
('��������', '��������', '�����������', 'deummecillummu-4992@mail.ru', 'uzWC67', 1),
('���������', '�����', '����������', 'vilagajaunne-5170@yandex.ru', '8ntwUp', 1);


INSERT INTO [User] (UserSurname, UserName, UserPatronymic, UserLogin, UserPassword, UserRole)
VALUES
('�������', '������', '���������', 'frusubroppotou656@yandex.ru', 'YOyhfR', 2),
('��������', '������', '���������', 'leuttevitrafo1998@mail.ru', 'RSbvHv', 2),
('��������', '�������', '��������', 'frapreubrulloba1141@yandex.ru', 'rwVDh9', 2);


INSERT INTO [User] (UserSurname, UserName, UserPatronymic, UserLogin, UserPassword, UserRole)
VALUES
('���������', '������', '����������', 'loudittoimmolau1900@gmail.com', 'LdNyos', 3),
('������', '����', '����������', 'hittuprofassa4984@mail.com', 'gynQMT', 3),
('���������', '��������', '����������', 'freineiciweijau888@yandex.ru', 'AtnDjr', 3),
('�������', '������', '��������', 'nokupekidda2001@gmail.com', 'JlFRCZ', 3);

-- ������� ������ � ������� "Order"
INSERT INTO [Order] (OrderStatus, OrderDeliveryDate, OrderPickupPoint)
VALUES
('�����', CONVERT(datetime, '1996-04-15', 120), '25'),
('�����', CONVERT(datetime, '1996-04-15', 120), '20'),
('��������', CONVERT(datetime, '1996-04-15', 120), '22'),
('��������', CONVERT(datetime, '1996-04-15', 120), '24'),
('��������', CONVERT(datetime, '1996-04-15', 120), '25'),
('��������', CONVERT(datetime, '1996-04-15', 120), '28'),
('�����', CONVERT(datetime, '1996-04-15', 120), '36'),
('�����', CONVERT(datetime, '1996-04-15', 120), '32'),
('�����', CONVERT(datetime, '1996-04-15', 120), '34'),
('��������', CONVERT(datetime, '1996-04-15', 120), '36');


CREATE TABLE DeliveryPoint
(
    PointID INT PRIMARY KEY IDENTITY,
    PostalCode NVARCHAR(20) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Street NVARCHAR(100) NOT NULL,
    HouseNumber NVARCHAR(10),
    CONSTRAINT UC_DeliveryPoint UNIQUE (PostalCode, City, Street, HouseNumber)
);


ALTER TABLE [Order]
ADD DeliveryPointID INT FOREIGN KEY REFERENCES DeliveryPoint(PointID);


INSERT INTO DeliveryPoint (PostalCode, City, Street, HouseNumber)
VALUES
('344288', '�����������', '��. ������', '1'),
('614164', '�����������', '��. �������', '30'),
('394242', '�����������', '��. ����������������', '43'),
('660540', '�����������', '��. ���������', '25'),
('125837', '�����������', '��. ���������', '40'),
('125703', '�����������', '��. ������������', '49'),
('625283', '�����������', '��. ������', '46'),
('614611', '�����������', '��. ����������', '50'),
('454311', '�����������', '��. �����', '19'),
('660007', '�����������', '��. �����������', '19'),
('603036', '�����������', '��. �������', '4'),
('450983', '�����������', '��. �������������', '26'),
('394782', '�����������', '��. ������', '3'),
('603002', '�����������', '��. ������������', '28'),
('450558', '�����������', '��. ����������', '30'),
('394060', '�����������', '��. ������', '43'),
('410661', '�����������', '��. ��������', '50'),
('625590', '�����������', '��. ����������������', '20'),
('625683', '�����������', '��. 8 �����', NULL), 
('400562', '�����������', '��. �������', '32'),
('614510', '�����������', '��. �����������', '47'),
('410542', '�����������', '��. �������', '46'),
('620839', '�����������', '��. ���������', '8'),
('443890', '�����������', '��. ����������������', '1'),
('603379', '�����������', '��. ����������', '46'),
('603721', '�����������', '��. ������', '41'),
('410172', '�����������', '��. ��������', '13'),
('420151', '�����������', '��. ��������', '32'),
('125061', '�����������', '��. ���������', '8'),
('630370', '�����������', '��. ���������', '24'),
('614753', '�����������', '��. �������', '35'),
('426030', '�����������', '��. �����������', '44'),
('450375', '�����������', '��. �������', '44'),
('625560', '�����������', '��. ���������', '12'),
('630201', '�����������', '��. �������������', '17'),
('190949', '�����������', '��. ��������', '26');



INSERT INTO [Order] (OrderStatus, OrderDeliveryDate, OrderPickupPoint, DeliveryPointID)
VALUES
('�����', CONVERT(datetime, '1996-04-15', 120), '25', 1), 

('�����', CONVERT(datetime, '1996-04-15', 120), '20', 2), 

('��������', CONVERT(datetime, '1996-04-15', 120), '22', 3),

('��������', CONVERT(datetime, '1996-04-15', 120), '24', 4), 

('��������', CONVERT(datetime, '1996-04-15', 120), '25', 5), 

('��������', CONVERT(datetime, '1996-04-15', 120), '28', 6), 

('�����', CONVERT(datetime, '1996-04-15', 120), '36', 7),

('�����', CONVERT(datetime, '1996-04-15', 120), '32', 8),

('�����', CONVERT(datetime, '1996-04-15', 120), '34', 9), 

('��������', CONVERT(datetime, '1996-04-15', 120), '36', 10); 

