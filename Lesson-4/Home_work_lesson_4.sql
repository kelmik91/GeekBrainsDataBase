-- Задание 2
-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT firstname
FROM users 
GROUP BY firstname 
ORDER BY firstname	ASC;

-- Задание 3
-- Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false)

UPDATE profiles 
SET 
	is_active = 0
WHERE YEAR(created_at) > (YEAR(NOW()) - 18) ;

-- Задание 4
-- Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

delete from messages
where created_at > NOW() ;
