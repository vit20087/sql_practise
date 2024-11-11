-- Створення таблиць
CREATE TABLE customer(
    id_customer INT PRIMARY KEY,
    customer_surname VARCHAR(25),
    customer_name VARCHAR(15) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(35),
    customer_adress VARCHAR(30) NOT NULL
);

CREATE TABLE order_(
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

-- Вставка даних у таблиці supplier
INSERT INTO supplier (id_supplier, supplier_name, phone_number)
VALUES
    (1, 'Supplier A', '0501234567'),
    (2, 'Supplier B', '0667654321'),
    (3, 'Supplier C', '0979876543');

---- Підзапити(Завдання 1)
--
---- 1. Некорелюючий підзапит: Пошук замовлень із сумою, більшою за середню суму всіх замовлень
--SELECT id_order, id_customer, total_amount
--FROM order_
--WHERE total_amount > (SELECT AVG(total_amount) FROM order_);
--
---- 2. Корелюючий підзапит: Пошук клієнтів, які мають хоча б одне "Pending" замовлення
--SELECT DISTINCT c.customer_surname, c.customer_name
--FROM customer c
--WHERE EXISTS (
--    SELECT 1
--    FROM order_ o
--    WHERE o.id_customer = c.id_customer AND o.status_ = 'Pending'
--);
--
---- 3. Некорелюючий підзапит: Пошук матеріалів, ціна яких перевищує мінімальну ціну в таблиці
--SELECT material_name, price
--FROM material
--WHERE price > (SELECT MIN(price) FROM material);
--
---- 4. Корелюючий підзапит: Пошук замовлень із сумою, більшою за середню суму замовлень для кожного клієнта
--SELECT o.id_order, o.total_amount
--FROM order_ o
--WHERE o.total_amount > (
--    SELECT AVG(total_amount)
--    FROM order_
--    WHERE id_customer = o.id_customer
--);
--
---- 5. Некорелюючий підзапит: Пошук клієнтів, які не мають жодного замовлення
--SELECT customer_surname, customer_name
--FROM customer
--WHERE id_customer NOT IN (SELECT id_customer FROM order_);






---- Приклади запитів з INNER JOIN та OUTER JOIN(Завдання 2)
--
---- 1. INNER JOIN: Пошук замовлень разом із даними про клієнтів, які їх розмістили
--SELECT o.id_order, o.order_date, o.total_amount, c.customer_name, c.customer_surname
--FROM order_ o
--INNER JOIN customer c ON o.id_customer = c.id_customer;
--
---- 2. LEFT JOIN: Виведення всіх клієнтів і їх замовлень (включаючи клієнтів без замовлень)
--SELECT c.customer_name, c.customer_surname, o.id_order, o.total_amount
--FROM customer c
--LEFT JOIN order_ o ON c.id_customer = o.id_customer;
--
---- 3. RIGHT JOIN: Пошук усіх замовлень та відповідних клієнтів (включаючи замовлення без даних клієнтів)
--SELECT o.id_order, o.order_date, o.total_amount, c.customer_name, c.customer_surname
--FROM order_ o
--RIGHT JOIN customer c ON o.id_customer = c.id_customer;
--
---- 4. FULL OUTER JOIN: Виведення всіх клієнтів та їх замовлень, включаючи клієнтів без замовлень і замовлення без клієнтів
--SELECT c.customer_name, c.customer_surname, o.id_order, o.total_amount
--FROM customer c
--FULL OUTER JOIN order_ o ON c.id_customer = o.id_customer;
--
---- 5. INNER JOIN: Пошук замовлень із сумою більшою за 3000 разом із матеріалами
--SELECT o.id_order, o.total_amount, m.material_name, m.price
--FROM order_ o
--INNER JOIN material m ON o.total_amount > 3000;



----Завдання 3

---- 1. Підрахунок кількості замовлень за статусом
--SELECT
--    COUNT(CASE WHEN status_ = 'Completed' THEN 1 END) AS completed_orders,
--    COUNT(CASE WHEN status_ = 'Pending' THEN 1 END) AS pending_orders
--FROM order_;
--
---- 2. Визначення категорії сум замовлень (низька, середня, висока) та підрахунок замовлень за кожною категорією
--SELECT
--    COUNT(CASE WHEN total_amount < 3000 THEN 1 END) AS low_amount_orders,
--    COUNT(CASE WHEN total_amount BETWEEN 3000 AND 5000 THEN 1 END) AS medium_amount_orders,
--    COUNT(CASE WHEN total_amount > 5000 THEN 1 END) AS high_amount_orders
--FROM order_;
--
---- 3. Підрахунок кількості замовлень кожного клієнта та визначення активності клієнта
--SELECT
--    c.customer_name,
--    c.customer_surname,
--    COUNT(o.id_order) AS total_orders,
--    CASE
--        WHEN COUNT(o.id_order) >= 3 THEN 'Active'
--        WHEN COUNT(o.id_order) = 2 THEN 'Moderately Active'
--        WHEN COUNT(o.id_order) = 1 THEN 'New'
--        ELSE 'Inactive'
--    END AS activity_level
--FROM customer c
--LEFT JOIN order_ o ON c.id_customer = o.id_customer
--GROUP BY c.id_customer;
--
---- 4. Підрахунок загальної кількості матеріалів кожного постачальника, з категоризацією вартості
--SELECT
--    id_supplier,
--    COUNT(id_material) AS total_materials,
--    SUM(CASE WHEN price > 100 THEN price ELSE 0 END) AS high_cost_materials_value,
--    SUM(CASE WHEN price <= 100 THEN price ELSE 0 END) AS low_cost_materials_value
--FROM material
--GROUP BY id_supplier;
--
---- 5. Визначення середнього часу виконання замовлень у днях для кожного статусу
--SELECT
--    status_,
--    AVG(DATEDIFF(date_execution, order_date)) AS avg_days_to_execute
--FROM order_
--GROUP BY status_;






----Завдання 4
---- 1. UNION: Вибір унікальних номерів телефонів клієнтів і постачальників
--SELECT phone_number FROM customer
--UNION
--SELECT phone_number FROM supplier;
--
---- 2. UNION ALL: Вибір усіх замовлень і матеріалів з однаковою структурою полів для отримання комбінованого списку (без видалення дублікатів)
--SELECT id_order AS id, order_date AS date, 'Order' AS type
--FROM order_
--UNION ALL
--SELECT id_material AS id, NULL AS date, 'Material' AS type
--FROM material;
--
---- 3. INTERSECT: Вибір клієнтів, які також є постачальниками
--SELECT customer_name AS name FROM customer
--INTERSECT
--SELECT supplier_name AS name FROM supplier;
--
---- 4. EXCEPT: Вибір клієнтів, які не мають жодного замовлення
--SELECT customer_name, customer_surname FROM customer
--EXCEPT
--SELECT customer_name, customer_surname FROM customer
--JOIN order_ ON customer.id_customer = order_.id_customer;
--
---- 5. UNION: Вибір всіх дат замовлень і дат виконання замовлень
--SELECT order_date AS event_date FROM order_
--UNION
--SELECT date_execution AS event_date FROM order_;