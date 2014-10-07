-- 1. Create a new database for the wiki stats data.
-- CREATE DATABASE wikidata;
DROP TABLE pageviews;
DROP TABLE page;
DROP TABLE language;

CREATE TABLE language (
	id serial PRIMARY KEY,
	languagecode VARCHAR(6) UNIQUE
);

CREATE TABLE page (
	id serial PRIMARY KEY,
	page text UNIQUE,
	languageid INT,

	CONSTRAINT Page_Language FOREIGN KEY (languageid) REFERENCES language(id)
);

CREATE TABLE pageviews (
	id serial PRIMARY KEY,
	hourstamp timestamp without time zone, 
	pageid INT,
	pageviews INT,
	contentsize numeric(18,0),
	
	UNIQUE (hourstamp, pageid),
	CONSTRAINT PageView_Page FOREIGN KEY (pageid) REFERENCES page(id)

);

/*
SELECT * FROM rawstage ORDER BY pageviews DESC LIMIT 10;

SELECT * FROM language;
SELECT * FROM page LIMIT 100;

SELECT * FROM pageviews LIMIT 100

SELECT * FROM rawstage ORDER BY pageviews DESC LIMIT 10;

SELECT p.page, pv.pageviews FROM page p
	LEFT JOIN pageviews pv ON pv.pageid = p.id
	ORDER BY pv.pageviews DESC
	LIMIT 10;
	
*/