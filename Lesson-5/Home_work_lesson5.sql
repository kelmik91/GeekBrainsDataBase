-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

-- Задание 1
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE
	users
SET
	created_at = now(),
	updated_at = now();

/* Задание 2
 * Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля 
к типу DATETIME, сохранив введеные ранее значения.
*/

-- Сначала приводим поля created_at и updated_at к формату даты
UPDATE
	users
SET
	created_at = STR_TO_DATE(created_at,
	'%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at,
	'%d.%m.%Y %k:%i');

-- Изменяем тип данных столбцов created_at и updated_at
ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON
UPDATE
	CURRENT_TIMESTAMP;

/* Задание 3
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/
SELECT
	*
FROM
	storehouses_products
ORDER BY
	IF (value > 0,
	0,
	1),
	value;

-- Практическое задание теме “Агрегация данных”

-- Задание 1
-- Подсчитайте средний возраст пользователей в таблице users
SELECT
	AVG(TIMESTAMPDIFF(YEAR, brithday_at, NOW() )) AS age
FROM
	users;
-- Задание 2
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(now()), MONTH(brithday_at), DAY(brithday_at)) ), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total;
	
-- Задание 3
-- Подсчитайте произведение чисел в столбце таблицы
SELECT exp(sum(ln(values))) from tbl;
