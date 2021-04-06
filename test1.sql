-- -------------------------------------------------------------------- TRIGGERS -------------------------------------------------------------------------

-- TRGIGGER is a block of sql defined to do a certain action 
-- TO do something if an entry is added or deleted

-- creating a table to set trigger

CREATE TABLE trigger_set(
    message VARCHAR(100)
);

-- seting up a trigger for trigger_Set table

DELIMITER $$

CREATE TRIGGER my_trigger BEFORE INSERT ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_set VALUES("new employee added");
    END $$

DELIMITER ; 

INSERT INTO employee VALUES(109,'Oscar','Martiinez','1969-02-19','M',69000,106,3);

SELECT * FROM trigger_set;


-- TRIGGER 2

DELIMITER $$

CREATE TRIGGER my_trigger2 BEFORE INSERT ON employee 
    FOR EACH ROW BEGIN
        INSERT INTO trigger_set VALUES(NEW.first_name);
    END $$

DELIMITER ;

INSERT INTO employee VALUES(110,'kevin','malve','1978-02-19','M',69000,106,3);

SELECT * FROM trigger_set;
