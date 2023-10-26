-- Question 2
USE ischool;

DROP FUNCTION IF EXISTS get_person_address;

DELIMITER //

CREATE FUNCTION get_person_address (
    fname VARCHAR(50),
    lname VARCHAR(50)
)
RETURNS VARCHAR(100) 
DETERMINISTIC READS SQL DATA
BEGIN 
    DECLARE addresses VARCHAR(100);

    SELECT CONCAT(
        IFNULL(a.street,'[Not Available]'), ', ',
        IFNULL(a.city,'[Not Available]'), ', ',
        IFNULL(a.state,'[Not Available]'), ', ',
        IFNULL(a.zipcode,'[Not Available]'), ', ',
        IFNULL(a.country,'[Not Available]')
    ) INTO addresses
    FROM people p
    LEFT JOIN person_addresses pa ON p.person_id = pa.person_id
    LEFT JOIN addresses a ON pa.address_id = a.address_id
    WHERE p.fname = fname AND p.lname = lname;

    RETURN addresses;
    
END //
DELIMITER ;

# Test your code:

SELECT get_person_address('Kamala','Khan');
SELECT get_person_address('Jessica','Jones');
