-- Створення початкових таблиць
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

-- Вставка даних
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

-- 1. Оптимізація за допомогою створення індексів
-- Перший запит
EXPLAIN SELECT * FROM order_ WHERE status_ = 'Pending';

-- Створення індексу
CREATE INDEX idx_status ON order_ (status_);

-- Оптимізований запит
EXPLAIN SELECT * FROM order_ WHERE status_ = 'Pending';

-- 2. Оптимізація за допомогою змінних користувача
-- Перший запит
SET @customer_id = 3;
EXPLAIN SELECT total_amount FROM order_ WHERE id_customer = @customer_id;

-- Запит із використанням змінної
SET @customer_id = 3;
SELECT total_amount FROM order_ WHERE id_customer = @customer_id;

-- 3. Оптимізація шляхом модифікації запиту
-- Перший запит
EXPLAIN SELECT id_order, id_customer, total_amount
FROM order_
WHERE id_customer IN (SELECT id_customer FROM customer WHERE customer_surname = 'Ivanov');

-- Модифікований запит із JOIN
EXPLAIN SELECT o.id_order, o.id_customer, o.total_amount
FROM order_ o
JOIN customer c ON o.id_customer = c.id_customer
WHERE c.customer_surname = 'Ivanov';

-- 4. Оптимізація шляхом розділення таблиць
-- Розділення таблиці
CREATE TABLE order_basic (
    id_order INT PRIMARY KEY,
    id_customer INT,
    order_date DATE,
    status_ VARCHAR(15)
);

CREATE TABLE order_financial (
    id_order INT PRIMARY KEY,
    date_execution DATE,
    total_amount INT
);

INSERT INTO order_basic (id_order, id_customer, order_date, status_)
SELECT id_order, id_customer, order_date, status_ FROM order_;

INSERT INTO order_financial (id_order, date_execution, total_amount)
SELECT id_order, date_execution, total_amount FROM order_;

-- Запити після розділення
EXPLAIN SELECT * FROM order_basic;
EXPLAIN SELECT * FROM order_financial;
