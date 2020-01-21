/*
Задание 2
Создайте базу данных example, 
разместите в ней таблицу users, 
состоящую из двух столбцов, числового id и строкового name.
*/
--Проверяем наличие базы данных и создаем ее
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

--Создаем таблицу
USE example;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(80) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(150)
);

/*Задание 3
Создайте дамп базы данных example из предыдущего задания, 
разверните содержимое дампа в новую базу данных sample.
*/
--Создаем дамп базы данных
\! mysqldump example > mysql_dump_example.sql

--Проверяем наличие базы данных и создаем ее
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

--Заполняем базу данных из дампа
\! mysql sample < mysql_dump_example.sql

/*Заание 4
Создайте дамп единственной таблицы help_keyword базы данных mysql.
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/
\! mysqldump -where="true limit 100" mysql help_keyword > mysql_help_keyword.sql