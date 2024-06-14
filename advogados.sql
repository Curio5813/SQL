--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 2737


CREATE TABLE lawyers(
  register INTEGER PRIMARY KEY,
  name VARCHAR(255),
  customers_number INTEGER
 );
  
  
 INSERT INTO lawyers(register, name, customers_number)
 VALUES (1648, 'Marty M. Harrison', 5),
	(2427, 'Jonathan J. Blevins', 15),
	(3365, 'Chelsey D. Sanders', 20),
	(4153, 'Dorothy W. Ford', 16),
	(5525, 'Penny J. Cormier', 6);



SELECT name, customers_number FROM (
	SELECT name, customers_number, 1 AS FILTER FROM lawyers
	WHERE 
	customers_number = (SELECT MAX(customers_number) FROM lawyers) 
	OR
	customers_number = (SELECT MIN(customers_number) FROM lawyers)
	UNION ALL 
  	SELECT 'Average', round(AVG(customers_number),0), 2 AS FILTER FROM lawyers) AS media
	ORDER BY FILTER, name;

	