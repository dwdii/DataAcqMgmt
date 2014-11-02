CREATE TABLE state (
	id serial PRIMARY KEY,
	state_abbrev VARCHAR(2) UNIQUE,
	code int
);

CREATE TABLE area (
	id serial PRIMARY KEY,
	area_name VARCHAR(128),
	stateid int,

	CONSTRAINT Area_State FOREIGN KEY (stateid) REFERENCES state(id)
);

--DROP TABLE area

CREATE TABLE county (
	id serial PRIMARY KEY,
	county_name VARCHAR(128),
	code int,
	areaid int,

	CONSTRAINT County_Area FOREIGN KEY (areaid) REFERENCES area(id)
);

--DROP TABLE county


CREATE TABLE county_town (
	id serial PRIMARY KEY,
	county_town_name VARCHAR(128),
	pop2010 int,
	countyid int,

	CONSTRAINT CountyTown_County FOREIGN KEY (countyid) REFERENCES county(id)
);

--DROP TABLE county_town

CREATE TABLE fmr (
	id serial PRIMARY KEY,
	bedrooms int,
	fmr int,
	county_townid int,

	CONSTRAINT Fmr_CountyTown FOREIGN KEY (county_townid) REFERENCES county_town(id)
);

CREATE TABLE staging (
	fips2000 VARCHAR(128),
	fips2010 VARCHAR(128),
	fmr2 VARCHAR(128),
	fmr0 VARCHAR(128),
	fmr1 VARCHAR(128),
	fmr3 VARCHAR(128),
	fmr4 VARCHAR(128),
	county VARCHAR(128),
	state VARCHAR(128),
	cousub VARCHAR(128),	
	countyname VARCHAR(128),
	metro_code VARCHAR(128),
	areaname VARCHAR(128),
	county_town_name VARCHAR(128),
	pop2010 VARCHAR(128),
	state_alpha VARCHAR(128),
	fmr_type VARCHAR(128),
	metro VARCHAR(128)
);

SELECT * FROM state
--DELETE FROM state WHERE id = 1

SELECT * FROM county c
	LEFT JOIN state s ON s.id = c.stateid
	WHERE county_name = 'Brevard County'

SELECT * FROM area a
	LEFT JOIN county c ON c.id = a.countyid
	LEFT JOIN state s ON s.id = c.stateid

SELECT * FROM county_town ct
	LEFT JOIN county c ON c.id = ct.countyid
	LEFT JOIN area a ON a.id = c.areaid
	LEFT JOIN state s ON s.id = a.stateid
	WHERE c.county_name LIKE 'Union%'

SELECT * FROM fmr f
	LEFT JOIN county_town ct ON ct.id = f.county_townid
	LEFT JOIN county c ON c.id = ct.countyid
	LEFT JOIN area a ON a.id = c.areaid
	LEFT JOIN state s ON s.id = a.stateid
	WHERE c.county_name LIKE 'Brevard%'	

SELECT * FROM staging WHERE state_alpha = 'PR'
--DELETE FROM staging

-- Normalize state info
INSERT INTO state (state_abbrev, code) SELECT DISTINCT state_alpha, to_number(state, '99') FROM staging ORDER BY state_alpha

-- Normalize area info
INSERT INTO area (area_name, stateid) 
	SELECT DISTINCT areaname, s.id
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		ORDER BY areaname

-- Normalize county info
INSERT INTO county (county_name, code, areaid) 
	SELECT DISTINCT countyname, to_number(county, '999'), a.id 
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha 
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		ORDER BY countyname

-- Normalize county_town info
INSERT INTO county_town (county_town_name, countyid, pop2010) 
	SELECT DISTINCT county_town_name, c.id, to_number(pop2010, '999999999')
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		LEFT JOIN county c ON c.county_name = st.countyname AND c.areaid = a.id
		ORDER BY county_town_name

INSERT INTO fmr (bedrooms, fmr, county_townid) 
	SELECT 0, to_number(fmr0, '999999'), ct.id
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		LEFT JOIN county c ON c.county_name = st.countyname AND c.areaid = a.id
		LEFT JOIN county_town ct ON ct.county_town_name = st.county_town_name AND ct.countyid = c.id

INSERT INTO fmr (bedrooms, fmr, county_townid) 
	SELECT 1, to_number(fmr1, '999999'), ct.id
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		LEFT JOIN county c ON c.county_name = st.countyname AND c.areaid = a.id
		LEFT JOIN county_town ct ON ct.county_town_name = st.county_town_name AND ct.countyid = c.id		

INSERT INTO fmr (bedrooms, fmr, county_townid) 
	SELECT 2, to_number(fmr2, '999999'), ct.id
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		LEFT JOIN county c ON c.county_name = st.countyname AND c.areaid = a.id
		LEFT JOIN county_town ct ON ct.county_town_name = st.county_town_name AND ct.countyid = c.id

INSERT INTO fmr (bedrooms, fmr, county_townid) 
	SELECT 3, to_number(fmr3, '999999'), ct.id
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		LEFT JOIN county c ON c.county_name = st.countyname AND c.areaid = a.id
		LEFT JOIN county_town ct ON ct.county_town_name = st.county_town_name AND ct.countyid = c.id

INSERT INTO fmr (bedrooms, fmr, county_townid) 
	SELECT 4, to_number(fmr4, '999999'), ct.id
		FROM staging st
		LEFT JOIN state s ON s.state_abbrev = st.state_alpha
		LEFT JOIN area a ON a.area_name = st.areaname AND a.stateid = s.id
		LEFT JOIN county c ON c.county_name = st.countyname AND c.areaid = a.id
		LEFT JOIN county_town ct ON ct.county_town_name = st.county_town_name AND ct.countyid = c.id

