-- Запросы к задаче 1

-- Задача №2.1 Выберите имена всех персонажей и их профессии.
SELECT ZC.CharacterName,ZC.Species FROM `ZootopiaCharacters` AS ZC;


-- Задача №2.2 Выберите имена персонажей, вид которых — "Лиса".
SELECT ZC.CharacterName FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Species = 'Лиса';

-- Задача №2.3 Выберите имена персонажей, у которых вид — "Кролик" или "Буйвол".
SELECT ZC.CharacterName FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Species IN ('Кролик', 'Буйвол');

-- Задача №2.4 Выберите три первых персонажа по алфавиту, у которых указана профессия.
SELECT * FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Occupation IS NOT NULL 
	ORDER BY ZC.CharacterName
	LIMIT 3;

-- Задача №2.5 Выберите всех персонажей с уникальными профессиями, отсортировав их по роли в обратном алфавитном порядке.
SELECT * FROM `ZootopiaCharacters` AS ZC
	GROUP BY ZC.Occupation
	ORDER BY ZC.`Role` DESC ;
	
-- Задача №2.6 Выберите персонажей, чьи имена содержат букву "a", отсортировав их по имени в порядке убывания.
SELECT * FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.CharacterName LIKE '%a%'
	ORDER BY ZC.CharacterName DESC ;
	
-- Задача №2.7 Выберите все уникальные роли персонажей и отсортируйте их в алфавитном порядке
SELECT DISTINCT ZC.`Role` FROM `ZootopiaCharacters` AS ZC
	ORDER BY ZC.`Role`;
	
-- Задача №2.8 Выберите 5 первых персонажей, у которых есть известная фраза отсортированных по имени в алфавитном порядке.
SELECT * FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Catchphrase IS NOT NULL
	ORDER BY ZC.CharacterName
	LIMIT 5 ;
	
-- Задача №2.9 Найдите третьего по счету персонажа по алфавиту, чей вид — "Кролик".
SELECT * FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Species = 'Кролик'
	ORDER BY ZC.CharacterName
	LIMIT 1
	OFFSET 2 ;
	
-- Задача №2.10 Посчитайте количество персонажей в таблице.
SELECT COUNT(*) AS `количество персонажей в таблице` FROM `ZootopiaCharacters` AS ZC;

-- Задача №2.10 Посчитайте количество персонажей для каждой роли.
SELECT COUNT(*) AS `количество персонажей для каждой роли` FROM `ZootopiaCharacters` AS ZC
	GROUP BY ZC.`Role`;
	
-- Задача №2.11 Выведите количество персонажей для каждой профессии
SELECT COUNT(*) AS `количество персонажей для каждой профессии` FROM `ZootopiaCharacters` AS ZC
	GROUP BY ZC.Occupation;
	
-- Задача №2.12 Выведите профессии и количество персонажей в каждой профессии, отсортированные по количеству в порядке убывания.
SELECT ZC.Occupation , COUNT(*) AS `количество персонажей для каждой профессии` FROM `ZootopiaCharacters` AS ZC
	GROUP BY ZC.Occupation
	ORDER BY `количество персонажей для каждой профессии` DESC ;
	
-- Задача №2.13 Посчитайте количество персонажей для каждого вида, у которых роль — "Главный герой".
SELECT COUNT(*) AS `количество персонажей для каждого вида` FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.`Role` = 'Главный герой'
	GROUP BY ZC.Species;
	
-- Задача №2.14 Выберите имена персонажей и их профессии, но только тех, у кого профессия уникальна среди всех персонажей.
SELECT ZC.CharacterName, ZC.Occupation FROM `ZootopiaCharacters` AS ZC
	GROUP BY ZC.Occupation;
	
-- Задача №2.15 Выберите 5 последних персонажей по алфавиту, чья профессия указана.
SELECT * FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Occupation IS NOT NULL 
	ORDER BY ZC.CharacterName
	LIMIT 5 
	OFFSET 5;
	
-- Задача №2.16 Посчитайте количество персонажей для каждой профессии, но только для тех профессий, где количество персонажей больше 1. 
-- Отсортируйте результат по имени профессии в алфавитном порядке.
SELECT ZC.Occupation , COUNT(*) AS `количество персонажей для каждой профессии` FROM `ZootopiaCharacters` AS ZC
	GROUP BY ZC.Occupation
	HAVING `количество персонажей для каждой профессии` > 1
	ORDER BY ZC.Occupation;
	
-- Задача №2.17 Посчитайте количество персонажей для каждого вида, но только тех, у кого профессия не указана. 
-- Отсортируйте результат по количеству в порядке убывания и ограничьте вывод тремя записями
SELECT ZC.Species , COUNT(*) AS `количество персонажей для каждого вида` FROM `ZootopiaCharacters` AS ZC
	WHERE ZC.Occupation IS NULL 
	GROUP BY ZC.Species
	ORDER BY `количество персонажей для каждого вида` DESC 
	LIMIT 3;