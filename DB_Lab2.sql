USE `seschool_03`;

-- 1
SELECT * FROM `students_table` AS st
	WHERE st.`пол` = 'ж';
	
-- 2
SELECT * FROM `students_table` AS st
	WHERE st.`Курс` = 3;
	
-- 3
SELECT * FROM `students_table` AS st
	WHERE st.`Дата рождения` > '1994-02-03';
	
-- 4
SELECT * FROM `students_table` AS st
	WHERE st.`Средний балл` >= 70 AND st.`Средний балл` <= 85; 
	
SELECT * FROM `students_table` AS st
	WHERE st.`Средний балл` BETWEEN 70 AND 85; 
	
-- 5
SELECT * FROM `students_table` AS st
	WHERE st.`Курс` = 2 or st.`Курс` = 3; 

SELECT * FROM `students_table` AS st
	WHERE st.`Курс` IN (2,3); 
	
-- 6
SELECT * FROM `students_table` AS st
	WHERE st.`Фамилия` LIKE 'С%' or st.`Фамилия` LIKE 'К%'; 
	
-- 7
SELECT * FROM `students_table` AS st
	WHERE st.`Группа` LIKE 'АУС-%'; 
	
-- 8
SELECT * FROM `students_table` AS st
	WHERE st.`Хобби` IS NULL; 
	
-- 9
SELECT st.`Курс` FROM `students_table` AS st
	GROUP BY st.`Курс`; 

-- 10
SELECT * FROM `students_table` AS st
	ORDER BY st.`Средний балл`  
	LIMIT 5
	OFFSET 10;

-- 11
SELECT * FROM `students_table` AS st
	ORDER BY st.`Средний балл` DESC, st.`Фамилия` DESC
	LIMIT 10
	OFFSET 5;

-- 12
SELECT COUNT(*) AS `число всех студентов`,
		 (COUNT(*) - COUNT(st.`Хобби`)) AS `число всех студентов, не имеющих хобби`,
		 MAX(st.`Средний балл`) AS `максимальное значение среднего балла`,
		 MIN(st.`Средний балл`) AS `минимальное значение среднего балла`,
		 AVG(st.`Средний балл`) AS `среднее по всем студентам значение среднего балла`
FROM `students_table` AS st;

-- 13
SELECT st.`Курс`, COUNT(*) AS `число студентов` 
FROM `students_table` AS st
	GROUP BY st.`Курс`;

-- 14
SELECT st.`пол`, AVG(st.`Средний балл`) AS `Средний балл`
FROM `students_table` AS st
	GROUP BY st.`пол`;

-- 15
SELECT MAX(st.`Средний балл`) AS `максимальный балл среди студентов третьего курса, рожденных не ранее 1993 года`
FROM `students_table` AS st
	WHERE st.`Курс`= 3 AND st.`Дата рождения` >= '1993-01-01';

-- 16
SELECT st.`Фамилия`,
 	 CASE 
        WHEN st.`Средний балл` BETWEEN 90 AND 100 THEN 'Отлично' 
        WHEN st.`Средний балл` BETWEEN 76 AND 89.9 THEN 'Хорошо' 
        WHEN st.`Средний балл` BETWEEN 61.0 AND 75.9 THEN 'Удовлетворительно' 
        ELSE 'Неудовлетворительно' 
    END AS `оценка по пятибалльной системе`
FROM `students_table` AS st;

		