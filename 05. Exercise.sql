CREATE DATABASE exercise_05;
USE exercise_05;

CREATE TABLE passports(
	passport_id INT PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(8) UNIQUE
);

CREATE TABLE people(
	person_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    salary DECIMAL(16, 2),
    passport_id INT UNIQUE,
    
    FOREIGN KEY(passport_id) REFERENCES passports(passport_id)
);

INSERT INTO passports VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

INSERT INTO people(first_name, salary, passport_id) VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101);

CREATE TABLE manufacturers(
	manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    established_on DATE
);

CREATE TABLE models(
	model_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    manufacturer_id INT,
    
    FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers(name, established_on) VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models VALUES
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

CREATE TABLE students(
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30)
);

CREATE TABLE exams(
	exam_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30)
);

CREATE TABLE students_exams(
	student_id INT,
    exam_id INT,
    
    PRIMARY KEY(student_id, exam_id),
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students(name) VALUES
('Mila'),
('Toni'),
('Ron');

INSERT INTO exams VALUES
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

INSERT INTO students_exams VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

CREATE TABLE teachers(
	teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    manager_id INT
);

INSERT INTO teachers VALUES
(101, 'John', NULL),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(104, 'Ted', 105),
(105, 'Mark', 101),
(106, 'Greta', 101);

ALTER TABLE teachers
ADD FOREIGN KEY(manager_id) REFERENCES teachers(teacher_id);

CREATE DATABASE online_store;
USE online_store;

CREATE TABLE item_types(
	item_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE items(
	item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    item_type_id INT NOT NULL,
    
    FOREIGN KEY(item_type_id) REFERENCES item_types(item_type_id)
);

CREATE TABLE cities(
	city_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    birthday DATE,
    city_id INT,
    
    FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
	order_id INT,
    item_id INT,
    
    PRIMARY KEY(order_id, item_id),
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(item_id) REFERENCES items(item_id)
);

CREATE DATABASE university;
USE university;

CREATE TABLE subjects(
	subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50)
);

CREATE TABLE majors(
	major_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE students(
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12),
    student_name VARCHAR(50),
    major_id INT,
    
    FOREIGN KEY(major_id) REFERENCES majors(major_id)
);

CREATE TABLE payments(
	payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    payment_amount DECIMAL(8, 2),
    student_id INT,
    
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);

CREATE TABLE agenda(
	student_id INT,
    subject_id INT,
    
    PRIMARY KEY(student_id, subject_id),
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);

USE geography;

SELECT mountain_range, peak_name, elevation AS peak_elevation
FROM mountains AS m
JOIN peaks AS p ON
p.mountain_id = m.id
WHERE mountain_range = 'Rila'
ORDER BY peak_elevation DESC;
