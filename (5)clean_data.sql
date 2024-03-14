--Cleaning data/ data scraping
-- Email filters 

--finds the non unique emails that already exist and emails that violate the code above
SELECT email, COUNT(*)
FROM user_test
GROUP BY email
HAVING COUNT(*) > 1;
--Selects FROM the emails we have and checks to see 
--if the start has proper values then checks after the @ symbol
--!~* operator is used for case-insensitive negation of a regular expression match
DELETE from user_test
WHERE email !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
-- Temporarily remove the unique constraint if necessary
-- ALTER TABLE test DROP CONSTRAINT IF EXISTS unique_usr_email;
--unique email setter
WITH RankedEmails AS
  (
    --finds the duplicate emails and sets them to a value of rn
    SELECT usr_id, email,
           ROW_NUMBER() OVER(PARTITION BY email ORDER BY usr_id) AS rn
    FROM user_test
  )
--removes the bad emails and then removes them if the value rn is > 1
DELETE FROM user_test
WHERE usr_id IN (SELECT usr_id FROM RankedEmails WHERE rn > 1);
--adds a CONSTRAINT to the emails where all emails must be UNIQUE
ALTER TABLE user_test ADD CONSTRAINT unique_usr_email UNIQUE (email);
go;
---State/city name fixers
-- selects the states and then makes the first letter always capital
Select INITCAP(state_address) as ProperState_address,
      INITCAP(city_address) as ProperCity_address
from user_test;
--updates the values to make it not have missing capitalized letters
update user_test
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
--Changes the names to be gramatically correct
Update user_test
set first_name = INITCAP(first_name),
    last_name = INITCAP(last_name);
go;
/* Finds products with no id and removes it
later update: make it skim all missing data values to then remove any row that
has missing data.
*/
Select product_id
from products_test
where product_id = ' 'OR product_id IS NULL;
--removes the unwanted data
DELETE from products_test
where product_id = ' 'OR product_id IS NULL;
go;
--finds any services without an id
select services_id
from services_test
where services_id = ' ' or services_id is null;
--removes unwanted data 
delete from services_test
where services_id = ' ' or services_id is null;
go;
--displays the services without a brand name, but what they do and the catagory of it.
select services_id, services_name, services_brand, services_category
from services_test
where services_brand = ' ' or services_brand is null;
