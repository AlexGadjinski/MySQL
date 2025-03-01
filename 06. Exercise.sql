SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees AS e
JOIN addresses AS a
	ON e.address_id = a.address_id
ORDER BY e.address_id LIMIT 5;

SELECT e.first_name, e.last_name, t.name AS town, a.address_text
FROM employees AS e
JOIN addresses AS a
	ON e.address_id = a.address_id
JOIN towns t
	ON t.town_id = a.town_id
ORDER BY e.first_name, e.last_name LIMIT 5;

SELECT e.employee_id, e.first_name, e.last_name, d.name AS department_name
FROM employees AS e
JOIN departments AS d
	ON d.department_id = e.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;

SELECT e.employee_id, e.first_name, e.salary, d.name AS department_name
FROM employees AS e
JOIN departments AS d
	ON e.department_id = d.department_id
WHERE salary > 15000
ORDER BY d.department_id DESC LIMIT 5;

SELECT e.employee_id, e.first_name
FROM employees AS e
LEFT JOIN employees_projects AS ep
	ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC LIMIT 3;

SELECT e.first_name, e.last_name, e.hire_date, d.name AS dept_name
FROM employees AS e
JOIN departments AS d
	ON e.department_id = d.department_id
WHERE e.hire_date > '1999-01-01' AND d.name IN ('Sales', 'Finance')
ORDER BY hire_date;

SELECT e.employee_id, e.first_name, p.name AS project_name
FROM employees e
JOIN employees_projects AS ep
	ON e.employee_id = ep.employee_id
JOIN projects AS p
	ON ep.project_id = p.project_id
WHERE DATE(start_date) > '2002-08-13' AND end_date IS NULL
ORDER BY e.first_name, project_name LIMIT 5;

SELECT 
	e.employee_id, 
	e.first_name,
    IF (YEAR(p.start_date) >= 2005, NULL, p.name) AS project_name
FROM employees AS e
JOIN employees_projects AS ep
	ON e.employee_id = ep.employee_id
JOIN projects AS p
	ON p.project_id = ep.project_id
WHERE e.employee_id = 24
ORDER BY project_name;

SELECT e.employee_id, e.first_name, e.manager_id, m.first_name AS manager_name
FROM employees AS e
JOIN employees AS m
	ON e.manager_id = m.employee_id
WHERE e.manager_id IN (3, 7)
ORDER BY e.first_name;

SELECT 
	e.employee_id, 
	CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
	CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    d.name AS department_name
FROM employees AS e
JOIN employees AS m
	ON e.manager_id = m.employee_id
JOIN departments AS d
	ON e.department_id = d.department_id
ORDER BY employee_id LIMIT 5;

SELECT AVG(salary) AS min_average_salary FROM employees
GROUP BY department_id
ORDER BY min_average_salary LIMIT 1;

SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM mountains_countries AS mc
JOIN mountains AS m
	ON mc.mountain_id = m.id
JOIN peaks AS p
	ON p.mountain_id = m.id
WHERE mc.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;

SELECT country_code, COUNT(*) AS mountain_range
FROM mountains_countries AS mc
WHERE country_code IN ('BG', 'RU', 'US')
GROUP BY country_code
ORDER BY mountain_range DESC;

SELECT c.country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers AS cr
	ON c.country_code = cr.country_code
LEFT JOIN rivers AS r
	ON cr.river_id = r.id
WHERE c.continent_code = 'AF'
ORDER BY country_name LIMIT 5;

SELECT 
	continent_code, 
    currency_code,
    COUNT(*) AS currency_usage
FROM countries AS c
GROUP BY continent_code, currency_code
HAVING currency_usage > 1 AND currency_usage = (
						SELECT COUNT(*) AS currency_usage FROM countries
                        WHERE continent_code = c.continent_code
						GROUP BY currency_code
						ORDER BY currency_usage DESC LIMIT 1
                        )
ORDER BY continent_code, currency_code;

SELECT COUNT(*) AS country_count
FROM countries AS c
LEFT JOIN mountains_countries AS mc
	ON c.country_code = mc.country_code
WHERE mountain_id IS NULL;

SELECT c.country_name, MAX(p.elevation) AS highest_peak_elevation, MAX(r.length) AS longest_river_length
FROM countries AS c
LEFT JOIN mountains_countries AS mc
	ON mc.country_code = c.country_code
LEFT JOIN peaks AS p
	ON p.mountain_id = mc.mountain_id
LEFT JOIN countries_rivers AS cr
	ON cr.country_code = c.country_code
LEFT JOIN rivers AS r
	ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name LIMIT 5;
