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

-- Вставка даних у таблиці
INSERT INTO customer (id_customer, customer_surname, customer_name, phone_number, email, customer_adress)
VALUES
    (1, 'Ivanov', 'Ivan', '0501234567', 'ivanov@example.com', '123 Main St'),
    (2, 'Petrov', 'Petro', '0667654321', 'petrov@example.com', '456 Oak St'),
    (3, 'Sydorenko', 'Oleh', '0979876543', 'oleh@example.com', '789 Pine St');

INSERT INTO order_ (id_order, id_customer, order_date, status_, date_execution, total_amount)
VALUES
    (1, 1, '2023-10-01', 'Pending', '2023-10-15', 5000),
    (2, 2, '2023-09-15', 'Completed', '2023-09-25', 3000),
    (3, 3, '2023-09-20', 'Pending', '2023-10-05', 4500);

INSERT INTO material (id_material, material_name, description_, price, id_supplier)
VALUES
    (1, 'Wood', 'High quality oak wood', 150, 1),
    (2, 'Metal', 'Stainless steel', 200, 2),
    (3, 'Plastic', 'Durable plastic', 50, 3);


    -- Запити для вибірки даних(Завдання 1)
    -- 1. Унікальні імена клієнтів
--    SELECT DISTINCT customer_name
--    FROM customer;

    -- 2. Клієнти без електронної адреси
--    SELECT customer_name, customer_surname
--    FROM customer
--    WHERE email IS NULL;
--
--    -- 3. Перші три замовлення зі статусом "Pending"
--    SELECT id_order, order_date, total_amount
--    FROM order_
--    WHERE status_ = 'Pending'
--    LIMIT 3;
--
--    -- 4. Унікальні кольори товарів
--    SELECT DISTINCT product_color
--    FROM product;
--
--    -- 5. Деталі в наявності
--    SELECT part_name, part_material
--    FROM part
--    WHERE availability_in_stock = 'In stock'
--    LIMIT 5;



    -- Запити для сортування даних(Завдання 2)
    -- 1. Сортування замовлень за датою виконання в порядку спадання
--    SELECT id_order, id_customer, order_date, date_execution, total_amount
--    FROM order_
--    ORDER BY date_execution DESC;
--
--    -- 2. Сортування клієнтів за прізвищем в алфавітному порядку
--    SELECT id_customer, customer_surname, customer_name, phone_number, email
--    FROM customer
--    ORDER BY customer_surname ASC;
--
--    -- 3. Сортування матеріалів за ціною в порядку спадання
--    SELECT id_material, material_name, description_, price
--    FROM material
--    ORDER BY price DESC;



---- Запити для фільтрації даних(Завдання 3)
---- 1. Використання оператора IN для вибірки замовлень із статусом "Pending" або "Completed"
--SELECT id_order, id_customer, order_date, status_, total_amount
--FROM order_
--WHERE status_ IN ('Pending', 'Completed');
--
---- 2. Використання оператора BETWEEN для вибірки замовлень у певному діапазоні дат
--SELECT id_order, id_customer, order_date, total_amount
--FROM order_
--WHERE order_date BETWEEN '2023-09-01' AND '2023-09-30';
--
---- 3. Використання оператора LIKE для пошуку клієнтів, чиї імена починаються на "P"
--SELECT id_customer, customer_surname, customer_name, phone_number, email
--FROM customer
--WHERE customer_name LIKE 'P%';
--
---- 4. Використання оператора LIKE для пошуку товарів, що містять слово "table" у назві
--SELECT id_product, product_name, description_, material_name
--FROM product
--WHERE product_name LIKE '%table%';
--
---- 5. Використання оператора REGEXP для пошуку клієнтів із телефонними номерами, які починаються з "050" або "097"
--SELECT id_customer, customer_surname, customer_name, phone_number
--FROM customer
--WHERE phone_number REGEXP '^050|^097';




-- Запити з використанням агрегатних функцій(Завдання 4)
-- 1. Підрахунок кількості замовлень у таблиці order_
SELECT COUNT(id_order) AS total_orders
FROM order_;

-- 2. Підрахунок загальної суми всіх замовлень
SELECT SUM(total_amount) AS total_revenue
FROM order_;

-- 3. Обчислення середньої суми замовлень
SELECT AVG(total_amount) AS average_order_amount
FROM order_;

-- 4. Пошук мінімальної та максимальної ціни матеріалу
SELECT MIN(price) AS min_price, MAX(price) AS max_price
FROM material;

-- 5. Підрахунок кількості клієнтів із заповненим полем email
SELECT COUNT(email) AS customers_with_email
FROM customer
WHERE email IS NOT NULL;




-- Додаткові запити з використанням GROUP BY та HAVING(Завдання 5)
-- 1. Підрахунок кількості замовлень за статусом
SELECT status_, COUNT(id_order) AS order_count
FROM order_
GROUP BY status_;

-- 2. Загальна сума замовлень для кожного клієнта з мінімальним порогом суми
SELECT id_customer, SUM(total_amount) AS total_amount_per_customer
FROM order_
GROUP BY id_customer
HAVING SUM(total_amount) > 4000;

-- 3. Пошук середньої ціни матеріалів для кожного постачальника
SELECT id_supplier, AVG(price) AS average_material_price
FROM material
GROUP BY id_supplier;




-- Створення представлень(Завдання 6)
-- 1. Представлення з інформацією про замовлення і клієнтів
CREATE VIEW OrderDetails AS
SELECT
    o.id_order,
    o.order_date,
    o.status_,
    o.date_execution,
    o.total_amount,
    c.customer_surname,
    c.customer_name,
    c.phone_number,
    c.email,
    c.customer_adress
FROM order_ o
JOIN customer c ON o.id_customer = c.id_customer;

-- 2. Представлення з інформацією про матеріали і постачальників
CREATE VIEW SupplierMaterialInfo AS
SELECT
    m.id_material,
    m.material_name,
    m.description_,
    m.price,
    m.id_supplier,
    AVG(m.price) OVER (PARTITION BY m.id_supplier) AS average_price_per_supplier
FROM material m;
