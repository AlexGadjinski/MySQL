CREATE DATABASE go_roadie;
USE go_roadie;

CREATE TABLE cities(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE cars(
	id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(20) NOT NULL,
	model VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE instructors(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL UNIQUE,
    has_a_license_from DATE NOT NULL
);

CREATE TABLE driving_schools(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE,
    night_time_driving BOOLEAN NOT NULL,
    average_lesson_price DECIMAL(10, 2),
    car_id INT NOT NULL,
    city_id INT NOT NULL,
    
    FOREIGN KEY(car_id) REFERENCES cars(id),
    FOREIGN KEY(city_id) REFERENCES cities(id)
);

CREATE TABLE students(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL UNIQUE,
    age INT,
    phone_number VARCHAR(20) UNIQUE
);

CREATE TABLE instructors_driving_schools(
	instructor_id INT,
    driving_school_id INT NOT NULL,
    
    KEY(instructor_id, driving_school_id),
    FOREIGN KEY(instructor_id) REFERENCES instructors(id),
    FOREIGN KEY(driving_school_id) REFERENCES driving_schools(id)
);

CREATE TABLE instructors_students(
	instructor_id INT NOT NULL,
    student_id INT NOT NULL,
    
    KEY(instructor_id, student_id),
    FOREIGN KEY(instructor_id) REFERENCES instructors(id),
    FOREIGN KEY(student_id) REFERENCES students(id)
);

INSERT INTO students(first_name, last_name, age, phone_number)
SELECT 
	LOWER(REVERSE(first_name)),
	LOWER(REVERSE(last_name)),
    age + LEFT(phone_number, 1),
    CONCAT('1+', phone_number)
FROM students
WHERE age < 20;

UPDATE driving_schools
SET average_lesson_price = average_lesson_price + 30
WHERE city_id = 5 AND night_time_driving = 1;

DELETE FROM instructors_driving_schools
WHERE driving_school_id IN (
	SELECT id 
    FROM driving_schools
    WHERE night_time_driving = 0
);

DELETE FROM driving_schools WHERE night_time_driving = 0;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, age
FROM students
WHERE first_name LIKE '%a%' AND age = (SELECT MIN(age) FROM students)
ORDER BY id;

SELECT ds.id, ds.name, c.brand
FROM driving_schools AS ds
LEFT JOIN instructors_driving_schools AS ids
	ON ids.driving_school_id = ds.id
JOIN cars c
	ON ds.car_id = c.id
WHERE instructor_id IS NULL
ORDER BY brand, ds.id LIMIT 5;

SELECT 
	i.first_name, 
	i.last_name, 
	COUNT(*) AS students_count, 
	(
    SELECT c.name FROM cities c
    JOIN driving_schools ds ON c.id = ds.city_id
    JOIN instructors_driving_schools ids ON ds.id = ids.driving_school_id
    WHERE i.id = ids.instructor_id
    ) AS city
FROM instructors AS i
JOIN instructors_students AS ins
	ON i.id = ins.instructor_id
JOIN instructors_driving_schools AS ids
	ON i.id = ids.instructor_id
JOIN driving_schools AS ds
	ON ids.driving_school_id = ds.id
JOIN cities AS c
	ON ds.city_id = c.id
GROUP BY i.id
HAVING COUNT(*) > 1
ORDER BY students_count DESC, i.first_name;






