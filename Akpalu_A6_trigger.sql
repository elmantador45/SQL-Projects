USE ischool;

## Run the code below before working on the trigger

DROP TABLE IF EXISTS enrollment_records; 

CREATE TABLE enrollment_records AS
SELECT *
FROM student_enrollment_details;
ALTER TABLE enrollment_records ADD PRIMARY KEY (Name);

DROP TABLE IF EXISTS new_student_enrollment_records; 

CREATE TABLE new_student_enrollment_records(  
	new_student_Name varchar(45) NOT NULL, 
	new_student_enrollment_record_text varchar(300) DEFAULT NULL, 
	new_student_enrollment_record_timestamp datetime DEFAULT NULL, PRIMARY 
		KEY (new_student_Name)) 
ENGINE=InnoDB;
# ----------------------
# The process for creating the trigger begins here
DROP TRIGGER IF EXISTS student_enrollment_tracker;

DELIMITER //

CREATE TRIGGER student_enrollment_tracker
AFTER INSERT ON enrollment_records
	FOR EACH ROW

BEGIN
	DECLARE student_name VARCHAR(45);
    DECLARE courses_enrolled BIGINT;
    DECLARE credits_taken DECIMAL(32,0);
    DECLARE courses_with_prerequisites BIGINT;
    DECLARE term VARCHAR(15);
    
	SET student_name = NEW.student_name;
    SET courses_enrolled = NEW.courses_enrolled;
    SET credits_taken = NEW.credits_taken;
    SET courses_with_prerequisites = NEW.courses_with_prerequisites;
    SET term = NEW.term;
    
	INSERT INTO new_enrollment_records VALUES(
		student_name,
		CONCAT('You have added a new student ', student_name, 'who has registered for ', courses_enrolled,
			'this', term, ' and will be taking ', credits_taken, ' credits.'),
		NOW()
    );
END//

DELIMITER ;

## Test your code:
# Run this INSERT query:
INSERT INTO enrollment_records VALUES ('Alex Smith', 'Fall 2022', 4, 12, 1);

## Then run this SELECT query:
SELECT * FROM new_student_enrollment_records;

## Do your see a row with the following values?
# 'Alex Smith', 'You have added a new student, Alex Smith, who registered for 4 courses this Fall 2022 and will be taking 12 credits.', '2023-04-12 03:21:13'
# NOTE: The date and time in your 3rd column will be different.