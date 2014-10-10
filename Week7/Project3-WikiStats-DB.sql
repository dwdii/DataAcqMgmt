-- 1. Create a new database for the wiki stats data.
-- CREATE DATABASE wikidata;
DROP TABLE pageviews;
DROP TABLE page;
DROP TABLE language;

CREATE TABLE language (
	id serial PRIMARY KEY,
	languagecode VARCHAR(32) UNIQUE
);

CREATE TABLE page (
	id serial PRIMARY KEY,
	page text,
	languageid INT,
	pagemd5 varchar(64),

	UNIQUE(pagemd5, languageid),
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
-- Helper queries...

SELECT * FROM rawstage ORDER BY pageviews DESC LIMIT 10;

SELECT * FROM language;
SELECT * FROM page LIMIT 500;

SELECT * FROM pageviews LIMIT 100

SELECT * FROM rawstage ORDER BY pageviews DESC LIMIT 10000;

SELECT l.languagecode, pv.hourstamp, p.page, pv.pageviews FROM page p
	INNER JOIN pageviews pv ON pv.pageid = p.id
	INNER JOIN language l ON l.id = p.languageid
	WHERE pv.pageviews IS NOT NULL
	GROUP BY l.languagecode, pv.hourstamp, p.page, pv.pageviews
	ORDER BY pv.pageviews DESC
	LIMIT 5;

SELECT * FROM page WHERE pagemd5 = 'd41d8cd98f00b204e9800998ecf8427e' 

SELECT *, md5(page) FROM rawstage WHERE md5(page) = '15ff4db5cc280cddad02d28c2c4d1bb6' AND langid = 37

SELECT * FROM pageviews WHERE pageid = 916

SELECT hourstamp, COUNT(*) FROM pageviews GROUP BY hourstamp --WHERE hourstamp = '2009-10-03 02:00:00'
UPDATE pageviews SET hourstamp = '2008-10-01 01:00:00' WHERE hourstamp = '2009-10-01 01:00:00'

SELECT p.page, COALESCE(pv.pageviews, 0) FROM page p
  INNER JOIN pageviews pv ON pv.pageid = p.id
	WHERE pv.hourstamp = '2014-10-01 14:00:00'
	ORDER BY COALESCE(pv.pageviews, 0) DESC
	LIMIT 5;

*/

-- What are the five most used languages for each of the two hours?
SELECT hourstamp, l.languagecode, SUM(pv.pageviews) AS totalhits
FROM pageviews pv
	LEFT JOIN page p ON p.id = pv.pageid
	LEFT JOIN language l ON l.id = p.languageid
GROUP BY hourstamp, l.id, l.languagecode
ORDER BY hourstamp, totalhits DESC

-- Combined across the two hours?
SELECT l.languagecode, SUM(pv.pageviews) AS totalhits
FROM pageviews pv
	LEFT JOIN page p ON p.id = pv.pageid
	LEFT JOIN language l ON l.id = p.languageid
GROUP BY l.id, l.languagecode
ORDER BY totalhits DESC

-- Which topics (with more than “n” page views that you’ll decide upon) showed the largest 
-- increase in interest between the two hour that you charted?
SELECT p.page, COALESCE(pv1.pageviews, 0) AS hits1, COALESCE(pv2.pageviews, 0 ) AS hits2, COALESCE(pv2.pageviews, 0 ) - COALESCE(pv1.pageviews, 0) AS delta FROM page p
	LEFT JOIN pageviews pv1 ON pv1.pageid = p.id AND pv1.hourstamp = '2008-10-01 01:00:00'
	LEFT JOIN pageviews pv2 ON pv2.pageid = p.id AND pv2.hourstamp = '2008-10-03 02:00:00'
WHERE COALESCE(pv1.pageviews, 0)  > 1000 OR COALESCE(pv2.pageviews, 0 ) > 1000
ORDER BY COALESCE(pv2.pageviews, 0 ) - COALESCE(pv1.pageviews, 0) DESC
LIMIT 100
