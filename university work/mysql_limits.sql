
--Обслуговування винятку при вставці з дубльованим PK (PRIMARY KEY)
DELIMITER //

CREATE PROCEDURE handle_duplicate_key()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Повідомлення про помилку
        SELECT 'Помилка: Спроба вставити дубльоване значення PRIMARY KEY!';
    END;

    -- Спроба вставити дубль
    INSERT INTO customer (id_customer, customer_surname, customer_name, phone_number, email, customer_adress)
    VALUES (1, 'Ivanov', 'Ivan', '0501234567', 'ivanov@example.com', '123 Main St');
END;
//

DELIMITER ;
CALL handle_duplicate_key();

--Використання EXIT HANDLER для обробки винятків
DELIMITER //

CREATE PROCEDURE handle_exit_example()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Повідомлення про помилку
        SELECT 'Помилка виконання SQL-запиту!';
    END;

    -- Спроба оновлення неіснуючого запису
    UPDATE customer
    SET customer_name = 'John'
    WHERE id_customer = 999;
END;
//

DELIMITER ;
CALL handle_exit_example();


--Обробка декількох типів винятків
DELIMITER //

CREATE PROCEDURE multiple_exception_handling()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'SQL-помилка виявлена!';
    END;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SELECT 'Не знайдено записів!';
    END;

    -- Спроба вибрати записи, що не існують
    SELECT * FROM customer WHERE id_customer = 999;
END;
//

DELIMITER ;
CALL multiple_exception_handling();


--Ігнорування помилок за допомогою CONTINUE HANDLER
DELIMITER //

CREATE PROCEDURE ignore_error_example()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Ігнорування помилки
    END;

    -- Неправильний запит
    INSERT INTO customer (id_customer, customer_surname, customer_name, phone_number, email, customer_adress)
    VALUES (NULL, 'Test', 'Test', '1234567890', 'test@example.com', 'Test St');

    SELECT 'Процедура продовжує виконання, незважаючи на помилку!';
END;
//

DELIMITER ;
CALL ignore_error_example();


--Логування помилок у таблицю

-- Створення таблиці для логування
CREATE TABLE error_log (
    error_message VARCHAR(255),
    error_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE PROCEDURE log_error_example()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Логування помилки
        INSERT INTO error_log (error_message)
        VALUES ('Помилка SQL-запиту!');
    END;

    -- Невдалий запит
    DELETE FROM customer WHERE id_customer = NULL;
END;
//

DELIMITER ;
CALL log_error_example();

-- Перевірка журналу
SELECT * FROM error_log;


-- Використання користувацьких сигналів (SIGNAL)

DELIMITER //

CREATE PROCEDURE custom_signal_example()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Обробка винятку
        SELECT 'Користувацька помилка оброблена!';
    END;

    -- Використання SIGNAL
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Це спеціально викликаний виняток!';
END;
//

DELIMITER ;
CALL custom_signal_example();