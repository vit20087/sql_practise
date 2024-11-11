CREATE TABLE customer(
    id_customer INT(25) PRIMARY KEY,
    customer_surname VARCHAR(25),
    customer_name VARCHAR(15) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(35),
    customer_adress VARCHAR(30) NOT NULL
);

CREATE TABLE order_(
    id_order INT(20) PRIMARY KEY,
    id_customer INT(25),
    order_date DATE,
    status_ VARCHAR(15),
    date_execution DATE,
    total_amount INT,
    FOREIGN KEY (id_customer) REFERENCES customer(id_customer)
);

CREATE TABLE material (
    id_material INT(30) PRIMARY KEY,
    material_name VARCHAR(30),
    description_ VARCHAR(150),
    price INT,
    id_supplier INT,
    FOREIGN KEY (id_supplier) REFERENCES supplier(id_supplier)
);

CREATE TABLE product (
    id_product INT PRIMARY KEY,
    product_name VARCHAR(50),
    description_ VARCHAR(150),
    material_name VARCHAR(30),
    product_size VARCHAR(20),
    product_color VARCHAR(15),
    availability_in_stock VARCHAR(100),
    number_of_parts_in_set INT,
    FOREIGN KEY (material_name) REFERENCES material(material_name)
);

CREATE TABLE part(
    id_part INT PRIMARY KEY,
    part_name VARCHAR(15),
    part_size VARCHAR(20),
    part_material VARCHAR(15),
    part_price INT,
    number_in_set INT,
    availability_in_stock VARCHAR(100)
);

CREATE TABLE order_part(
    id_order INT,
    id_part INT,
    number_in_order INT,
    PRIMARY KEY(id_order, id_part),
    FOREIGN KEY(id_order) REFERENCES order_(id_order),
    FOREIGN KEY(id_part) REFERENCES part(id_part)
);

CREATE TABLE employee(
    id_employee INT PRIMARY KEY,
    employee_name VARCHAR(30),
    employee_surname VARCHAR(35),
    employee_position VARCHAR(30),
    employee_phone_number VARCHAR(15),
    address VARCHAR(50)
);

CREATE TABLE supplier(
    id_supplier INT PRIMARY KEY,
    supplier_phone_number VARCHAR(15),
    supplier_email VARCHAR(40),
    address VARCHAR(50)
);

CREATE TABLE stock (
    id_stock INT PRIMARY KEY,
    id_employee INT,
    address VARCHAR(50),
    stock_phone_number VARCHAR(15),
    furniture_in_stock VARCHAR(1500),
    parts_in_stock VARCHAR(200),
    FOREIGN KEY (id_employee) REFERENCES employee(id_employee)
);

CREATE TABLE production(
    id_production INT PRIMARY KEY,
    id_employee INT,
    prosuction_start_date DATETIME,
    production_end_date DATETIME,
    status_ VARCHAR(15),
    FOREIGN KEY (id_employee) REFERENCES employee(id_employee),
    FOREIGN KEY (status_) REFERENCES order_(status_)
);

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

INSERT INTO product (id_product, product_name, description_, material_name, product_size, product_color, availability_in_stock, number_of_parts_in_set)
VALUES
    (1, 'Table', 'Large wooden dining table', 'Wood', '200x100', 'Brown', 'In stock', 10),
    (2, 'Chair', 'Comfortable plastic chair', 'Plastic', '50x50', 'Black', 'In stock', 20),
    (3, 'Cabinet', 'Metal storage cabinet', 'Metal', '100x50', 'Grey', 'Out of stock', 5);

INSERT INTO part (id_part, part_name, part_size, part_material, part_price, number_in_set, availability_in_stock)
VALUES
    (1, 'Leg', '50x50', 'Metal', 100, 4, 'In stock'),
    (2, 'Seat', '40x40', 'Plastic', 30, 1, 'In stock'),
    (3, 'Handle', '10x10', 'Metal', 10, 2, 'In stock');

INSERT INTO order_part (id_order, id_part, number_in_order)
VALUES
    (1, 1, 4),
    (1, 2, 1),
    (2, 3, 2),
    (3, 1, 6);

INSERT INTO employee (id_employee, employee_name, employee_surname, employee_position, employee_phone_number, address)
VALUES
    (1, 'Andriy', 'Shevchenko', 'Manager', '0981112222', '999 Cherry St'),
    (2, 'Olena', 'Ivanova', 'Assembler', '0973334444', '888 Maple St'),
    (3, 'Bohdan', 'Petrenko', 'Stock Worker', '0955556666', '777 Elm St');

INSERT INTO supplier (id_supplier, supplier_phone_number, supplier_email, address)
VALUES
    (1, '0800555555', 'supplier1@example.com', '100 Supply Rd'),
    (2, '0800666666', 'supplier2@example.com', '200 Supply Rd'),
    (3, '0800777777', 'supplier3@example.com', '300 Supply Rd');

INSERT INTO stock (id_stock, id_employee, address, stock_phone_number, furniture_in_stock, parts_in_stock)
VALUES
    (1, 3, 'Warehouse 1', '0800999999', 'Tables, Chairs', 'Legs, Handles'),
    (2, 3, 'Warehouse 2', '0800888888', 'Cabinets', 'Seats');

INSERT INTO production (id_production, id_employee, prosuction_start_date, production_end_date, status_)
VALUES
    (1, 2, '2023-09-01 08:00:00', '2023-09-05 17:00:00', 'Completed'),
    (2, 1, '2023-09-10 08:00:00', '2023-09-15 17:00:00', 'Pending');

SELECT * FROM customer;
SELECT * FROM order_;
SELECT * FROM material;
SELECT * FROM product;
SELECT * FROM part;
SELECT * FROM order_part;
SELECT * FROM employee;
SELECT * FROM supplier;
SELECT * FROM stock;
SELECT * FROM production;


SELECT DISTINCT customer_name
FROM customer;

SELECT customer_name, customer_surname
FROM customer
WHERE email IS NULL;

SELECT id_order, order_date, total_amount
FROM order_
WHERE status_ = 'Pending'
LIMIT 3;

SELECT DISTINCT product_color
FROM product;

SELECT part_name, part_material
FROM part
WHERE availability_in_stock = 'In stock'
LIMIT 5;
