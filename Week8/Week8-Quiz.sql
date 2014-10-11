-- 
-- Author: Daniel Dittenhafer
--
-- Created: Oct 11, 2014
--
-- Description: Answers to Week 8 Quiz
--
-- Create a database for the Apple Org Chart data
--CREATE DATABASE AppleOrgChart;

-------------------------------------------------------------------
-- 1. Create a single table that includes information for the CEO, 
--    the SVP of IOS Software, and the SVP, Chief Financial Officer.
--    Also include information for the direct reports of the two SVPs.
-- DROP TABLE personnel
CREATE TABLE personnel
(
	id serial PRIMARY KEY,
	fullname VARCHAR(128) NOT NULL,
	title VARCHAR(64) NOT NULL,
	managerid int,

	CONSTRAINT Personnel_Manager FOREIGN KEY (managerid) REFERENCES personnel(id)
);

INSERT INTO personnel (fullname, title, managerid) VALUES ('Steve Jobs', 'CEO', NULL);

INSERT INTO personnel (fullname, title, managerid) VALUES ('Scott Forstall', 'SVP, IOS Software', 1);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Peter Oppenheimer', 'SVP, Chief Financial Officer', 1);

INSERT INTO personnel (fullname, title, managerid) VALUES ('Henri Lamiraux', 'VP, Engineering, IOS Apps', 2);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Isabel Ge Mahe', 'VP, IOS Wireless Software', 2);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Kim Vorrath', 'VP, Program Management', 2);

INSERT INTO personnel (fullname, title, managerid) VALUES ('Betsy Rafael', 'VP, Controller', 3);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Gary Wipfler', 'VP, Treasurer', 3);

------------------------------------------------------------------
-- 2. Write a query that displays all of the information in th table.
SELECT p.*, mgr.fullname AS Manager, mgr.title AS MgrTitle FROM personnel p 
	LEFT JOIN personnel mgr ON mgr.id = p.managerid
	ORDER BY managerid;

------------------------------------------------------------------
-- 3. Assume that (a) Tim Cook replaces Steve Jobs as CEO, and (b) Apple 
--    hypothetically hires Susan Wojcicki away from Google to replace Time Cook 
--    as COO, with the COO reports unchanged.
-- 
-- First adding Tim Cook and his direct reports to the personnel table.
INSERT INTO personnel (fullname, title, managerid) VALUES ('Tim Cook', 'Chief Operating Officer', 1);

INSERT INTO personnel (fullname, title, managerid) VALUES ('John Couch', 'VP, Education Sales', 9);
INSERT INTO personnel (fullname, title, managerid) VALUES ('John Brandon', 'VP, Channel Sales', 9);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Michael Fenger', 'VP, iPhone Sales', 9);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Douglas Beck', 'VP, Apple Japan', 9);
INSERT INTO personnel (fullname, title, managerid) VALUES ('Jennifer Bailey', 'VP, Online Stores', 9);

-- Update Tim Cook to be CEO 
UPDATE personnel SET title = 'CEO', managerid = NULL WHERE id = 9; -- fullname = 'Tim Cook'

-- Add Susan Wojcicki, reporting to Tim Cook, and update COO direct reports to new COO.
--
-- Reference: http://stackoverflow.com/questions/15627781/postgresql-store-value-returned-by-returning
WITH NewCOO AS
(
	INSERT INTO personnel (fullname, title, managerid) VALUES ('Susan Wojcicki', 'Chief Operating Officer', 9) RETURNING id
)
UPDATE personnel SET managerid = NewCOO.id FROM NewCOO WHERE managerid = 9 and personnel.id != NewCOO.id;

-- Helper during development of above CTE based INSERT/UPDATE
--DELETE FROM personnel WHERE fullname = 'Susan Wojcicki'

-- Now update the CEO's direct reports from Steve Jobs to Tim Cook
UPDATE personnel SET managerid = 9 WHERE managerid = 1;

-- And remove Steve Jobs
DELETE FROM personnel WHERE id = 1;




