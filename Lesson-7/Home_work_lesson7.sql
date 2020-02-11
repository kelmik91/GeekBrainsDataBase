-- Задание 1
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT name FROM users
WHERE EXISTS(SELECT 1 FROM orders WHERE user_id = users.id);

-- Задание 2
-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name AS product_name,
		c.name AS catalog_name
FROM products
INNER JOIN catalogs on catalogs.id = products.catalog_id;

-- Задание 3
-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

SELECT c.name AS `from`, c1.name AS `to`
FROM flights f
INNER JOIN cities c ON c.label = f.`from`
INNER JOIN cities c1 ON c1.label = f.`to`
ORDER BY f.id;
