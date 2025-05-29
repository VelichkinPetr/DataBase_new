-- 1. **Найти всех пользователей, которые сделали заказ и оставили отзыв с оценкой выше 4.**

SELECT * FROM `Users`
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
	INNER JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
WHERE `Report`.`score` > 4;

-- 2. **Найти пользователей, которые сделали заказ на сумму больше 1000 рублей, и вывести их имя и возраст.**

SELECT U.`Name`, U.`Age` FROM `Users` AS U
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
WHERE `Order`.`sum_order` > 1000
GROUP BY `Order`.`Id_User`;

-- 3. **Вывести список всех заказов с указанием имени пользователя, который сделал заказ.**

SELECT O.`Id`, `User`.`Name` FROM `Order` AS O
	INNER JOIN `Users` ON `User`.`Id_User` = `Order`.`Id_User`;

-- 4. **Найти пользователей, которые оставили более одного отзыва, и вывести их имя и страну.**

SELECT U.`Name`, U.`Country` FROM `Users` AS U
	INNER JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
GROUP BY `User`.`Id`
HAVING COUNT(*) > 1;	

-- 5. **Вывести все заказы пользователей, которые оставили хотя бы один отзыв с оценкой ниже 3.**

SELECT `Order`.`Id` FROM `Users`
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
	INNER JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
WHERE `Report`.`score` < 3
GROUP BY `User`.`Id`
HAVING COUNT(*) >= 1;	

-- 6. **Найти всех пользователей, которые сделали заказы после 1 сентября 2024 года, и их отзывы.**

SELECT `Users`.`Id`,`Report`.`Text` FROM `Users`
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
	INNER JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
WHERE `Order`.`date` > '01-09-2024';
	
-- 7. **Найти среднюю сумму заказов для каждого пользователя, который сделал хотя бы один заказ.**

SELECT AVG(`Order`.`sum_order`) FROM `Users`
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
GROUP BY `Users`.`Id`;

-- 8. **Вывести список всех пользователей из России, которые сделали заказы и оставили отзывы с оценкой выше 3.**

SELECT * FROM `Users`
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
	INNER JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
WHERE `Report`.`score` > 3 AND `User`.`Country` = 'Россия'
GROUP BY `User`.`Id`;

-- 9. **Найти пользователей, которые никогда не оставляли отзывов, и вывести их имена.**
SELECT `Users`.`Name` FROM `Users`
	LEFT JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
WHERE `Report`.`Id` IS NULL;

-- 10. **Вывести все отзывы пользователей, которые сделали заказ на сумму меньше 2000 рублей.**

SELECT `Report`.`Text` FROM `Users`
	INNER JOIN `Order` ON `Order`.`Id_User` = `User`.`Id`
	INNER JOIN `Report` ON `Report`.`Id_User` = `User`.`Id`
WHERE `Order`.`sum_order` < 2000;