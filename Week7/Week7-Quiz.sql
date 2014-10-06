-- 
-- Author: Daniel Dittenhafer
--
-- Created: Oct 4, 2014
--
-- Description: Answers to Week 7 Quiz
--

-- 1. PostgreSQL sample database dvdrental was downloaded and restorted into 
--    my local server.

-- 2. How many films contain the word bride in their title?
--
-- Answer: While no films have the all lowercase word "bride" in their title,
--         2 films have the mixed-case word "Bride" in their title:
--
--           1) Bride Intrigue
--           2) Saints Bride
--
SELECT title FROM film WHERE title LIKE '%Bride%'

-- 3. Give one example of functionality that exists in PostgreSQL 
--    that is a superset of ANSI SQL's functionality. What are the 
--    advantages of using or not using this functionality in a 
--    database application?
-- 
-- Answer: In the ORDER BY clause, ANSI SQL will only allow columns
--         that appear in the select list. PostgreSQL allows not just
--         the ANSE SQL standard of select list columns in the ORDER BY
--         clause, but also any other column from the tables being queried.
--	   By using this functionality, you might gain flexibility in the query
--         but potentially at the expense of getting locked into RDBMS systems
--         which support this enhanced behavior.

-- 4. Suppose someone wants to delete a customer that owes money. Describe
--   (using the names of the appropriate tables in the sample database described
--   in the tutorial) how the database should respond to a DELETE statement.
-- 
-- Answer: The rental and payment tables are dependent on customer via 
--         foreign key constraints. I don't see where an owed payment
--         is tracked, but if it were, a DELETE should be prevented
--         and could be prevented by a TRIGGER on the customer table.  
--         If the DELETE must occur then the application or a TRIGGER 
--         could clean up dependent tables (rental & payment) before 
--         allowing the DELETE to remove the row from the customer table.
/*
SELECT * FROM customer c
	LEFT JOIN payment p ON p.customer_id = c.customer_id
	LEFT JOIN rental r ON r.customer_id = c.customer_id

SELECT * FROM payment WHERE payment_date IS NULL
*/
