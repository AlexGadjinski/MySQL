CREATE DATABASE `mountainsAndPeaks`;
USE mountainsAndPeaks;

CREATE TABLE mountains(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE peaks(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    mountain_id INT,
    
    CONSTRAINT fk_peaks_mountains
    FOREIGN KEY(mountain_id) REFERENCES mountains(id)
);

SELECT v.driver_id, v.vehicle_type, CONCAT(c.first_name, ' ', c.last_name) AS driver_name
FROM vehicles AS v
JOIN campers AS c ON c.id = v.driver_id;

SELECT v.driver_id, v.vehicle_type, CONCAT(c.first_name, ' ', c.last_name) AS driver_name
FROM campers AS c
JOIN vehicles AS v ON v.driver_id = c.id;


CREATE TABLE mountains(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE peaks(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    mountain_id INT,
    
    CONSTRAINT fk_peaks_mountains
    FOREIGN KEY(mountain_id) REFERENCES mountains(id) ON DELETE CASCADE
);

SELECT 
	r.starting_point AS route_starting_point, 
    r.end_point AS route_ending_point, 
    r.leader_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS leader_name
FROM campers AS c
JOIN routes AS r ON r.leader_id = c.id;

CREATE TABLE clients(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) 
);

CREATE TABLE projects(
	id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    project_lead_id INT,
    
    FOREIGN KEY(client_id) REFERENCES clients(id)
);

CREATE TABLE employees(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    project_id INT,
    FOREIGN KEY(project_id) REFERENCES projects(id)
);

ALTER TABLE projects
ADD FOREIGN KEY(project_lead_id) REFERENCES employees(id);
