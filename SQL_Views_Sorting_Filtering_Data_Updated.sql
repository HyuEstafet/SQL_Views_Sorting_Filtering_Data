-- Create table customers_addresses with primary key (auto increment) and
-- address, city (mandatory field), province, state - for US addresses,postal code - a positive number, mandatory field,country - mandatory field

CREATE TABLE customers_addresses (
customer_addresses_id SERIAL PRIMARY KEY,
address VARCHAR (1000),
city VARCHAR (255) NOT NULL,
province VARCHAR (255),
state VARCHAR (255) DEFAULT NULL,
postal_code INT CHECK (postal_code > 0),
country VARCHAR (255) NOT NULL
);

INSERT INTO customers_addresses (address,city,province,state,postal_code,country)
VALUES 
('25 Maritza blvd','Plovdiv','Plovdiv',NULL,4003,'Bulgaria'),
('9 Vitosha blvd','Sofia','Sofia',NULL,1000,'Bulgaria'),
('12 Tyler Place str','Highgate Springs','St Albans','Vermont',12345,'USA'),
('29 Dale Close str','Dunstable','Bedfordshire',NULL,2929,'UK');

-- Create a view bulgarian_customers_addresses which contains only addreses in Bulgaria;
CREATE VIEW bulgarian_customers_addresses AS
SELECT * FROM customers_addresses
WHERE country = 'Bulgaria';

-- Drop the view
DROP VIEW bulgarian_customers_addresses;

-- Filtering customers_addresses data
-- get a list of countries ordered alphabetically
SELECT DISTINCT country FROM customers_addresses
ORDER BY country;

-- Inserting some cities strating with the same letter (needed for the next task)
INSERT INTO customers_addresses (address,city,province,state,postal_code,country)
VALUES 
('14 Pleven blvd','Pazardzhik','Pazardzhik',NULL,3003,'Bulgaria'),
('34 Republika str','Peshtera','Pazardzhik',NULL,2003,'Bulgaria');

DELETE FROM customers_addresses WHERE city = 'Pleven';

-- get a list of cities that start with a specific letter (for example cities that start with letter S will return Sofia, Sozopol etc)
SELECT city FROM customers_addresses
WHERE city LIKE 'P%';

-- get 3 random cities located in Bulgaria
SELECT city FROM customers_addresses
WHERE country = 'Bulgaria'
ORDER BY RANDOM()
LIMIT 3;

-- get 3 random DIFFERENT cities located in Bulgaria
SELECT * FROM (SELECT DISTINCT city
FROM customers_addresses
WHERE country = 'Bulgaria') AS different_random_cities
ORDER BY RANDOM() 
LIMIT 3;

-- Inserting a record for Varna (needed for the next task)
INSERT INTO customers_addresses (address,city,province,state,postal_code,country)
VALUES 
('14 Osvobozhdenie','Varna','Varna',NULL,6003,'Bulgaria');

-- get a list of all addresses in Bulgaria outside of Sofia, Plovdiv, Varna
SELECT address FROM customers_addresses
WHERE country = 'Bulgaria'
AND city NOT IN ('Sofia','Plovdiv','Varna');

-- Inserting a few more records (needed for the next task)
INSERT INTO customers_addresses (address,city,province,state,postal_code,country)
VALUES 
('14 Rozova Dolina str','Karlovo','Karlovo',NULL,3907,'Bulgaria'),
('99 Makedoniya blvd','Karlovo','Kalofer',NULL,3007,'Bulgaria'),
('5 Izgrev str','Karlovo','Banya',NULL,3107,'Bulgaria'),
('16 Knyaz Boris blvd','Plovdiv','Plovdiv',NULL,4002,'Bulgaria'),
('7 Svoboda str','Plovdiv','Plovdiv',NULL,4010,'Bulgaria');

-- get last 10 added customer addresses with a province and address filled, but without a state value
SELECT address FROM customers_addresses
WHERE province IS NOT NULL
AND address IS NOT NULL
AND state IS NULL
ORDER BY address DESC LIMIT 10;

-- get addresses that have 4-digit postal code that start with 3 and end with 7. Order the result alpabetically by country and city
SELECT address,country,city FROM customers_addresses
WHERE postal_code ::TEXT LIKE '3__7'
ORDER BY country,city;