CREATE TABLE flights_raw
(
	flight INT,
	airline VARCHAR(32),
	depart VARCHAR(6),
	arrive VARCHAR(6),
	capacity INT,
	takeoff INT,
	landing INT
);

CREATE TABLE airports_raw
(
	label VARCHAR(6),
	city VARCHAR(32),
	state VARCHAR(32)
);

--DROP TABLE airports;

CREATE TABLE airlines
(
	id serial PRIMARY KEY,
	name VARCHAR(32),
	UNIQUE(name)
);

--DROP TABLE airlines;

CREATE TABLE airports
(
	id serial primary key,
	label VARCHAR(6),
	city VARCHAR(32),
	state VARCHAR(32),
	UNIQUE(label)
);

CREATE TABLE flights
(
	id serial PRIMARY KEY,
	flightnum INT,
	airlineid INT,
	depart_airportid INT,
	arrive_airportid INT,
	capacity INT,
	takeoff INT,
	landing INT,

	CONSTRAINT flight_airline FOREIGN KEY (airlineid) REFERENCES airlines(id),
	CONSTRAINT depart_airport FOREIGN KEY (depart_airportid) REFERENCES airports(id),
	CONSTRAINT arrive_airport FOREIGN KEY (arrive_airportid) REFERENCES airports(id)
);

-- ETL
/*
INSERT INTO airlines (name) SELECT DISTINCT airline FROM flights_raw

INSERT INTO airports (label, city, state) SELECT DISTINCT label, city, state FROM airports_raw;

INSERT INTO flights (flightnum, airlineid, depart_airportid, arrive_airportid, capacity, takeoff, landing)
	SELECT flight, a.id, d.id, o.id, capacity, takeoff, landing
		FROM flights_raw f
			INNER JOIN airlines a ON a.name = f.airline
			INNER JOIN airports d ON d.label = f.depart
			INNER JOIN airports o ON o.label = f.arrive;
*/

SELECT * FROM flights_raw;

SELECT * FROM airports_raw;
SELECT * FROM airports;
SELECT * FROM airlines;

SELECT a.name AS AirlineName, d.city AS Departed,  o.city AS Arrived, f.* FROM flights f
	INNER JOIN airlines a ON a.id = f.airlineid
	INNER JOIN airports d ON d.id = f.depart_airportid
	INNER JOIN airports o ON o.id = f.arrive_airportid;

CREATE INDEX ndx_airlineid ON flights (airlineid ASC);
CREATE INDEX ndx_depart_airportid ON flights (airlineid ASC);
CREATE INDEX ndx_arrive_airportid ON flights (airlineid ASC);

