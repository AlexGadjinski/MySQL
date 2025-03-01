CREATE DATABASE summer_olympics;
USE summer_olympics;

CREATE TABLE countries(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE sports(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE disciplines(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE,
    sport_id INT NOT NULL,
    
    FOREIGN KEY(sport_id) REFERENCES sports(id)
);

CREATE TABLE athletes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    age INT NOT NULL,
    country_id INT NOT NULL,
    
    FOREIGN KEY(country_id) REFERENCES countries(id)
);

CREATE TABLE medals(
	id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE disciplines_athletes_medals(
	discipline_id INT NOT NULL,
    athlete_id INT NOT NULL,
    medal_id INT NOT NULL,
    
    PRIMARY KEY(discipline_id, athlete_id),
    FOREIGN KEY(discipline_id) REFERENCES disciplines(id),
    FOREIGN KEY(athlete_id) REFERENCES athletes(id),
    FOREIGN KEY(medal_id) REFERENCES medals(id)
);

INSERT INTO athletes(first_name, last_name, age, country_id)
SELECT
	UPPER(first_name),
    CONCAT(last_name, ' comes from ', (SELECT c.name FROM countries AS c
										JOIN athletes AS a
										ON a.country_id = c.id LIMIT 1)),
	age + country_id,
    country_id
    FROM athletes
WHERE country_id IN (SELECT id FROM countries WHERE name LIKE 'A%');

SET SQL_SAFE_UPDATES = 0;
UPDATE disciplines SET name = REPLACE(name, 'weight', '');

DELETE FROM athletes WHERE age > 35;

SELECT c.id, c.name
FROM countries AS c
LEFT JOIN athletes AS a
	ON c.id = a.country_id
WHERE a.id IS NULL
ORDER BY c.name DESC LIMIT 15;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, age
FROM disciplines_athletes_medals AS dam
JOIN athletes AS a
	ON dam.athlete_id = a.id
GROUP BY dam.athlete_id
HAVING a.age = (SELECT MIN(age) FROM athletes)
ORDER BY dam.athlete_id LIMIT 2;

SELECT a.id, a.first_name, a.last_name
FROM athletes AS a
LEFT JOIN disciplines_athletes_medals AS dam
	ON dam.athlete_id = a.id
WHERE dam.athlete_id IS NULL
ORDER BY id;

SELECT 
	athlete_id AS id,
	a.first_name,
    a.last_name,
    COUNT(*) AS medals_count,
    (
    SELECT s.name FROM sports s
    JOIN disciplines d ON d.sport_id = s.id
    JOIN disciplines_athletes_medals AS dam ON dam.discipline_id = d.id
    WHERE dam.athlete_id = a.id LIMIT 1
    ) AS sport
FROM athletes AS a
JOIN disciplines_athletes_medals AS dam
	ON a.id = dam.athlete_id
JOIN disciplines AS d
	ON dam.discipline_id = d.id
JOIN sports s
	ON d.sport_id = s.id
GROUP BY athlete_id
ORDER BY medals_count DESC, a.first_name LIMIT 10;

-- SELECT * FROM sports JOIN disciplines ON disciplines.sport_id = sports.id;

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    CASE
		WHEN age <= 18 THEN 'Teenager'
        WHEN age <= 25 THEN 'Young adult'
        WHEN age >= 26 THEN 'Adult'
    END AS age_group
FROM athletes
ORDER BY age DESC, first_name

DELIMITER $$

DROP FUNCTION IF EXISTS udf_total_medals_count_by_country;
CREATE FUNCTION udf_total_medals_count_by_country (name VARCHAR(40))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (
			SELECT COUNT(*) FROM countries AS c
            JOIN athletes AS a ON a.country_id = c.id
            JOIN disciplines_athletes_medals AS dam ON dam.athlete_id = a.id
            WHERE c.name = name
            ORDER BY a.id
    );
    
END $$

DROP PROCEDURE IF EXISTS udp_first_name_to_upper_case;
CREATE PROCEDURE udp_first_name_to_upper_case (letter CHAR(1))
BEGIN
	UPDATE athletes SET first_name = UPPER(first_name)
    WHERE RIGHT(first_name, 1) = letter;
END $$

DELIMITER ;

SELECT c.name, udf_total_medals_count_by_country ('Bahamas') AS count_of_medals
FROM countries c
WHERE c.name = 'Bahamas';

SET SQL_SAFE_UPDATES = 0;
CALL udp_first_name_to_upper_case ('s');

