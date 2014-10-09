-- 1. Create a new database in PostgreSQL.
-- CREATE DATABASE DittenhaferWeek7Hw;

-- 2.Populate your newly created database with two tables that have a one-to-many relationship. You should
-- create the two tablesusign the CREATE TABLE command. There should be at least one example each of 
-- integer, numeric, character and date data types in at least one of the two tables. There should be
-- at leastone character column that allows NULLs. 
CREATE TABLE vehicle 
(
	id serial NOT NULL PRIMARY KEY,
	make VARCHAR(64) NOT NULL,
	model VARCHAR(64) NOT NULL,
	year int NOT NULL,
	description VARCHAR(128) NULL,
	retailprice numeric(12,2),
	availablestarting timestamp,

	UNIQUE(make, model, year)
);

CREATE TABLE vehiclepart
(
	id serial NOT NULL PRIMARY KEY,
	name VARCHAR(64) NOT NULL,
	partnumber VARCHAR(64) NOT NULL,
	vehicleid int,

	UNIQUE(partnumber, vehicleid),
	CONSTRAINT VehiclePart_Vehicle FOREIGN KEY (vehicleid) REFERENCES vehicle(id)

);

-- 3. Populate the two tables with some sample data, using INSERT statements. Each table should contain at least three records, and
--    the data shoudl accurately reflect the one-to-many relationship. These should also be at least one row where the character
--    column that allows NULL values has a value of NULL. 
INSERT INTO vehicle (make, model, year, description, retailprice, availablestarting) VALUES ('Toyota', 'Prius', 2010, 'Hybrid', 20000, '2009-09-01');
INSERT INTO vehicle (make, model, year, description, retailprice, availablestarting) VALUES ('Ford', 'Explorer', 1998, 'SUV', 21000, '1997-09-01');
INSERT INTO vehicle (make, model, year, description, retailprice, availablestarting) VALUES ('Jeep', 'Wrangler', 2001, NULL, 19000, '2000-09-01');

INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Hybrid Battery', '102030495', 1);
INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Solar Panel', '10204987', 1);
INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Synergy Engine', '102030908', 1);


INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Bucket seat', '219030495', 2);
INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Space tire', '219030105', 2);
INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Gas cap', '219030123', 2);

INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Rollbar', '345030432', 3);
INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Air snorkle', '345030654', 3);
INSERT INTO vehiclepart (name, partnumber, vehicleid) VALUES ('Soft top', '345030765', 3);

-- 4. Provie samples of the different kinds of joins across the two tables. You should include
--    one join that performs a WHERE on the COLUMN that allows a NULL value. 
SELECT * FROM vehicle v
  INNER JOIN vehiclepart vp ON vp.vehicleid = v.id 

SELECT make, model, year, retailprice, availablestarting 
	FROM vehicle v
		LEFT JOIN vehiclepart vp ON vp.vehicleid = v.id
	WHERE description LIKE '%bri%'

SELECT make, model, vp.name AS partname, vp.partnumber FROM vehiclepart vp
	INNER JOIN vehicle v ON v.id = vp.vehicleid
