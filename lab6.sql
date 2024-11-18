-- Створення таблиць
CREATE TABLE customer (
    id_customer INT PRIMARY KEY,
    customer_surname VARCHAR(25),
    customer_name VARCHAR(15) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(35),
    customer_adress VARCHAR(30) NOT NULL
);

CREATE TABLE order_ (
    id_order INT PRIMARY KEY,
    id_customer INT,
    order_date DATE,
    status_ VARCHAR(15),
    date_execution DATE,
    total_amount INT,
    FOREIGN KEY (id_customer) REFERENCES customer(id_customer)
);

CREATE TABLE material (
    id_material INT PRIMARY KEY,
    material_name VARCHAR(30),
    description_ VARCHAR(150),
    price INT,
    id_supplier INT
);

CREATE TABLE supplier (
    id_supplier INT PRIMARY KEY,
    supplier_name VARCHAR(25) NOT NULL,
    phone_number VARCHAR(10) NOT NULL
);

-- Вставка даних у таблиці customer
INSERT INTO customer (id_customer, customer_surname, customer_name, phone_number, email, customer_adress)
VALUES
    (1, 'Ivanov', 'Ivan', '0501234567', 'ivanov@example.com', '123 Main St'),
    (2, 'Petrov', 'Petro', '0667654321', 'petrov@example.com', '456 Oak St'),
    (3, 'Sydorenko', 'Oleh', '0979876543', 'oleh@example.com', '789 Pine St'),
    (4, 'Koval', 'Anna', '0632345678', 'koval@example.com', '101 Elm St'),
    (5, 'Shevchenko', 'Maria', '0988765432', 'maria@example.com', '202 Maple St'),
    (6, 'Bondar', 'Oksana', '0505678901', 'oksana@example.com', '303 Willow St');

-- Вставка даних у таблиці order_
INSERT INTO order_ (id_order, id_customer, order_date, status_, date_execution, total_amount)
VALUES
    (1, 1, '2023-10-01', 'Pending', '2023-10-15', 5000),
    (2, 2, '2023-09-15', 'Completed', '2023-09-25', 3000),
    (3, 3, '2023-09-20', 'Pending', '2023-10-05', 4500),
    (4, 1, '2023-10-10', 'Completed', '2023-10-20', 7000),
    (5, 4, '2023-11-01', 'Pending', '2023-11-10', 6000),
    (6, 5, '2023-11-05', 'Completed', '2023-11-15', 2500),
    (7, 6, '2023-11-07', 'Pending', '2023-11-20', 3500),
    (8, 2, '2023-11-08', 'Completed', '2023-11-18', 4000),
    (9, 3, '2023-11-09', 'Pending', '2023-11-22', 3200);

-- Вставка даних у таблиці material
INSERT INTO material (id_material, material_name, description_, price, id_supplier)
VALUES
    (1, 'Wood', 'High quality oak wood', 150, 1),
    (2, 'Metal', 'Stainless steel', 200, 2),
    (3, 'Plastic', 'Durable plastic', 50, 3),
    (4, 'Glass', 'Tempered glass for windows', 120, 1),
    (5, 'Aluminum', 'Lightweight aluminum sheets', 180, 2),
    (6, 'Rubber', 'High-density rubber', 60, 3),
    (7, 'Concrete', 'Ready-mix concrete', 90, 1),
    (8, 'Copper', 'Copper wires', 210, 2),
    (9, 'Textile', 'Polyester fabric', 70, 3);




----Завдання 1
--
---- Вставка даних у таблиці supplier
--INSERT INTO supplier (id_supplier, supplier_name, phone_number)
--VALUES
--    (1, 'Supplier A', '0501234567'),
--    (2, 'Supplier B', '0667654321'),
--    (3, 'Supplier C', '0979876543');
--
---- Створення таблиці для збереження звітів постачальників
--CREATE TABLE supplier_report (
--    id_supplier INT,
--    total_material_cost INT,
--    report_date DATE
--);
--
---- Подія 1: Автоматичне оновлення статусу замовлення
--CREATE EVENT update_order_status
--ON SCHEDULE EVERY 1 DAY
--DO
--UPDATE order_
--SET status_ = 'Completed'
--WHERE status_ = 'Pending' AND date_execution < CURDATE();
--
---- Подія 2: Щотижневий звіт постачальників
--CREATE EVENT weekly_supplier_report
--ON SCHEDULE EVERY 1 WEEK
--DO
--INSERT INTO supplier_report (id_supplier, total_material_cost, report_date)
--SELECT id_supplier, SUM(price), CURDATE()
--FROM material
--GROUP BY id_supplier;
--
---- Подія 3: Нагадування клієнтам про прострочені замовлення
--CREATE EVENT notify_customers_about_overdue_orders
--ON SCHEDULE EVERY 1 DAY
--DO
--SELECT customer.id_customer, customer.customer_name, customer.email, order_.id_order, order_.date_execution
--FROM customer
--JOIN order_ ON customer.id_customer = order_.id_customer
--WHERE order_.status_ = 'Pending' AND order_.date_execution < CURDATE();



--Завдання 2
---- Створення таблиці для логування змін статусу
--CREATE TABLE order_log (
--    log_id INT AUTO_INCREMENT PRIMARY KEY,
--    id_order INT,
--    old_status VARCHAR(15),
--    new_status VARCHAR(15),
--    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--);

---- Створення тригера для автоматичного оновлення статусу замовлення
--DELIMITER $$
--
--CREATE TRIGGER trg_update_order_status
--AFTER INSERT ON order_
--FOR EACH ROW
--BEGIN
--    IF NEW.date_execution < CURDATE() THEN
--        UPDATE order_
--        SET status_ = 'Completed'
--        WHERE id_order = NEW.id_order;
--    END IF;
--END $$
--
--DELIMITER ;
--
---- Створення тригера для логування змін статусу замовлення
--DELIMITER $$
--
--CREATE TRIGGER trg_order_status_change
--BEFORE UPDATE ON order_
--FOR EACH ROW
--BEGIN
--    IF OLD.status_ != NEW.status_ THEN
--        INSERT INTO order_log (id_order, old_status, new_status)
--        VALUES (OLD.id_order, OLD.status_, NEW.status_);
--    END IF;
--END $$
--
--DELIMITER ;




--Завдання 3


---- Процедура 1: Додавання нового замовлення
--DELIMITER $$
--
--CREATE PROCEDURE AddOrder (
--    IN p_id_customer INT,
--    IN p_order_date DATE,
--    IN p_status VARCHAR(15),
--    IN p_date_execution DATE,
--    IN p_total_amount INT
--)
--BEGIN
--    INSERT INTO order_ (id_customer, order_date, status_, date_execution, total_amount)
--    VALUES (p_id_customer, p_order_date, p_status, p_date_execution, p_total_amount);
--END $$
--
--DELIMITER ;
--
---- Процедура 2: Видалення замовлення
--DELIMITER $$
--
--CREATE PROCEDURE DeleteOrder (
--    IN p_id_order INT
--)
--BEGIN
--    DELETE FROM order_ WHERE id_order = p_id_order;
--END $$
--
--DELIMITER ;
--
---- Процедура 3: Оновлення статусу замовлення
--DELIMITER $$
--
--CREATE PROCEDURE UpdateOrderStatus (
--    IN p_id_order INT,
--    IN p_new_status VARCHAR(15)
--)
--BEGIN
--    UPDATE order_ SET status_ = p_new_status WHERE id_order = p_id_order;
--END $$
--
--DELIMITER ;
--
---- Функція 1: Отримання загальної суми замовлень клієнта
--DELIMITER $$
--
--CREATE FUNCTION TotalCustomerOrders (
--    p_id_customer INT
--) RETURNS INT
--BEGIN
--    DECLARE total_amount INT;
--    SELECT SUM(total_amount) INTO total_amount
--    FROM order_
--    WHERE id_customer = p_id_customer;
--    RETURN COALESCE(total_amount, 0);
--END $$
--
--DELIMITER ;
--
---- Функція 2: Отримання кількості замовлень у певному статусі
--DELIMITER $$
--
--CREATE FUNCTION CountOrdersByStatus (
--    p_status VARCHAR(15)
--) RETURNS INT
--BEGIN
--    DECLARE count_orders INT;
--    SELECT COUNT(*) INTO count_orders
--    FROM order_
--    WHERE status_ = p_status;
--    RETURN count_orders;
--END $$
--
--DELIMITER ;



--Завдання 4
-- Збережена процедура 1: Перегляд замовлень для кожного клієнта
--DELIMITER $$
--
--CREATE PROCEDURE ListOrdersByCustomer()
--BEGIN
--    DECLARE done INT DEFAULT 0;
--    DECLARE p_id_customer INT;
--    DECLARE p_customer_name VARCHAR(15);
--    DECLARE p_customer_surname VARCHAR(25);
--    DECLARE cur CURSOR FOR SELECT id_customer, customer_name, customer_surname FROM customer;
--    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
--
--    OPEN cur;
--
--    read_loop: LOOP
--        FETCH cur INTO p_id_customer, p_customer_name, p_customer_surname;
--        IF done THEN
--            LEAVE read_loop;
--        END IF;
--
--        SELECT CONCAT('Замовлення для клієнта: ', p_customer_name, ' ', p_customer_surname, ' (ID: ', p_id_customer, ')') AS CustomerDetails;
--
--        SELECT id_order, order_date, status_, total_amount
--        FROM order_
--        WHERE id_customer = p_id_customer;
--    END LOOP;
--
--    CLOSE cur;
--END $$
--
--DELIMITER ;
--
---- Виклик процедури 1
--CALL ListOrdersByCustomer();
--
---- Збережена процедура 2: Оновлення статусу замовлень із простроченими датами виконання
--DELIMITER $$
--
--CREATE PROCEDURE UpdateOverdueOrders()
--BEGIN
--    DECLARE done INT DEFAULT 0;
--    DECLARE p_id_order INT;
--    DECLARE p_date_execution DATE;
--    DECLARE cur CURSOR FOR SELECT id_order, date_execution FROM order_ WHERE status_ = 'Pending';
--    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
--
--    OPEN cur;
--
--    read_loop: LOOP
--        FETCH cur INTO p_id_order, p_date_execution;
--        IF done THEN
--            LEAVE read_loop;
--        END IF;
--
--        IF p_date_execution < CURDATE() THEN
--            UPDATE order_
--            SET status_ = 'Overdue'
--            WHERE id_order = p_id_order;
--        END IF;
--    END LOOP;
--
--    CLOSE cur;
--END $$
--
--DELIMITER ;
--
---- Виклик процедури 2
--CALL UpdateOverdueOrders();



--Завдання 5


--1. Скрипт транзакції: Додавання нового клієнта та замовлення
---- Початок транзакції
--START TRANSACTION;
--
---- Додавання нового клієнта
--INSERT INTO customer (id_customer, customer_surname, customer_name, phone_number, email, customer_adress)
--VALUES (7, 'Zhuk', 'Oksana', '0509876543', 'oksana.zhuk@example.com', '404 Birch St');
--
---- Додавання замовлення для нового клієнта
--INSERT INTO order_ (id_order, id_customer, order_date, status_, date_execution, total_amount)
--VALUES (10, 7, '2023-11-18', 'Pending', '2023-11-30', 5500);
--
---- Завершення транзакції
--COMMIT;



--2. Скрипт транзакції: Оновлення інформації про замовлення


---- Початок транзакції
--START TRANSACTION;
--
---- Оновлення статусу та дати виконання замовлення
--UPDATE order_
--SET status_ = 'Completed', date_execution = '2023-11-18'
--WHERE id_order = 5;
--
---- Помилкове оновлення (імітація помилки)
--UPDATE order_
--SET total_amount = 'INVALID_VALUE'
--WHERE id_order = 6;
--
---- Відкат змін у разі помилки
--ROLLBACK;


--Скрипти блокувань
--  1. Просте блокування таблиці
--  Блокування таблиці order_ для уникнення змін іншими транзакціями під час виконання операцій.
-- Блокування таблиці order_ на запис
--LOCK TABLES order_ WRITE;
--
---- Оновлення статусу замовлення
--UPDATE order_
--SET status_ = 'Processing'
--WHERE id_order = 3;
--
---- Розблокування таблиці
--UNLOCK TABLES;



--2. Блокування на рівні рядків
--Використовується для блокування окремого рядка в таблиці order_ під час оновлення.
--
---- Початок транзакції
--START TRANSACTION;
--
---- Блокування рядка
--SELECT * FROM order_
--WHERE id_order = 4
--FOR UPDATE;
--
---- Оновлення статусу замовлення
--UPDATE order_
--SET status_ = 'Processing'
--WHERE id_order = 4;
--
---- Завершення транзакції
--COMMIT;
