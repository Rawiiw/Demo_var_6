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
('Суслов', 'Илья', 'Арсентьевич', 'pixil59@gmail.com', '2L6KZG', 1),
('Яковлева', 'Ярослава', 'Даниэльевна', 'deummecillummu-4992@mail.ru', 'uzWC67', 1),
('Игнатьева', 'Алина', 'Михайловна', 'vilagajaunne-5170@yandex.ru', '8ntwUp', 1);


INSERT INTO [User] (UserSurname, UserName, UserPatronymic, UserLogin, UserPassword, UserRole)
VALUES
('Денисов', 'Михаил', 'Романович', 'frusubroppotou656@yandex.ru', 'YOyhfR', 2),
('Тимофеев', 'Михаил', 'Елисеевич', 'leuttevitrafo1998@mail.ru', 'RSbvHv', 2),
('Соловьев', 'Ярослав', 'Маркович', 'frapreubrulloba1141@yandex.ru', 'rwVDh9', 2);


INSERT INTO [User] (UserSurname, UserName, UserPatronymic, UserLogin, UserPassword, UserRole)
VALUES
('Филимонов', 'Роберт', 'Васильевич', 'loudittoimmolau1900@gmail.com', 'LdNyos', 3),
('Шилова', 'Майя', 'Артемьевна', 'hittuprofassa4984@mail.com', 'gynQMT', 3),
('Чистякова', 'Виктория', 'Степановна', 'freineiciweijau888@yandex.ru', 'AtnDjr', 3),
('Волкова', 'Эмилия', 'Артёмовна', 'nokupekidda2001@gmail.com', 'JlFRCZ', 3);

-- Вставка данных в таблицу "Order"
INSERT INTO [Order] (OrderStatus, OrderDeliveryDate, OrderPickupPoint)
VALUES
('Новый', CONVERT(datetime, '1996-04-15', 120), '25'),
('Новый', CONVERT(datetime, '1996-04-15', 120), '20'),
('Завершен', CONVERT(datetime, '1996-04-15', 120), '22'),
('Завершен', CONVERT(datetime, '1996-04-15', 120), '24'),
('Завершен', CONVERT(datetime, '1996-04-15', 120), '25'),
('Завершен', CONVERT(datetime, '1996-04-15', 120), '28'),
('Новый', CONVERT(datetime, '1996-04-15', 120), '36'),
('Новый', CONVERT(datetime, '1996-04-15', 120), '32'),
('Новый', CONVERT(datetime, '1996-04-15', 120), '34'),
('Завершен', CONVERT(datetime, '1996-04-15', 120), '36');


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
('344288', 'Нефтеюганск', 'ул. Чехова', '1'),
('614164', 'Нефтеюганск', 'ул. Степная', '30'),
('394242', 'Нефтеюганск', 'ул. Коммунистическая', '43'),
('660540', 'Нефтеюганск', 'ул. Солнечная', '25'),
('125837', 'Нефтеюганск', 'ул. Шоссейная', '40'),
('125703', 'Нефтеюганск', 'ул. Партизанская', '49'),
('625283', 'Нефтеюганск', 'ул. Победы', '46'),
('614611', 'Нефтеюганск', 'ул. Молодежная', '50'),
('454311', 'Нефтеюганск', 'ул. Новая', '19'),
('660007', 'Нефтеюганск', 'ул. Октябрьская', '19'),
('603036', 'Нефтеюганск', 'ул. Садовая', '4'),
('450983', 'Нефтеюганск', 'ул. Комсомольская', '26'),
('394782', 'Нефтеюганск', 'ул. Чехова', '3'),
('603002', 'Нефтеюганск', 'ул. Дзержинского', '28'),
('450558', 'Нефтеюганск', 'ул. Набережная', '30'),
('394060', 'Нефтеюганск', 'ул. Фрунзе', '43'),
('410661', 'Нефтеюганск', 'ул. Школьная', '50'),
('625590', 'Нефтеюганск', 'ул. Коммунистическая', '20'),
('625683', 'Нефтеюганск', 'ул. 8 Марта', NULL), 
('400562', 'Нефтеюганск', 'ул. Зеленая', '32'),
('614510', 'Нефтеюганск', 'ул. Маяковского', '47'),
('410542', 'Нефтеюганск', 'ул. Светлая', '46'),
('620839', 'Нефтеюганск', 'ул. Цветочная', '8'),
('443890', 'Нефтеюганск', 'ул. Коммунистическая', '1'),
('603379', 'Нефтеюганск', 'ул. Спортивная', '46'),
('603721', 'Нефтеюганск', 'ул. Гоголя', '41'),
('410172', 'Нефтеюганск', 'ул. Северная', '13'),
('420151', 'Нефтеюганск', 'ул. Вишневая', '32'),
('125061', 'Нефтеюганск', 'ул. Подгорная', '8'),
('630370', 'Нефтеюганск', 'ул. Шоссейная', '24'),
('614753', 'Нефтеюганск', 'ул. Полевая', '35'),
('426030', 'Нефтеюганск', 'ул. Маяковского', '44'),
('450375', 'Нефтеюганск', 'ул. Клубная', '44'),
('625560', 'Нефтеюганск', 'ул. Некрасова', '12'),
('630201', 'Нефтеюганск', 'ул. Комсомольская', '17'),
('190949', 'Нефтеюганск', 'ул. Мичурина', '26');



INSERT INTO [Order] (OrderStatus, OrderDeliveryDate, OrderPickupPoint, DeliveryPointID)
VALUES
('Новый', CONVERT(datetime, '1996-04-15', 120), '25', 1), 

('Новый', CONVERT(datetime, '1996-04-15', 120), '20', 2), 

('Завершен', CONVERT(datetime, '1996-04-15', 120), '22', 3),

('Завершен', CONVERT(datetime, '1996-04-15', 120), '24', 4), 

('Завершен', CONVERT(datetime, '1996-04-15', 120), '25', 5), 

('Завершен', CONVERT(datetime, '1996-04-15', 120), '28', 6), 

('Новый', CONVERT(datetime, '1996-04-15', 120), '36', 7),

('Новый', CONVERT(datetime, '1996-04-15', 120), '32', 8),

('Новый', CONVERT(datetime, '1996-04-15', 120), '34', 9), 

('Завершен', CONVERT(datetime, '1996-04-15', 120), '36', 10); 

