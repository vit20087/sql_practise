--Крок 1 . Створення додаткового користувача

-- Створення нового користувача
CREATE USER 'user_test'@'localhost' IDENTIFIED BY 'password123';

--Крок 2 . Встановлення привілеїв
--Привілеї встановлюються для управління доступом користувача до бази даних та її об'єктів.

--1. Надання привілеїв на всю базу даних
-- Надання всіх привілеїв на базу даних
GRANT ALL PRIVILEGES ON your_database.* TO 'user_test'@'localhost';

--2. Надання привілею SELECT на конкретну таблицю
-- Надання доступу на читання для таблиці `customers`
GRANT SELECT ON your_database.customers TO 'user_test'@'localhost';

--3. Надання привілею INSERT на таблицю
-- Надання доступу на додавання даних до таблиці `orders`
GRANT INSERT ON your_database.orders TO 'user_test'@'localhost';

--4. Надання привілею UPDATE на окремі колонки
-- Надання доступу на оновлення лише колонки `status_` таблиці `orders`
GRANT UPDATE (status_) ON your_database.orders TO 'user_test'@'localhost';

--5. Надання привілею DELETE
-- Надання права видалення записів із таблиці `materials`
GRANT DELETE ON your_database.materials TO 'user_test'@'localhost';

--6. Надання привілею CREATE
-- Надання права створення нових таблиць у базі даних
GRANT CREATE ON your_database.* TO 'user_test'@'localhost';

--7. Надання привілею DROP
-- Надання права видалення таблиць у базі даних
GRANT DROP ON your_database.* TO 'user_test'@'localhost';

--8. Надання привілею EXECUTE
-- Надання права виконувати збережені процедури
GRANT EXECUTE ON your_database.* TO 'user_test'@'localhost';

--9. Надання привілею RELOAD
-- Надання права виконувати команду FLUSH
GRANT RELOAD ON *.* TO 'user_test'@'localhost';

--10. Надання привілею SHOW DATABASES
-- Надання права переглядати доступні бази даних
GRANT SHOW DATABASES ON *.* TO 'user_test'@'localhost';

--11. Надання привілею LOCK TABLES
-- Надання права блокувати таблиці
GRANT LOCK TABLES ON your_database.* TO 'user_test'@'localhost';

--12. Надання привілею REFERENCES
-- Надання права створювати зовнішні ключі
GRANT REFERENCES ON your_database.* TO 'user_test'@'localhost';




--Крок 3. Скасування привілеїв

--Привілеї можна скасувати за допомогою команди REVOKE.

--Скасування доступу на читання для таблиці `customers`
REVOKE SELECT ON your_database.customers FROM 'user_test'@'localhost';

--Скасування привілею INSERT

--Скасування доступу на додавання даних до таблиці `orders`
REVOKE INSERT ON your_database.orders FROM 'user_test'@'localhost';


--Скасування привілеїв UPDATE

--Скасування доступу на оновлення колонки `status_` таблиці `orders`
REVOKE UPDATE (status_) ON your_database.orders FROM 'user_test'@'localhost';


--Скасування всіх привілеїв

-- Скасування всіх привілеїв для користувача
REVOKE ALL PRIVILEGES ON your_database.* FROM 'user_test'@'localhost';





--Крок 4. Перевірка привілеїв

--Перевірка привілеїв користувача
SHOW GRANTS FOR 'user_test'@'localhost';