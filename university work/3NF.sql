-- Створення таблиці customers
CREATE TABLE customers (
    id_customer INT PRIMARY KEY,
    customer_surname VARCHAR(25),
    customer_name VARCHAR(15) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(35),
    customer_address VARCHAR(30) NOT NULL
);

-- Створення таблиці suppliers
CREATE TABLE suppliers (
    id_supplier INT PRIMARY KEY,
    supplier_name VARCHAR(25) NOT NULL,
    phone_number VARCHAR(10) NOT NULL
);

-- Створення таблиці materials
CREATE TABLE materials (
    id_material INT PRIMARY KEY,
    material_name VARCHAR(30),
    description_ VARCHAR(150),
    price INT,
    id_supplier INT,
    FOREIGN KEY (id_supplier) REFERENCES suppliers(id_supplier)
);

-- Створення таблиці orders
CREATE TABLE orders (
    id_order INT PRIMARY KEY,
    id_customer INT,
    order_date DATE,
    status_ VARCHAR(15),
    date_execution DATE,
    FOREIGN KEY (id_customer) REFERENCES customers(id_customer)
);

-- Створення таблиці order_details
CREATE TABLE order_details (
    id_order INT,
    id_material INT,
    quantity INT,
    PRIMARY KEY (id_order, id_material),
    FOREIGN KEY (id_order) REFERENCES orders(id_order),
    FOREIGN KEY (id_material) REFERENCES materials(id_material)
);

-- Вставка даних у таблицю customers
INSERT INTO customers (id_customer, customer_surname, customer_name, phone_number, email, customer_address)
VALUES
    (1, 'Ivanov', 'Ivan', '0501234567', 'ivanov@example.com', '123 Main St'),
    (2, 'Petrov', 'Petro', '0667654321', 'petrov@example.com', '456 Oak St'),
    (3, 'Sydorenko', 'Oleh', '0979876543', 'oleh@example.com', '789 Pine St'),
    (4, 'Koval', 'Anna', '0632345678', 'koval@example.com', '101 Elm St'),
    (5, 'Shevchenko', 'Maria', '0988765432', 'maria@example.com', '202 Maple St'),
    (6, 'Bondar', 'Oksana', '0505678901', 'oksana@example.com', '303 Willow St');

-- Вставка даних у таблицю suppliers
INSERT INTO suppliers (id_supplier, supplier_name, phone_number)
VALUES
    (1, 'Supplier A', '0501234567'),
    (2, 'Supplier B', '0667654321'),
    (3, 'Supplier C', '0979876543');

-- Вставка даних у таблицю materials
INSERT INTO materials (id_material, material_name, description_, price, id_supplier)
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

-- Вставка даних у таблицю orders
INSERT INTO orders (id_order, id_customer, order_date, status_, date_execution)
VALUES
    (1, 1, '2023-10-01', 'Pending', '2023-10-15'),
    (2, 2, '2023-09-15', 'Completed', '2023-09-25'),
    (3, 3, '2023-09-20', 'Pending', '2023-10-05'),
    (4, 1, '2023-10-10', 'Completed', '2023-10-20'),
    (5, 4, '2023-11-01', 'Pending', '2023-11-10'),
    (6, 5, '2023-11-05', 'Completed', '2023-11-15'),
    (7, 6, '2023-11-07', 'Pending', '2023-11-20'),
    (8, 2, '2023-11-08', 'Completed', '2023-11-18'),
    (9, 3, '2023-11-09', 'Pending', '2023-11-22');

-- Вставка даних у таблицю order_details
INSERT INTO order_details (id_order, id_material, quantity)
VALUES
    (1, 1, 10),
    (1, 4, 5),
    (2, 2, 15),
    (3, 3, 20),
    (3, 5, 8),
    (4, 6, 12),
    (5, 8, 6),
    (6, 9, 3),
    (7, 1, 7);
