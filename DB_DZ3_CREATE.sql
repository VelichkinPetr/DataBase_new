USE `seschool_03`;

/*
## Задача №1

### Часть №1
Создайте таблицу `ZootopiaCharacters`, которая будет хранить информацию о персонажах мультфильма "Зверополис".
*/

CREATE TABLE IF NOT EXISTS `ZootopiaCharacters`(
	`CharacterID` INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`CharacterName` VARCHAR(75) UNIQUE NOT NULL,
	`Species`VARCHAR(25) NOT NULL,
	`Role` ENUM ('Главный герой', 'Антагонист', 'Второстепенный персонаж') DEFAULT 'Второстепенный персонаж' NOT NULL ,
	`Occupation` VARCHAR(100),
	`Catchphrase` TINYTEXT
);


/*
### Часть №2

Вам необходимо добавить 10 записей в таблицу `ZootopiaCharacters`.
*/

INSERT INTO `ZootopiaCharacters` (`CharacterName`, `Species`, `Role`, `Occupation`, `Catchphrase`)
VALUES 
		('Judy Hopps', 'Кролик', 'Главный герой', 'Полицейский','Сначала попробуй!'),
		('Nick Wilde', 'Лиса', 'Главный герой', 'Полицейский', 'Скользкий как лиса!'),
		('Chief Bogo', 'Буйвол','Второстепенный персонаж', 'Шеф полиции', NULL),
		('Bellwether', 'Овца', 'Антагонист', 'Мэр', NULL),
		('Flash', 'Ленивец', 'Второстепенный персонаж', 'Сотрудник DMV', NULL),
		('Mr. Big', 'Полярный медведь', 'Второстепенный персонаж', 'Босс мафии', 'Твое слово — мое слово'),
		('Finnick', 'Лиса', 'Второстепенный персонаж', 'Мошенник', NULL),
		('Clawhauser', 'Гепард', 'Второстепенный персонаж', 'Сотрудник полиции', 'Добро пожаловать в Зверополис!'),
		('Duke Weaselton', 'Ласка', 'Второстепенный персонаж', 'Контрабандист', NULL),
		('Yax', 'Як', 'Второстепенный персонаж', 'Управляющий спа-салоном', NULL);


/*
## Задача №3

Вам необходимо создать две связанные таблицы: одну таблицу для хранения информации о клиентах и другую таблицу для хранения информации об их заказах. 
Связь между таблицами должна быть организована по принципу "один ко многим": один клиент может иметь много заказов, но каждый заказ может принадлежать только одному клиенту.
*/

CREATE TABLE IF NOT EXISTS `Customers`(
	`CustomerID` INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`FirstName` VARCHAR(100) NOT NULL,
	`LastName` VARCHAR(100) NOT NULL,
	`Email` VARCHAR(150),
	`PhoneNumber` VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Orders`(
	`OrderID` INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`OrderDate` DATETIME NOT NULL,
	`TotalAmount` DECIMAL(10, 2) NOT NULL,
	`CustomerID` INTEGER UNSIGNED NOT NULL,
	
	CONSTRAINT fk_Orders_Customers
	FOREIGN KEY (`CustomerID`)
	REFERENCES `Customers`(`CustomerID`)
);

