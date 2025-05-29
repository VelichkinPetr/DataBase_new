INSERT INTO `categories` VALUES 
(1, 'Категория 1'),
(2, 'Категория 2'),
(3, 'Категория 3');

INSERT INTO `products` VALUES 

(1, 'Продукт A', 1, 50.00),
(2, 'Продукт B', 1, 30.00),
(3, 'Продукт C', 2, 20.00),
(4, 'Продукт D', 2, 70.00),
(5, 'Продукт E', 3, 100.00);


-- 1. Найти все продукты, цена которых выше средней цены всех продуктов.
SELECT `products`.product_name FROM `products`
	WHERE `products`.price > (SELECT AVG(`products`.price) FROM `products`);
	
-- 2. Найти все категории, в которых хотя бы один продукт имеет цену выше 100.
SELECT category_name FROM `categories`
	INNER JOIN `products` ON `products`.category_id = `categories`.category_id 
	WHERE `products`.price > 100
	GROUP BY `categories`.category_id;

-- 3. Вывести название продукта и количество продуктов в его категории.
SELECT `products`.product_name, `count`.`count` FROM `products`
INNER JOIN 
			(SELECT COUNT(*) AS `count`, `categories`.category_id FROM `categories`
				INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
				GROUP BY `categories`.category_id) AS `count`
ON `products`.category_id = `count`.category_id;

-- 4. Найти продукты, чья цена выше средней цены продуктов в их категории.
SELECT `products`.product_name FROM `products`
INNER JOIN 
				(SELECT AVG(`products`.price) AS `avg`, `categories`.category_id FROM `categories`
					INNER JOIN `products` ON `products`.category_id = `categories`.category_id
					GROUP BY `categories`.category_id) AS `categories_price`
ON `products`.category_id = `categories_price`.category_id
WHERE `products`.price > `categories_price`.`avg`;

-- 5. Найти категории, в которых средняя цена продуктов выше средней цены по всем продуктам.
SELECT `categories`.category_name FROM `categories`

INNER JOIN (SELECT `products`.category_id, AVG(`products`.price) AS `avg` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `categories`.category_id = `categories_price`.category_id

INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
WHERE (SELECT AVG(`products`.price) FROM `products`) < `categories_price`.`avg`;

-- 6. Найти название категории и самую дорогую цену продукта в этой категории.
SELECT `categories`.category_name, `categories_price`.`max`   FROM `categories`

INNER JOIN (SELECT `products`.category_id, MAX(`products`.price) AS `max` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `categories`.category_id = `categories_price`.category_id;

-- 7. Найти продукты, чья цена является самой высокой в своей категории.
SELECT `products`.`product_name` FROM `products`

INNER JOIN (SELECT `products`.`product_id`, MAX(`products`.price) AS `max` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
					
ON `products`.`price` = `categories_price`.`max`;

-- 8. Найти категории, в которых количество продуктов больше среднего количества продуктов по всем категориям.
SELECT `categories`.category_name FROM `categories`

INNER JOIN (SELECT `products`.category_id, COUNT(`products`.price) AS `count` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `categories`.category_id = `categories_price`.category_id

WHERE `count` > (SELECT AVG(`categories_price`.`count`) FROM (SELECT `products`.category_id, COUNT(`products`.price) AS `count` FROM `products`
					GROUP BY `products`.category_id) AS categories_price);
					
-- 9. Вывести продукты, цена которых выше средней цены всех продуктов в своей категории.
SELECT `products`.product_name FROM `products`
INNER JOIN 
				(SELECT AVG(`products`.price) AS `avg`, `categories`.category_id FROM `categories`
					INNER JOIN `products` ON `products`.category_id = `categories`.category_id
					GROUP BY `categories`.category_id) AS `categories_price`
ON `products`.category_id = `categories_price`.category_id
WHERE `products`.price > `categories_price`.`avg`;

-- 10. Найти категории, где самая низкая цена продукта выше средней цены по всем продуктам.
SELECT `categories`.category_name FROM `categories`

INNER JOIN (SELECT `products`.category_id, MIN(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `categories`.category_id = `categories_price`.category_id

WHERE `categories_price`.`min` > (SELECT AVG(`products`.price) FROM `products`);

-- 11. Найти продукты, цена которых ниже минимальной цены в любой категории.
SELECT `products`.product_name FROM `products`
INNER JOIN (SELECT `products`.category_id, MIN(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `products`.category_id = `categories_price`.category_id
WHERE `products`.price < (SELECT MIN(`categories_price`.`min`) FROM (SELECT `products`.category_id, MIN(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price);
					
-- 12. Найти категорию, в которой самое большое количество продуктов.
SELECT `categories`.category_name FROM `categories`
	INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
GROUP BY `categories`.category_id

HAVING COUNT(*) = (
	SELECT MAX(`categories_price`.`count`) FROM (SELECT COUNT(*) AS `count`, `categories`.category_id FROM `categories`
	INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
	GROUP BY `categories`.category_id) AS categories_price
	)
	;

-- 13. Найти продукты, которые дешевле самого дешевого продукта в другой категории.
SELECT `products`.product_name FROM `products`
INNER JOIN (SELECT `products`.category_id, MIN(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `products`.category_id = `categories_price`.category_id
WHERE `products`.price < (SELECT MIN(`categories_price`.`min`) FROM (SELECT `products`.category_id, MIN(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price) ;
					
-- 14. Найти категории, где количество продуктов меньше, чем в категории с минимальным количеством продуктов.
SELECT `categories`.category_name FROM `categories`
	INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
	GROUP BY `categories`.category_id
HAVING COUNT(*)< (
						SELECT MIN(`categories_price`.`count`) FROM (SELECT COUNT(*) AS `count`, `categories`.category_id FROM `categories`
						INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
						GROUP BY `categories`.category_id) AS categories_price);

-- 15. Найти продукты, чья цена больше средней цены в категориях с более чем 5 продуктами.
SELECT * FROM `products`
INNER  JOIN 
				(SELECT `categories`.category_id FROM `categories`
				INNER  JOIN `products` ON `products`.category_id = `categories`.category_id
				GROUP BY `categories`.category_id
				HAVING COUNT(*) > 5) AS categories_with_5
ON `products`.category_id = `categories_with_5`.`category_id`

INNER JOIN 
				(SELECT AVG(`products`.price) AS `avg`, `categories`.category_id FROM `categories`
					INNER JOIN `products` ON `products`.category_id = `categories`.category_id
					GROUP BY `categories`.category_id) AS `categories_price`
ON `products`.category_id = `categories_price`.category_id

WHERE `products`.price > `categories_price`.`avg`;

-- 16. Найти категории, в которых максимальная цена продукта больше 200.

SELECT `categories`.category_name FROM `categories`
					INNER JOIN `products` ON `products`.category_id = `categories`.category_id
					GROUP BY `categories`.category_id
					HAVING MAX(`products`.price) > 200;
					
-- 17. Найти продукты, которые дороже всех продуктов в другой категории.
SELECT `products`.product_name FROM `products`
INNER JOIN (SELECT `products`.category_id, MIN(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price
ON `products`.category_id = `categories_price`.category_id
WHERE `products`.price > (SELECT MAX(`categories_price`.`min`) FROM (SELECT `products`.category_id, MAX(`products`.price) AS `min` FROM `products`
					GROUP BY `products`.category_id) AS categories_price) ;
					
-- 18. Найти категории, в которых средняя цена всех продуктов больше 150.
SELECT `categories`.category_name FROM `categories`
					INNER JOIN `products` ON `products`.category_id = `categories`.category_id
					GROUP BY `categories`.category_id
					HAVING AVG(`products`.price) > 150;
					
-- 19. Найти продукты, чья цена ниже минимальной цены в их категории, умноженной на 2.
SELECT `products`.product_name FROM `products`
INNER JOIN 
				(SELECT MIN(`products`.price) AS `min`, `categories`.category_id FROM `categories`
					INNER JOIN `products` ON `products`.category_id = `categories`.category_id
					GROUP BY `categories`.category_id) AS `categories_price`
ON `products`.category_id = `categories_price`.category_id
WHERE `products`.price < `categories_price`.`min` * 2;

-- 20. Найти категории, где количество продуктов выше среднего, а средняя цена ниже средней по всем категориям.
SELECT `categories`.category_name, `count`,  `categories_avg`.`avg` FROM `categories`

INNER JOIN ( SELECT `products`.category_id, COUNT(`products`.price) AS `count` FROM `products`
					GROUP BY `products`.category_id ) AS categories_count
ON `categories`.category_id = `categories_count`.category_id

INNER JOIN ( SELECT AVG(`products`.price) AS `avg`, `categories`.category_id FROM `categories`
												INNER JOIN `products` ON `products`.category_id = `categories`.category_id
												GROUP BY `categories`.category_id ) AS `categories_avg`
ON `categories`.category_id = `categories_avg`.category_id

WHERE `count` > ( SELECT AVG(`categories_price`.`count`) FROM 
							(SELECT `products`.category_id, COUNT(`products`.price) AS `count` FROM `products`
							 GROUP BY `products`.category_id) AS categories_price )

AND  `categories_avg`.`avg` < ( SELECT AVG(`categories_avg`.`avg`) FROM 
																							(SELECT AVG(`products`.price) AS `avg`, `categories`.category_id FROM `categories`
																							 INNER JOIN `products` ON `products`.category_id = `categories`.category_id
																							 GROUP BY `categories`.category_id) AS `categories_avg` ) 