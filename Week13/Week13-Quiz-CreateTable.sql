CREATE TABLE ObjectList
(
	id serial PRIMARY KEY,
	name VARCHAR(64),
	description VARCHAR(256)
);

SELECT upsert_description('Jeep', 'maroon');
SELECT upsert_description('Prius', 'gold');
SELECT upsert_description('Odyssey', 'blue');
SELECT upsert_description('Prius', 'silver');

SELECT * FROM ObjectList;

--DELETE FROM ObjectList