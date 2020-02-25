-- Практическое задание по теме “Оптимизация запросов”
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

SET AUTOCOMMIT = 0;
START TRANSACTION;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
 created_at DATETIME DEFAULT NOW(), 
 table_name VARCHAR(25),
 id INTEGER,
 field_name_value VARCHAR(255)
)
ENGINE=ARCHIVE;
DROP PROCEDURE IF EXISTS write_log;
DROP TRIGGER IF EXISTS users_insert_trg;
DROP TRIGGER IF EXISTS products_insert_trg;
DROP TRIGGER IF EXISTS catalogs_insert_trg;
DELIMITER //
CREATE PROCEDURE write_log(IN table_name_ VARCHAR(25), IN id_ INTEGER, IN field_name_value_ VARCHAR(255))
BEGIN
	INSERT INTO logs(table_name, id, field_name_value) VALUES (table_name_, id_, field_name_value_);
END//

CREATE TRIGGER users_insert_trg AFTER INSERT ON users
FOR EACH ROW
BEGIN
    CALL write_log("users", NEW.id, NEW.name);
END//

CREATE TRIGGER products_insert_trg AFTER INSERT ON products
FOR EACH ROW
BEGIN
    CALL write_log("products", NEW.id, NEW.name);
END//

CREATE TRIGGER catalogs_insert_trg AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    CALL write_log("catalogs", NEW.id, NEW.name);
END//
DELIMITER ;
COMMIT;

-- Практическое задание по теме “NoSQL”
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
HSET ipaddr 127.0.0.1 1

-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
-- поиск электронного адреса пользователя по его имени.
SET Alex mail@mail.ru
SET mail@mail Alex
GET Alex
GET mail@mail.ru
