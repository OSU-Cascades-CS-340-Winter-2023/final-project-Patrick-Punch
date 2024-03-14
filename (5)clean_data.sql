--Cleaning data/ data scraping
-- Email filters 

--finds the non unique emails that already exist and emails that violate the code above
SELECT email, COUNT(*)
FROM user_test
GROUP BY email
HAVING COUNT(*) > 1;
go;
--Selects FROM the emails we have and checks to see 
--if the start has proper values then checks after the @ symbol
--!~* operator is used for case-insensitive negation of a regular expression match
DELETE from user_test
WHERE email !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
go;
-- Temporarily remove the unique constraint if necessary
-- ALTER TABLE test DROP CONSTRAINT IF EXISTS unique_usr_email;
WITH RankedEmails AS
  (
    SELECT usr_id, email,
           ROW_NUMBER() OVER(PARTITION BY email ORDER BY usr_id) AS rn
    FROM user_test
  )
DELETE FROM user_test
WHERE usr_id IN (SELECT usr_id FROM RankedEmails WHERE rn > 1);
go;
--adds a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE user_test ADD CONSTRAINT unique_usr_email UNIQUE (email);


---State/city name fixers
Select INITCAP(state_address) as ProperState_address,
      INITCAP(city_address) as ProperCity_address
go;
from user_test;
set state_address = INITCAP(state_address),
    city_address =  INITCAP(city_address);
--Groups the states and cities to display the count of each one after corrections.
Select state_address, COUNT(*),
        city_address, COUNT(*)
from user_test
GROUP By state_address,
          city_address
HAVING COUNT(*) >1;
go;
--Name fixer
--checks to see if the name is already capitalized then uses the INITCAP function 
-- to change the first letter to a capitalized letter.
-- changes data FROM first_name to ProperFirstName and last_name to ProperLastName
SELECT  INITCAP(first_name) as ProperFirstName, 
        INITCAP(last_name) as ProperLastName
FROM user_test;
go;
Update user_test
set first_name = INITCAP(first_name),
    last_name = INITCAP(last_name);
