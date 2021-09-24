# SETTING UP DATABASE AND TABLES

-- DROP database vaccines;

CREATE DATABASE vaccines;

USE vaccines;

-- DROP TABLE hospitals;
CREATE TABLE hospitals (
	hospital_id VARCHAR(3),
    hospital_name VARCHAR(70),
    hospital_postcode VARCHAR(8),
    postcodes_served VARCHAR(100),
    hospital_phone CHAR(11),
    PRIMARY KEY (hospital_id)
);

INSERT INTO hospitals (hospital_id, hospital_name, hospital_postcode, postcodes_served, hospital_phone) 
VALUES
('1', 'Manchester Royal Infirmary', 'M13 9WL', 'M1, M2, M13, M14, M15', '01612761234'),
('2', 'North Manchester General Hospital', 'M8 5RB', 'M3, M4, M7, M8', '01616240420'),
('3', 'Salford Royal', 'M6 8HD', 'M5, M6, M17, M50', '01617897373');

SELECT * FROM hospitals;

CREATE TABLE vaccine_info (
vaccine_id VARCHAR(3),
vaccine_name VARCHAR(50),
developer VARCHAR(50),
storage_temp_min INT,
storage_temp_max INT,
known_side_effects VARCHAR(50),
PRIMARY KEY (vaccine_id)
);

INSERT INTO vaccine_info(vaccine_id, vaccine_name, developer, storage_temp_min, storage_temp_max, known_side_effects)
VALUE 
('1', 'Pfizer', 'Pfizer/BioNTech', 2, 8, 'Headache, Nausea, Tiredness'),
('2', 'AstraZeneca', 'Oxford/AstraZeneca', -80, -60, 'Swelling, Blood clots, Nausea'),
('3', 'Moderna', 'Moderna', -25, -15, 'Swelling, Headache, Nausea');

SELECT * FROM vaccine_info;

CREATE TABLE patient_details (
	nhs_number CHAR(17) PRIMARY KEY,
    patient_first_name VARCHAR(50),
    patient_surname VARCHAR(50),
    patient_phone_number CHAR(11),
    patient_email VARCHAR(50),
    patient_dob DATE,
    patient_postcode VARCHAR(7), -- does this need to be a FK?
    patient_occupation VARCHAR(50)
    );

INSERT INTO patient_details
(nhs_number, patient_first_name, patient_surname, patient_phone_number, patient_email, patient_dob, patient_postcode, patient_occupation)
	VALUES
    ('25002962392934076', 'Vanessa', 'Pearce', '07965842733', 'vpearce@gmail.com', '1994-10-30', 'M2 4UF', 'Teacher'),
    ('33780814274735783', 'Donald', 'Chamberlin', '07847729099', 'dchamberlin@hotmail.co.uk', '1948-11-19', 'M3 5TH', 'Data Scientist'),
    ('66288146099022285', 'Mary', 'Harford', '07887810787', 'mary_harford@yahoo.co.uk', '1956-03-31', 'M50 0YA', 'Nurse'),
    ('74420214171391975', 'Raymond', 'Boyce', '07916754076', 'rayboyce@hotmail.co.uk', '1970-07-18', 'M14 4HU', 'Database Administrator'),
    ('95367335971538507', 'April', 'George', '07704191997', 'ageorge@gmail.com', '1986-01-04', 'M4 4DS', 'Doctor'),
    ('21127054941669468', 'Ivans', 'Jansen', '07934599370', 'ivansjansen@outlook.co.uk', '1991-12-05', 'M15 2LG', 'Social Worker'),
    ('10813724027569248', 'Marcia', 'Butler', '07885577305', 'marcia_butler@yahoo.co.uk', '1994-02-03', 'M17 9UT', 'Personal Trainer'),
    ('16300036837260174', 'Samanta', 'Luca', '07066825332', 'samantaluca@gmail.com', '1995-04-16', 'M8 8SH', 'Actor'),
    ('69801380867255967', 'Bridget', 'Beitel', '07975888835', 'bridget.beitel@aol.com', '1995-10-09', 'M6 4UY', 'Housekeeper'),
    ('05103592234591450', 'Pascal', 'Simone', '07060991001', 'pascal.simone@yahoo.com', '1997-01-14', 'M15 8FL', 'Student');

  SELECT * FROM patient_details;

  CREATE TABLE vaccine_batches (
	batch_id VARCHAR (3),
    vaccine_id VARCHAR(3),
    expiry_date DATE,
    doses INT,
    PRIMARY KEY
		(batch_id),
	FOREIGN KEY
		(vaccine_id)
        REFERENCES vaccine_info(vaccine_id)
	);

INSERT INTO vaccine_batches 
	(batch_id, vaccine_id, expiry_date, doses)
VALUES 
	('714','1','2022-02-12', 20),
    ('715','1','2022-04-21',73),
    ('716','3','2022-07-18',119),
    ('717','2','2022-07-28',12),
    ('718','2','2021-09-02',68);
    
SELECT * FROM vaccine_batches;

-- DROP TABLE vaccine_distribution;
CREATE TABLE vaccine_distribution (
	hospital_id VARCHAR(3),
    batch_id VARCHAR(3),
    stock INT,
    FOREIGN KEY (hospital_id)
		REFERENCES hospitals(hospital_id),
	FOREIGN KEY (batch_id)
		REFERENCES vaccine_batches(batch_id)
    );

INSERT INTO vaccine_distribution
	(hospital_id, batch_id, stock)
VALUES 	
	('1','715',54),
    ('2','718',68),
    ('2','714',20),
    ('3','715',19);

SELECT * FROM vaccine_distribution;

-- DROP TABLE reported_side_effects;
CREATE TABLE reported_side_effects (
	nhs_number CHAR(17),
    batch_id VARCHAR(3),
    reported_side_effect VARCHAR(50),
    FOREIGN KEY (nhs_number)
		REFERENCES patient_details(nhs_number),
	FOREIGN KEY (batch_id)
		REFERENCES vaccine_batches(batch_id)
    );

INSERT INTO reported_side_effects 
	(nhs_number, batch_id, reported_side_effect)
VALUES 
	('33780814274735783', '718', 'vomiting'),
    ('66288146099022285', '715', 'headache'),
    ('16300036837260174', '718', 'vomiting'),
    ('25002962392934076', '715', 'nausea');

SELECT * FROM reported_side_effects;

-- DROP TABLE hospital_staff;
CREATE TABLE hospital_staff(
	staff_id CHAR(5),
    hospital_id VARCHAR(3),
    staff_first_name VARCHAR(50),
    staff_surname VARCHAR(50),
    staff_dob DATE,
    staff_email VARCHAR(50),
    staff_role VARCHAR(50),
    PRIMARY KEY (staff_id),
    FOREIGN KEY (hospital_id)
		REFERENCES hospitals(hospital_id)
);

INSERT INTO hospital_staff (staff_id, hospital_id, staff_first_name, staff_surname, staff_dob, staff_email, staff_role)
VALUES
('11989', '1', 'Mary', 'Harford', '1956-03-31', 'mary_harford@yahoo.co.uk', 'Nurse'),
('13933', '2', 'April', 'George', '1986-01-04', 'ageorge@gmail.com', 'Doctor'),
('03131', '3', 'Auguste', 'Gosse', '1971-10-03', 'a.gosse@aol.com', 'Consultant'),
('20149', '3', 'Antonio', 'Papoutsis', '1993-05-22', 'antoniopapou@outlook.co.uk', 'Nurse');

SELECT * FROM hospital_staff;

CREATE TABLE patient_vaccine_history (
	nhs_number CHAR(17),
    dose CHAR(1),
    appointment_date DATE,
    done BOOLEAN, -- Zero is considered as false, nonzero values are considered as true
    hospital_id VARCHAR(3),
    batch_id VARCHAR(3),
    staff_id CHAR(5),
    FOREIGN KEY (nhs_number)
		REFERENCES patient_details(nhs_number),
    FOREIGN KEY (staff_id)
		REFERENCES hospital_staff(staff_id),
	FOREIGN KEY (batch_id)
		REFERENCES vaccine_batches(batch_id),
	FOREIGN KEY (hospital_id)
		REFERENCES hospitals(hospital_id)
);

INSERT INTO patient_vaccine_history (nhs_number, dose, appointment_date, done, hospital_id, batch_id, staff_id)
VALUES
('33780814274735783', '1', '2021-07-12', 1, '2', '718', '13933'),
('16300036837260174', '1', '2021-07-16', 1, '2', '718', '13933'),
('33780814274735783', '2', '2021-10-04', 0, '2', null, null),
('16300036837260174', '2', '2021-10-08', 0, '2', null, null),
('66288146099022285', '1', '2020-03-12', 1, '3', '715', '20149'),
('66288146099022285', '2', '2020-04-02', 1, '3', '715', '20149'),
('25002962392934076', '1', '2021-03-11', 1, '1', '715', '11989'),
('25002962392934076', '2', '2021-04-01', 0, '1', null, null);

SELECT * FROM patient_vaccine_history;

################# ANY KIND OF JOIN - Use any type of join to create a view that combines multiple tables in a logical way

SELECT
pd.patient_first_name, pd.patient_surname, -- <alias1>.<column_name>,
rse.reported_side_effect -- <alias2>.<column_name>
FROM patient_details pd -- FROM <table_name1> <alias1>
INNER JOIN 
reported_side_effects rse -- <table_name2> <alias2>
ON
pd.nhs_number = -- <alias1>.<column_name> = 
rse.nhs_number; -- <alias2>.<column_name>;

#View

CREATE VIEW done_detail AS (
	SELECT pd.nhs_number, pd.patient_first_name, pd.patient_surname, pd.patient_dob, pvh.appointment_date, pvh.dose, pvh.batch_id, vi.vaccine_name, hs.staff_first_name, hs.staff_surname
    FROM patient_details pd
    INNER JOIN patient_vaccine_history pvh ON pd.nhs_number=pvh.nhs_number
    INNER JOIN vaccine_batches vb ON pvh.batch_id=vb.batch_id
    INNER JOIN vaccine_info vi ON vb.vaccine_id=vi.vaccine_id
    INNER JOIN hospital_staff hs ON pvh.staff_id=hs.staff_id
    ORDER BY appointment_date ASC
);

SELECT * FROM done_detail;

# Stored Function

DELIMITER //
CREATE FUNCTION fee(
	vaccine_name VARCHAR(50)
    )
RETURNS FLOAT 
DETERMINISTIC
BEGIN
	DECLARE cost FLOAT;
	IF vaccine_name='Pfizer' THEN
		SET cost = 30;
	ELSEIF vaccine_name='AstraZeneca' THEN
		SET cost= 25;
	ELSEIF vaccine_name='Moderna' THEN
		SET cost= 27;
	END IF;
    RETURN (cost);
END//
DELIMITER ;

SELECT
	nhs_number, patient_first_name, patient_surname, appointment_date, dose, vaccine_name, fee(vaccine_name)
FROM
done_detail;

# Subquery

SELECT hospital_phone
FROM hospitals
WHERE hospital_id =
	(SELECT hospital_id
	FROM vaccine_distribution 
    WHERE batch_id = 718);

SELECT * FROM vaccine_distribution

# STORED PROCEDURE

-- Change Delimiter
DELIMITER //
-- Create Stored Procedure
CREATE PROCEDURE new_patient(
IN nhs_number char(17), 
IN patient_first_name VARCHAR(50),
IN patient_surname VARCHAR(50),
IN patient_phone_number char(11),
IN patient_email varchar(50),
IN patient_dob date,
IN patient_postcode varchar(7),
IN patient_occupation varchar(50))
BEGIN

INSERT INTO patient_details(nhs_number, patient_first_name, patient_surname, patient_phone_number, patient_email, patient_dob, patient_postcode, patient_occupation)
VALUES (nhs_number, patient_first_name, patient_surname, patient_phone_number, patient_email, patient_dob, patient_postcode, patient_occupation);

END//
-- Change Delimiter again
DELIMITER ;

-- CALL new_patient ('12345678912345678', 'The', 'Queen', '01202467893', 'thequeen@manchester.ac.uk', '1923-10-12', 'm14 5jz', 'Monarch');

SELECT * FROM patient_details;


# Trigger

DELIMITER //
CREATE TRIGGER patient_postcode_Before_Insert
BEFORE INSERT on patient_details
FOR EACH ROW
BEGIN
	SET NEW.patient_postcode=CONCAT(
    UPPER(SUBSTRING(NEW.patient_postcode, 1))
    );
END //
DELIMITER ;

-- Test:

-- INSERT INTO patient_details(nhs_number, patient_postcode)
-- VALUES (10813724027599248, 'm4 9iG');
-- SELECT * FROM patient_details;

-- DELETE FROM patient_details
-- WHERE nhs_number = '10813724027599248';

# Event

SET GLOBAL event_scheduler = ON; # turning on event scheduler

-- DROP TABLE vaccinated_tally;

CREATE TABLE vaccinated_tally # creating a table for the event to input the data into
(ID INT NOT NULL AUTO_INCREMENT,
last_update TIMESTAMP NOT NULL,
first_dose_tally INT NOT NULL,
second_dose_tally INT NOT NULL,
PRIMARY KEY (ID));

SELECT * FROM vaccinated_tally;

-- DROP EVENT daily_tally;

DELIMITER //

CREATE EVENT IF NOT EXISTS daily_tally
ON SCHEDULE
	EVERY 1 DAY
    STARTS (TIMESTAMP("2021-09-07",  "17:00:00")) #this event should occur every day at 5 pm
    ENDS (TIMESTAMP("2021-09-08", "17:00:01"))
DO BEGIN
	INSERT INTO vaccinated_tally(last_update, first_dose_tally, second_dose_tally) #insert values into table
	VALUES 
		(NOW(), # timestamp
		(SELECT COUNT(pvh.nhs_number) #count the number of entries that have had one dose
			FROM patient_vaccine_history pvh
			WHERE pvh.dose = 1
				AND pvh.done = 1),
		(SELECT COUNT(pvh.nhs_number) #count the number of patients that have had a second dose
			FROM patient_vaccine_history pvh
            WHERE pvh.dose = 2
				AND pvh.done = 1)
	 		);
END//

DELIMITER ;

#Sample query with group by, where stock is over 50

SELECT 
SUM(v.stock) AS stock,
v.hospital_id
FROM vaccine_distribution v
GROUP BY v.hospital_id
HAVING stock > 50;