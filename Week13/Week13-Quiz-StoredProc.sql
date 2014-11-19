CREATE OR REPLACE FUNCTION
    upsert_description(thename text, thedescription text)
RETURNS INT
AS $$

    DECLARE theid INT;
    BEGIN
	    SELECT  ID FROM ObjectList WHERE name = theName INTO theid;
	    IF theid IS NOT NULL THEN
	         UPDATE ObjectList SET description = theDescription WHERE ID = theid;
	    ELSE
		INSERT INTO ObjectList (name, description) VALUES (thename, thedescription) RETURNING id INTO theid;
	    END IF;

	    RETURN theid;
    END;
    $$
LANGUAGE plpgsql;

--DROP FUNCTION upsert_description(thename text, thedescription text)