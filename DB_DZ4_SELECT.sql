USE `seschool_03`;

-- Простая сложность (7 задач)**

-- 1. Выберите имена и фамилии всех студентов, которые были зачислены в 2022 году.
SELECT s.first_name, s.last_name FROM `Students` AS  s
	WHERE s.enrollment_year = 2022;
	
-- 2. Выберите названия и количество кредитов всех курсов, которые читаются преподавателем 'Dr. Smith'.
SELECT c.course_name, SUM(c.credit_hours) AS `sum` FROM `Courses` AS c
	WHERE c.instructor = 'Dr. Smith';
	
-- 3. Найдите имена и фамилии всех студентов, которые записаны на курс с названием 'Mathematics'.
SELECT s.first_name, s.last_name FROM `Students` AS  s
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = s.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.course_name = 'Mathematics';

-- 4. Посчитайте количество студентов, записанных на курс с названием 'Physics'.
SELECT COUNT(*) FROM `Enrollments`
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.course_name = 'Physics';

-- 5. Выберите все курсы, на которые записан студент с фамилией 'Johnson'.
SELECT `Courses`.course_name FROM `Students` AS  s
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = s.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE s.last_name = 'Johnson';

-- 6. Найдите имена студентов и названия курсов, на которые они записаны, с оценками.
SELECT s.first_name,`Courses`.course_name, `Enrollments`.grade  FROM `Students` AS  s
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = s.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id;
	
-- 7. Выберите названия всех курсов и их преподавателей, которые имеют более 3 кредитных часов.
SELECT `Courses`.course_name, `Courses`.instructor FROM `Courses`
	WHERE `Courses`.credit_hours > 3;

-- Средняя сложность (13 задач)**

-- 1. Найдите всех студентов, записанных на курсы, преподаваемые 'Dr. Brown'.

SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.instructor = 'Dr. Brown';
	
-- 2. Найдите названия курсов и количество студентов на каждом из них.
SELECT course_name, COUNT(`Enrollments`.student_id) FROM `Courses`
	INNER JOIN `Enrollments` ON `Enrollments`.course_id = `Courses`.course_id
GROUP BY `Courses`.course_id;
	
-- 3. Найдите студентов, записанных на курсы 'Biology' и 'Chemistry'.
SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.course_name IN ('Biology' , 'Chemistry');	

-- 4. Найдите курсы, на которые записаны все студенты с фамилией 'Smith'.
SELECT `Courses`.course_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Students`.last_name = 'Smith';
	
-- 5. Найдите студентов и их оценки по курсам с более чем 4 кредитными часами.
SELECT first_name, last_name, `Enrollments`.grade FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.credit_hours > 4;
	
-- 6. Найдите всех студентов, записанных на курсы, которые начинаются с буквы 'M'.
SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.course_name LIKE 'M%';

-- 7. Найдите названия курсов и среднюю оценку по каждому курсу.
SELECT course_name, AVG(`Enrollments`.grade) FROM `Courses`
	INNER JOIN `Enrollments` ON `Enrollments`.course_id = `Courses`.course_id
GROUP BY `Courses`.course_id;

-- 8. Найдите всех студентов, у которых есть хотя бы одна оценка 'A'.
SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
WHERE `Enrollments`.grade = 'A'
GROUP BY `Students`.student_id;

-- 9. Найдите всех преподавателей, которые преподают более одного курса.
SELECT `Courses`.instructor FROM  `Courses`
	GROUP BY `Courses`.instructor
	HAVING COUNT(*) > 1;
	
-- 10. Найдите всех студентов, которые записаны на курсы с оценкой ниже 'C'.
SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
WHERE `Enrollments`.grade < 'C'
GROUP BY `Students`.student_id;

-- 11. Найдите курсы, на которые записаны более 50 студентов.
SELECT `Courses`.course_name FROM  `Courses`
	INNER JOIN `Enrollments` ON `Enrollments`.course_id = `Courses`.course_id
GROUP BY `Enrollments`.course_id
HAVING COUNT(*) > 50;

-- 12. Найдите студентов, которые записаны на наибольшее количество курсов.
SELECT first_name, last_name FROM `Students`
	 INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
GROUP BY `Students`.student_id
ORDER BY COUNT(*)
LIMIT 1;

-- 13. Найдите все курсы, которые преподавались за последние 5 лет.

-- 14. Найдите студентов, которые никогда не получали оценку ниже 'B'.
SELECT first_name, last_name FROM `Students`
WHERE `Students`.first_name NOT IN 
	(SELECT first_name FROM `Students`
	 INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	 WHERE `Enrollments`.grade = 'C');
	 
-- Большая сложность (10 задач)**

-- 1. Найдите студентов, которые записаны на все курсы, которые читаются 'Dr. Brown', без использования подзапросов.
SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Courses`.instructor = 'Dr.Brown';

-- 2. Найдите курсы, на которые никто не записался, без использования подзапросов.
SELECT course_name FROM `Courses`
	LEFT JOIN `Enrollments` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Enrollments`.course_id IS NULL;

-- 3. Найдите студентов, которые записаны на курсы, которые имеют более одного преподавателя, без использования подзапросов.
-- XZ
	 
-- 4. Найдите курсы, которые преподают несколько преподавателей, и количество студентов на каждом из этих курсов, без использования подзапросов.
-- XZ

-- 5. Найдите студентов, которые получили самую высокую оценку в своем классе, без использования подзапросов.
-- XZ

-- 6. Найдите студентов, которые записаны на менее чем 2 курса, без использования подзапросов.
SELECT first_name, last_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	GROUP BY `Students`.student_id
	HAVING COUNT(*) < 2;
	
-- 7. Найдите курсы, на которые записаны студенты, зачисленные в 2022 году, без использования подзапросов.
SELECT `Courses`.course_name FROM `Students`
	INNER JOIN `Enrollments` ON `Enrollments`.student_id = `Students`.student_id
	INNER JOIN `Courses` ON `Enrollments`.course_id = `Courses`.course_id
WHERE `Students`.enrollment_year = 2022
GROUP BY `Courses`.course_id;

-- 8. Найдите студентов, которые получили оценку 'A' по всем своим курсам, без использования подзапросов.
-- XZ
-- 9. Найдите студентов, которые записаны на курсы, преподаваемые несколькими преподавателями, и посчитайте количество таких курсов для каждого студента, без использования подзапросов.
-- XZ