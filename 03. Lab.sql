SELECT id, SUBSTRING(title, 5) FROM books;

SELECT SUBSTRING('abcdefg', 3);
SELECT SUBSTRING('abcdefg', 3, 2);

SELECT title FROM books WHERE SUBSTRING(title, 1, 3) = 'The' ORDER BY id;

SELECT REPLACE('Some string', 'str', 'spr');

SELECT 
	REPLACE(title, 'The', '***') AS 'Title' 
FROM books 
WHERE SUBSTRING(title, 1, 3) = 'The' 
ORDER BY id;

SELECT
	REPLACE(
		REPLACE('The Dead Zone', 'The', '***'),
        'Zone',
        '****'
	);

SELECT LTRIM('   text');
SELECT RTRIM('text     ');
SELECT LTRIM(RTRIM('   text   '));

SELECT LEFT('Some Title', 2);

SELECT LOWER('The');

SELECT REVERSE('Some Text');

SELECT REPEAT('Re', 3);

SELECT LOCATE('de', 'The Dead Zone');
SELECT LOCATE('de', 'The Dead Zone', 6);

SELECT INSERT('Simple String', 1, 6, 'Complex');
SELECT INSERT('Simple String', 1, 0, 'Complex');

SELECT INSERT('Simple String', LOCATE('Simple', 'Simple String'), 6, 'Complex');

SELECT CONV(13, 10, 2), CONV(1101, 2, 10);

SELECT ROUND(3.8729, 3);
SELECT FLOOR(3.2), CEILING(3.2);

SELECT RAND();

SELECT EXTRACT(YEAR_MONTH FROM NOW());

SELECT TIMESTAMPDIFF(DAY, '2022-10-02 16:53:22', NOW());

-- SELECT 
-- 	CONCAT_WS(' ', first_name, last_name) AS 'Full Name', 
-- 	IF(died IS NULL, '(NULL)', TIMESTAMPDIFF(DAY, born, died)) AS 'Days Lived'
-- FROM authors;

SELECT 
	CONCAT_WS(' ', first_name, last_name) AS 'Full Name', 
	TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

SELECT DATE_FORMAT('2017/05/31', '%Y %b %D');
SELECT DATE_FORMAT(NOW(), '%d-%m-%Y');

SELECT title FROM books WHERE title LIKE 'Harry Potter%';

SELECT * FROM authors WHERE first_name LIKE 'a%' OR first_name LIKE 'd%';
SELECT * FROM authors WHERE first_name REGEXP '^[ad]';

SELECT * FROM authors WHERE first_name REGEXP '^[^l]';

SELECT ROUND(SUM(cost), 2) AS 'Total Price' FROM books;
