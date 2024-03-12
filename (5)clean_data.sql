--Cleaning data/ data scraping
-- Email filters 

--finds the non unique emails that already exist and emails that violate the code above
SELECT email, COUNT(*)
FROM user_test
GROUP BY email
HAVING COUNT(*) > 1;


DELETE from user_test
--Selects FROM the emails we have and checks to see 
--if the start has proper values then checks after the @ symbol
--!~* operator is used for case-insensitive negation of a regular expression match
WHERE email !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';

-- Temporarily remove the unique constraint if necessary
-- ALTER TABLE test DROP CONSTRAINT IF EXISTS unique_usr_email;
WITH RankedEmails AS (
  SELECT usr_id, email,
         ROW_NUMBER() OVER(PARTITION BY email ORDER BY usr_id) AS rn
  FROM user_test
)
DELETE FROM user_test
WHERE usr_id IN (SELECT usr_id FROM RankedEmails WHERE rn > 1);


--ads a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE user_test ADD CONSTRAINT unique_usr_email UNIQUE (email);


---State/city name fixers

--State fixer
SELECT INITCAP(state_address) AS ProperState_address
FROM user_test;
UPDATE user_test
SET state_address = INITCAP(state_address);
ALTER TABLE user_test ADD CONSTRAINT unique_state UNIQUE (state_address);
SELECT state_address, COUNT(*)
FROM user_test
GROUP BY state_address
HAVING COUNT(*) > 1;
--City fixer
SELECT INITCAP(city_address) AS ProperCity_address
FROM user_test;
UPDATE user_test
SET city_address = INITCAP(city_address);
ALTER TABLE user_test ADD CONSTRAINT unique_city UNIQUE (city_address);
SELECT city_address, COUNT(*)
FROM user_test
GROUP BY city_address
HAVING COUNT(*) > 1;

--Name fixer
--checks to see if the name is already capitalized then uses the INITCAP function 
-- to change the first letter to a capitalized letter.
-- changes data FROM first_name to ProperFirstName and last_name to ProperLastName
SELECT  INITCAP(first_name) as ProperFirstName, 
        INITCAP(last_name) as ProperLastName
FROM user_test;