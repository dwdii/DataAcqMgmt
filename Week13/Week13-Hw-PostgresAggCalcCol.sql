CREATE TABLE honorroll
(
	id serial PRIMARY KEY,
	housingid integer,
	countOfAorB integer,
	created timestamp,
	
	minutessincecreated integer,
	modified timestamp
);
--DROP TABLE honorroll;

CREATE OR REPLACE FUNCTION f_honorroll_calcminsincecreated()
RETURNS TRIGGER
AS $$
    BEGIN
	    IF TG_OP = 'INSERT' THEN
		NEW.created := current_timestamp;
	    ELSIF TG_OP = 'UPDATE' THEN
		NEW.created := OLD.created;
	    END IF;
	    NEW.minutessincecreated := cast(extract(EPOCH FROM age(current_timestamp, NEW.created)) / 60 as int);
	    NEW.modified := current_timestamp;

	    RETURN NEW;
    END;
    $$
LANGUAGE plpgsql;

CREATE TRIGGER honorroll_calcminsincecreated 
BEFORE INSERT OR UPDATE ON honorroll
FOR EACH ROW
EXECUTE PROCEDURE f_honorroll_calcminsincecreated();

INSERT INTO honorroll (housingid, countofaorb)
	SELECT h.id, COUNT(grade) FROM courses c 
	INNER JOIN housing h ON h.givenname = c.givenname AND h.surname = c.surname
	WHERE c.grade IN ('A', 'B')
	GROUP BY h.id
	HAVING COUNT(grade) > 1;
--DELETE FROM honorroll

SELECT * FROM honorroll;

--SELECT extract(EPOCH FROM age(current_timestamp, current_timestamp));

UPDATE honorroll SET countofaorb = 3 WHERE id = 12
