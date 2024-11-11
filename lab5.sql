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
