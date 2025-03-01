CREATE DATABASE minions;
USE minions;

CREATE TABLE `minions` (
	`id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100),
    `age` INT
);

CREATE TABLE `towns` (
	`town_id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100)
);

ALTER TABLE minions
ADD COLUMN `town_id` INT,
ADD CONSTRAINT fk_town_id
FOREIGN KEY (town_id) REFERENCES towns(id);

INSERT INTO towns VALUES
(1, "Sofia"),
(2, "Plovdiv"),
(3, "Varna");

INSERT INTO minions VALUES
(1, "Kevin", 22, 1),
(2, "Bob", 15, 3),
(3, "Steward", NULL, 2);

DELETE FROM minions;
TRUNCATE TABLE minions;

DROP TABLE minions, towns;

CREATE TABLE `people` (
	`id` INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `picture` TEXT,
    `height` DOUBLE(10, 2),
    `weight` DOUBLE(10, 2),
    `gender` CHAR(1) NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` TEXT
);

INSERT INTO people VALUES
(1, "Gosho", "TEST", 1.90, 90, "m", "1990-01-01", "123"),
(2, "Stamat", "TEST", 1.90, 90, "m", "1990-01-01", "123"),
(3, "Ivan", "TEST", 1.90, 90, "m", "1990-01-01", "123"),
(4, "Gosho", "TEST", 1.90, 90, "m", "1990-01-01", "123"),
(5, "Maria", "TEST", 1.90, 90, "f", "1990-01-01", "123");

CREATE TABLE `users` (
	`id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL,
    `password` VARCHAR(26) NOT NULL,
    `profile_picture` TEXT,
    `last_login_time` DATETIME,
    `is_deleted` BOOLEAN
);

INSERT INTO users(`username`, `password`, `profile_picture`, `last_login_time`, `is_deleted`) VALUES
("Liliyan", "12345", NULL, "2024-09-10 20:11:45", false),
("Sasho", "12345", NULL, "2024-09-10 20:11:45", false),
("Ico", "12345", NULL, "2024-09-10 20:11:45", false),
("Vanessa", "12345", NULL, "2024-09-10 20:11:45", false),
("Geri", "12345", NULL, "2024-09-10 20:11:45", false);

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY(id, username);

ALTER TABLE users
MODIFY COLUMN `last_login_time` DATETIME DEFAULT NOW();

ALTER TABLE users
DROP PRIMARY KEY,
ADD PRIMARY KEY(id);

ALTER TABLE users
ADD UNIQUE(username);

CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors`(
	`id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `director_name` VARCHAR(100) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `genres`(
	`id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `genre_name` VARCHAR(100) NOT NULL,
    `notes` TEXT    
);

CREATE TABLE `categories`(
	`id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `category_name` VARCHAR(100) NOT NULL,
    `notes` TEXT    
);

CREATE TABLE `movies`(
	`id` INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `director_id` INT,
    `copyright_year` DATE,
    `length` DOUBLE(10, 2),
    `genre_id` INT,
    `category_id` INT,
    `rating` DOUBLE(5,2),
    `notes` TEXT
);

INSERT INTO directors(`director_name`, `notes`) VALUES
("Pesho", "Mladost"),
("Gosho", "Mladost"),
("Stamat", "Mladost"),
("Ivan", "Mladost"),
("Pesho", "Sci-fi");

INSERT INTO genres(`genre_name`, `notes`) VALUES
("Sci-fi", "Mladost"),
("Thriller", "Mladost"),
("Actopm", "Mladost"),
("Ivan", "Mladost"),
("Pesho", "Scifi");

INSERT INTO categories(`category_name`, `notes`) VALUES
("Above-18", "Mladost"),
("Below-18", "Mladost"),
("Actopm", "Mladost"),
("Ivan", "Mladost"),
("Pesho", "Scifi");

INSERT INTO movies VALUES
(1, "Harry Potter", 1, "2003-12-12", 2.30, 3, 2, 9.5, "Potter"),
(2, "Castle", 1, "2003-12-12", 2.30, 3, 2, 9.5, "Potter"),
(3, "Pod Prikritie", 1, "2003-12-12", 2.30, 3, 2, 9.5, "Potter"),
(4, "Listopad", 1, "2003-12-12", 2.30, 3, 2, 9.5, "Potter"),
(5, "Test", 1, "2003-12-12", 2.30, 3, 2, 9.5, "Potter");

CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `category` VARCHAR(100),
    `daily_rate` DOUBLE(10, 2),
    `weekly_rate` DOUBLE(10, 2),
    `monthly_rate` DOUBLE(10, 2),
    `weekend_rate` DOUBLE(10, 2)
);

CREATE TABLE `cars`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `plate_number` VARCHAR(10),
    `make` VARCHAR(50),
    `model` VARCHAR(50),
    `car_year` DATE,
    `category_id` INT,
    `doors` INT,
    `picture` BLOB,
    `car_condition` VARCHAR(50),
    `available` BOOLEAN
);

CREATE TABLE `employees`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(60),
    `last_name` VARCHAR(60),
    `title` VARCHAR(100),
    `notes` TEXT
);

CREATE TABLE `customers`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `driver_licence_number` INT,
    `full_name` VARCHAR(200),
    `address` VARCHAR(255),
    `city` VARCHAR(60),
    `zip_code` INT,
    `notes` TEXT
);

CREATE TABLE `rental_orders`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id` INT, 
    `customer_id` INT, 
    `car_id` INT, 
    `car_condition` VARCHAR(60), 
    `tank_level` DOUBLE(5, 2), 
	`kilometrage_start` INT, 
    `kilometrage_end` INT, 
    `total_kilometrage` INT, 
    `start_date` DATE, 
    `end_date` DATE, 
	`total_days` INT, 
    `rate_applied` DOUBLE(5, 2), 
    `tax_rate` DOUBLE(5, 2), 
    `order_status` VARCHAR(50), 
    `notes` TEXT
);

INSERT INTO categories(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`) VALUES
("SUV", 12, 20.5, 30.5, 40),
("Motorcycle", 12, 20.5, 30.5, 40),
("Bike", 12, 20.5, 30.5, 40);

INSERT INTO cars(`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`) VALUES
("SV1111SV", "Toyota", "Prius", "2014-12-31", 5, 4, NULL, "NOT GOOD NOT BAD", true),
("SV2222SV", "Toyota", "Prius", "2014-12-31", 5, 4, NULL, "NOT GOOD NOT BAD", true),
("SV3333SV", "Toyota", "Prius", "2014-12-31", 5, 4, NULL, "NOT GOOD NOT BAD", true);

INSERT INTO employees(`first_name`, `last_name`, `title`, `notes`) VALUES
("Gosho", "Georgiev", "Sales", "Vacation"),
("Pesho", "Georgiev", "Sales", "Vacation"),
("Ivan", "Georgiev", "Sales", "Vacation");

INSERT INTO customers(`driver_licence_number`, `full_name`, `address`, `city`, `zip_code`, `notes`) VALUES
(12345, "Gosho Georgiev", "jk. Oborishte 15", "Sofia", 1000, "Test"),
(123456, "Gosho Georgiev", "jk. Oborishte 15", "Sofia", 1000, "Test"),
(123457, "Gosho Georgiev", "jk. Oborishte 15", "Sofia", 1000, "Test");

INSERT INTO rental_orders(`employee_id`, `customer_id`, `car_id`, `car_condition`, `tank_level`, `kilometrage_start`, `kilometrage_end`, `total_kilometrage`, `start_date`, `end_date`, `total_days`, `rate_applied`, `tax_rate`, `order_status`, `notes`) VALUES
(1, 1, 1, "Good", 100, 50000, 60000, 10000, "2024-09-09", "2024-09-10", 1, 5.5, 10, "Finished", "TEST"),
(2, 1, 1, "Good", 100, 50000, 60000, 10000, "2024-09-09", "2024-09-10", 1, 5.5, 10, "Finished", "TEST"),
(3, 1, 1, "Good", 100, 50000, 60000, 10000, "2024-09-09", "2024-09-10", 1, 5.5, 10, "Finished", "TEST");

CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100)
);

CREATE TABLE `addresses`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `address_text` VARCHAR(255),
    `town_id` INT,
    
    FOREIGN KEY(town_id) REFERENCES towns(id)
);

CREATE TABLE `departments`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100)
);

CREATE TABLE `employees`(
	`id` INT PRIMARY KEY AUTO_INCREMENT, 
	`first_name` VARCHAR(100), 
	`middle_name` VARCHAR(100), 
	`last_name` VARCHAR(100), 
	`job_title` VARCHAR(100), 
	`department_id` INT, 
	`hire_date` DATE, 
	`salary` DOUBLE(20, 2), 
	`address_id` INT,
    
    FOREIGN KEY(department_id) REFERENCES departments(id),
    FOREIGN KEY(address_id) REFERENCES addresses(id)
);

INSERT INTO towns(`name`) VALUES
("Sofia"),
("Plovdiv"),
("Varna"),
("Burgas");

INSERT INTO departments(`name`) VALUES
("Engineering"),
("Sales"),
("Marketing"),
("Software Development"),
("Quality Assurance");

INSERT INTO employees(`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`) VALUES
("Ivan", "Ivanov", "Ivanov", ".NET Developer", 4, "2013-02-01", 3500),
("Petar", "Petrov", "Petrov", "Senior Engineer", 1, "2004-03-02", 4000),
("Maria", "Petrova", "Ivanova", "Intern", 5, "2016-08-28", 525.25),
("Georgi", "Terziev", "Ivanov", "CEO", 2, "2007-12-09", 3000),
("Peter", "Pan", "Pan", "Intern", 3, "2016-08-28",  599.88);

SELECT * FROM towns ORDER BY `name`;
SELECT * FROM departments ORDER BY `name`;
SELECT * FROM employees ORDER BY `salary` DESC;

SELECT `name` FROM towns ORDER BY `name`;
SELECT `name` FROM departments ORDER BY `name`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM employees ORDER BY `salary` DESC;

SET SQL_SAFE_UPDATES = 0;
UPDATE employees SET salary = salary * 1.1;
SELECT `salary` FROM employees;
 