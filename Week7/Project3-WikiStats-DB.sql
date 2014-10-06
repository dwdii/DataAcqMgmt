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
	page text,
	languageid INT,

	CONSTRAINT Page_Language FOREIGN KEY (languageid) REFERENCES language(id)
);

CREATE TABLE pageviews (
	id serial PRIMARY KEY,
	hourstamp timestamp without time zone, 
	pageid INT,
	contentsize numeric(18,0),
	
	UNIQUE (hourstamp, pageid),
	CONSTRAINT PageView_Page FOREIGN KEY (pageid) REFERENCES page(id)

);

