-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`DEPARTMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DEPARTMENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DEPARTMENT` (
  `Dept_Code` VARCHAR(10) NOT NULL,
  `Dept_Name` VARCHAR(45) NOT NULL,
  `Head_of_Dept` VARCHAR(45) NOT NULL,
  `Employee_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Dept_Code`),
  UNIQUE INDEX `Dept_Code_UNIQUE` (`Dept_Code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SCHEDULE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SCHEDULE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SCHEDULE` (
  `Date` DATE NOT NULL,
  `Shift` VARCHAR(45) NOT NULL,
  `Start_Time` VARCHAR(15) NOT NULL,
  `End_Time` VARCHAR(15) NOT NULL,
  `DEPARTMENT_Dept_Code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Date`, `DEPARTMENT_Dept_Code`),
  INDEX `fk_SCHEDULE_DEPARTMENT1_idx` (`DEPARTMENT_Dept_Code` ASC) VISIBLE,
  CONSTRAINT `fk_SCHEDULE_DEPARTMENT1`
    FOREIGN KEY (`DEPARTMENT_Dept_Code`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dept_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLOYEE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EMPLOYEE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EMPLOYEE` (
  `Employee_ID` INT NOT NULL,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `MI` VARCHAR(45) NULL,
  `DOB` VARCHAR(45) NOT NULL,
  `Phone_Num` INT(10) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(150) NOT NULL,
  `SSN` INT(9) NOT NULL,
  `Salary` INT(6) NOT NULL,
  `DEPARTMENT_Dept_Code` VARCHAR(10) NOT NULL,
  `SCHEDULE_Date` DATE NOT NULL,
  PRIMARY KEY (`Employee_ID`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`),
  UNIQUE INDEX `Employee_ID_UNIQUE` (`Employee_ID` ASC) VISIBLE,
  INDEX `fk_EMPLOYEE_DEPARTMENT1_idx` (`DEPARTMENT_Dept_Code` ASC) VISIBLE,
  INDEX `fk_EMPLOYEE_SCHEDULE1_idx` (`SCHEDULE_Date` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLOYEE_DEPARTMENT1`
    FOREIGN KEY (`DEPARTMENT_Dept_Code`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dept_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EMPLOYEE_SCHEDULE1`
    FOREIGN KEY (`SCHEDULE_Date`)
    REFERENCES `mydb`.`SCHEDULE` (`Date`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DOCTOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DOCTOR` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DOCTOR` (
  `EMPLOYEE_Employee_ID` INT NOT NULL,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `MI` VARCHAR(45) NULL,
  `Speciality` VARCHAR(45) NOT NULL,
  `YearsOfExperience` INT(3) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_Employee_ID`),
  CONSTRAINT `fk_DOCTOR_EMPLOYEE1`
    FOREIGN KEY (`EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`EMPLOYEE` (`Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PATIENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PATIENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PATIENT` (
  `Patient_ID` INT NOT NULL,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `MI` VARCHAR(45) NULL,
  `Patient_Type` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(1) NOT NULL,
  `DOB` VARCHAR(45) NOT NULL,
  `Phone_Num` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(150) NOT NULL,
  `SNN` INT(9) NOT NULL,
  `Insurance` VARCHAR(100) NOT NULL,
  `Insurance Company` VARCHAR(45) NOT NULL,
  `Payment` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Patient_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NURSE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NURSE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`NURSE` (
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `MI` VARCHAR(45) NULL,
  `Postion` VARCHAR(45) NOT NULL,
  `Registered` VARCHAR(3) NULL,
  `EMPLOYEE_Employee_ID` INT NOT NULL,
  PRIMARY KEY (`EMPLOYEE_Employee_ID`),
  CONSTRAINT `fk_NURSE_EMPLOYEE1`
    FOREIGN KEY (`EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`EMPLOYEE` (`Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BLOCK`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BLOCK` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BLOCK` (
  `Block_Code` INT NOT NULL,
  `Block_Description` VARCHAR(45) NULL,
  `Block_Floor` VARCHAR(45) NULL,
  PRIMARY KEY (`Block_Code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ROOM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ROOM` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ROOM` (
  `Room_Number` INT NOT NULL,
  `Room_Type` VARCHAR(45) NOT NULL,
  `Availability` VARCHAR(45) NOT NULL,
  `BLOCK_Block_Code` INT NOT NULL,
  PRIMARY KEY (`Room_Number`, `BLOCK_Block_Code`),
  INDEX `fk_ROOM_BLOCK1_idx` (`BLOCK_Block_Code` ASC) VISIBLE,
  CONSTRAINT `fk_ROOM_BLOCK1`
    FOREIGN KEY (`BLOCK_Block_Code`)
    REFERENCES `mydb`.`BLOCK` (`Block_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`APPOINTMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`APPOINTMENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`APPOINTMENT` (
  `Appointment_ID` INT NOT NULL,
  `Start_time` VARCHAR(50) NOT NULL,
  `End_time` VARCHAR(50) NOT NULL,
  `ROOM_Room_Number` INT NOT NULL,
  `ROOM_BLOCK_Block_Code` INT NOT NULL,
  `DOCTOR_EMPLOYEE_Employee_ID` INT NOT NULL,
  `PATIENT_Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Appointment_ID`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`),
  INDEX `fk_APPOINTMENT_ROOM1_idx` (`ROOM_Room_Number` ASC, `ROOM_BLOCK_Block_Code` ASC) VISIBLE,
  INDEX `fk_APPOINTMENT_DOCTOR1_idx` (`DOCTOR_EMPLOYEE_Employee_ID` ASC) VISIBLE,
  INDEX `fk_APPOINTMENT_PATIENT1_idx` (`PATIENT_Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_APPOINTMENT_ROOM1`
    FOREIGN KEY (`ROOM_Room_Number` , `ROOM_BLOCK_Block_Code`)
    REFERENCES `mydb`.`ROOM` (`Room_Number` , `BLOCK_Block_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_APPOINTMENT_DOCTOR1`
    FOREIGN KEY (`DOCTOR_EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_APPOINTMENT_PATIENT1`
    FOREIGN KEY (`PATIENT_Patient_ID`)
    REFERENCES `mydb`.`PATIENT` (`Patient_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MEDICATION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MEDICATION` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MEDICATION` (
  `Medication_Code` INT NOT NULL,
  `Drug_Generic_Name` VARCHAR(45) NOT NULL,
  `Brand_Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`Medication_Code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MEDICAL_RECORD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MEDICAL_RECORD` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MEDICAL_RECORD` (
  `Medical_Record_ID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Condition` VARCHAR(150) NOT NULL,
  `PATIENT_Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Medical_Record_ID`),
  INDEX `fk_MEDICAL_RECORD_PATIENT1_idx` (`PATIENT_Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_MEDICAL_RECORD_PATIENT1`
    FOREIGN KEY (`PATIENT_Patient_ID`)
    REFERENCES `mydb`.`PATIENT` (`Patient_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PROCEDURE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PROCEDURE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PROCEDURE` (
  `Procedure_Code` INT NOT NULL,
  `Procedure_Name` VARCHAR(45) NOT NULL,
  `Procedure_Cost` INT NOT NULL,
  PRIMARY KEY (`Procedure_Code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TREATMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TREATMENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TREATMENT` (
  `Treatment_ID` INT NOT NULL,
  `Treatment_Time` DATETIME NOT NULL,
  `ROOM_Room_Number` INT NOT NULL,
  `ROOM_BLOCK_Block_Code` INT NOT NULL,
  `DOCTOR_EMPLOYEE_Employee_ID` INT NOT NULL,
  `PATIENT_Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Treatment_ID`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`),
  INDEX `fk_TREATMENT_ROOM1_idx` (`ROOM_Room_Number` ASC, `ROOM_BLOCK_Block_Code` ASC) VISIBLE,
  INDEX `fk_TREATMENT_DOCTOR1_idx` (`DOCTOR_EMPLOYEE_Employee_ID` ASC) VISIBLE,
  INDEX `fk_TREATMENT_PATIENT1_idx` (`PATIENT_Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_TREATMENT_ROOM1`
    FOREIGN KEY (`ROOM_Room_Number` , `ROOM_BLOCK_Block_Code`)
    REFERENCES `mydb`.`ROOM` (`Room_Number` , `BLOCK_Block_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TREATMENT_DOCTOR1`
    FOREIGN KEY (`DOCTOR_EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TREATMENT_PATIENT1`
    FOREIGN KEY (`PATIENT_Patient_ID`)
    REFERENCES `mydb`.`PATIENT` (`Patient_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TREATMENT_has_ROOM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TREATMENT_has_ROOM` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TREATMENT_has_ROOM` (
  `TREATMENT_Treatment_ID` INT NOT NULL,
  `TREATMENT_PATIENT_Patient_ID` INT NOT NULL,
  `TREATMENT_DOCTOR_Doctor_EmployeeID` INT NOT NULL,
  `ROOM_Room_Number` INT NOT NULL,
  `ROOM_BLOCK_Block_Code` INT NOT NULL,
  `ROOM_APPOINTMENT_Appointment_ID` INT NOT NULL,
  `ROOM_APPOINTMENT_PATIENT_Patient_ID` INT NOT NULL,
  `ROOM_APPOINTMENT_DOCTOR_Doctor_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`TREATMENT_Treatment_ID`, `TREATMENT_PATIENT_Patient_ID`, `TREATMENT_DOCTOR_Doctor_EmployeeID`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `ROOM_APPOINTMENT_Appointment_ID`, `ROOM_APPOINTMENT_PATIENT_Patient_ID`, `ROOM_APPOINTMENT_DOCTOR_Doctor_EmployeeID`),
  INDEX `fk_TREATMENT_has_ROOM_ROOM1_idx` (`ROOM_Room_Number` ASC, `ROOM_BLOCK_Block_Code` ASC, `ROOM_APPOINTMENT_Appointment_ID` ASC, `ROOM_APPOINTMENT_PATIENT_Patient_ID` ASC, `ROOM_APPOINTMENT_DOCTOR_Doctor_EmployeeID` ASC) VISIBLE,
  INDEX `fk_TREATMENT_has_ROOM_TREATMENT1_idx` (`TREATMENT_Treatment_ID` ASC, `TREATMENT_PATIENT_Patient_ID` ASC, `TREATMENT_DOCTOR_Doctor_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_TREATMENT_has_ROOM_TREATMENT1`
    FOREIGN KEY (`TREATMENT_Treatment_ID`)
    REFERENCES `mydb`.`TREATMENT` (`Treatment_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TREATMENT_has_ROOM_ROOM1`
    FOREIGN KEY (`ROOM_Room_Number`)
    REFERENCES `mydb`.`ROOM` (`Room_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prescriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Prescriptions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Prescriptions` (
  `Date` VARCHAR(45) NOT NULL,
  `DOCTOR_EMPLOYEE_Employee_ID` INT NOT NULL,
  `PATIENT_Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`),
  INDEX `fk_Prescriptions_DOCTOR1_idx` (`DOCTOR_EMPLOYEE_Employee_ID` ASC) VISIBLE,
  INDEX `fk_Prescriptions_PATIENT1_idx` (`PATIENT_Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Prescriptions_DOCTOR1`
    FOREIGN KEY (`DOCTOR_EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Prescriptions_PATIENT1`
    FOREIGN KEY (`PATIENT_Patient_ID`)
    REFERENCES `mydb`.`PATIENT` (`Patient_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AMBULANCE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AMBULANCE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AMBULANCE` (
  `Ambulance_ID` INT NOT NULL,
  `DEPARTMENT_Dept_Code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Ambulance_ID`, `DEPARTMENT_Dept_Code`),
  INDEX `fk_AMBULANCE_DEPARTMENT1_idx` (`DEPARTMENT_Dept_Code` ASC) VISIBLE,
  CONSTRAINT `fk_AMBULANCE_DEPARTMENT1`
    FOREIGN KEY (`DEPARTMENT_Dept_Code`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dept_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EQUIPMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EQUIPMENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EQUIPMENT` (
  `Equipment_ID` INT NOT NULL,
  `Equiment_Name` VARCHAR(45) NULL,
  `Equipment_description` VARCHAR(45) NULL,
  `ROOM_Room_Number` INT NOT NULL,
  `ROOM_BLOCK_Block_Code` INT NOT NULL,
  PRIMARY KEY (`Equipment_ID`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`),
  INDEX `fk_EQUIPMENT_ROOM1_idx` (`ROOM_Room_Number` ASC, `ROOM_BLOCK_Block_Code` ASC) VISIBLE,
  CONSTRAINT `fk_EQUIPMENT_ROOM1`
    FOREIGN KEY (`ROOM_Room_Number` , `ROOM_BLOCK_Block_Code`)
    REFERENCES `mydb`.`ROOM` (`Room_Number` , `BLOCK_Block_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BILL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BILL` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BILL` (
  `Bill_ID` INT NOT NULL,
  `Cost` VARCHAR(45) NULL,
  `PATIENT_Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Bill_ID`, `PATIENT_Patient_ID`),
  INDEX `fk_BILL_PATIENT1_idx` (`PATIENT_Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_BILL_PATIENT1`
    FOREIGN KEY (`PATIENT_Patient_ID`)
    REFERENCES `mydb`.`PATIENT` (`Patient_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DEPARTMENT_has_BLOCK`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DEPARTMENT_has_BLOCK` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DEPARTMENT_has_BLOCK` (
  `DEPARTMENT_Dept_Code` VARCHAR(10) NOT NULL,
  `BLOCK_Block_Code` INT NOT NULL,
  PRIMARY KEY (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`),
  INDEX `fk_DEPARTMENT_has_BLOCK_BLOCK1_idx` (`BLOCK_Block_Code` ASC) VISIBLE,
  INDEX `fk_DEPARTMENT_has_BLOCK_DEPARTMENT1_idx` (`DEPARTMENT_Dept_Code` ASC) VISIBLE,
  CONSTRAINT `fk_DEPARTMENT_has_BLOCK_DEPARTMENT1`
    FOREIGN KEY (`DEPARTMENT_Dept_Code`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dept_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DEPARTMENT_has_BLOCK_BLOCK1`
    FOREIGN KEY (`BLOCK_Block_Code`)
    REFERENCES `mydb`.`BLOCK` (`Block_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PROCEDURE_requires_EQUIPMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PROCEDURE_requires_EQUIPMENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PROCEDURE_requires_EQUIPMENT` (
  `PROCEDURE_Procedure_Code` INT NOT NULL,
  `EQUIPMENT_Equipment_ID` INT NOT NULL,
  `EQUIPMENT_ROOM_Room_Number` INT NOT NULL,
  `EQUIPMENT_ROOM_BLOCK_Block_Code` INT NOT NULL,
  PRIMARY KEY (`PROCEDURE_Procedure_Code`, `EQUIPMENT_Equipment_ID`, `EQUIPMENT_ROOM_Room_Number`, `EQUIPMENT_ROOM_BLOCK_Block_Code`),
  INDEX `fk_PROCEDURE_has_EQUIPMENT_EQUIPMENT1_idx` (`EQUIPMENT_Equipment_ID` ASC, `EQUIPMENT_ROOM_Room_Number` ASC, `EQUIPMENT_ROOM_BLOCK_Block_Code` ASC) VISIBLE,
  INDEX `fk_PROCEDURE_has_EQUIPMENT_PROCEDURE1_idx` (`PROCEDURE_Procedure_Code` ASC) VISIBLE,
  CONSTRAINT `fk_PROCEDURE_has_EQUIPMENT_PROCEDURE1`
    FOREIGN KEY (`PROCEDURE_Procedure_Code`)
    REFERENCES `mydb`.`PROCEDURE` (`Procedure_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PROCEDURE_has_EQUIPMENT_EQUIPMENT1`
    FOREIGN KEY (`EQUIPMENT_Equipment_ID` , `EQUIPMENT_ROOM_Room_Number` , `EQUIPMENT_ROOM_BLOCK_Block_Code`)
    REFERENCES `mydb`.`EQUIPMENT` (`Equipment_ID` , `ROOM_Room_Number` , `ROOM_BLOCK_Block_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TREATMENT_contains_PROCEDURE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TREATMENT_contains_PROCEDURE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TREATMENT_contains_PROCEDURE` (
  `TREATMENT_Treatment_ID` INT NOT NULL,
  `PROCEDURE_Procedure_Code` INT NOT NULL,
  PRIMARY KEY (`TREATMENT_Treatment_ID`, `PROCEDURE_Procedure_Code`),
  INDEX `fk_TREATMENT_has_PROCEDURE_PROCEDURE1_idx` (`PROCEDURE_Procedure_Code` ASC) VISIBLE,
  INDEX `fk_TREATMENT_has_PROCEDURE_TREATMENT1_idx` (`TREATMENT_Treatment_ID` ASC) VISIBLE,
  CONSTRAINT `fk_TREATMENT_has_PROCEDURE_TREATMENT1`
    FOREIGN KEY (`TREATMENT_Treatment_ID`)
    REFERENCES `mydb`.`TREATMENT` (`Treatment_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TREATMENT_has_PROCEDURE_PROCEDURE1`
    FOREIGN KEY (`PROCEDURE_Procedure_Code`)
    REFERENCES `mydb`.`PROCEDURE` (`Procedure_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`APPOINTMENT_is_followed_by_TREATMENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`APPOINTMENT_is_followed_by_TREATMENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`APPOINTMENT_is_followed_by_TREATMENT` (
  `APPOINTMENT_Appointment_ID` INT NOT NULL,
  `TREATMENT_Treatment_ID` INT NOT NULL,
  `TREATMENT_ROOM_Room_Number` INT NOT NULL,
  `TREATMENT_ROOM_BLOCK_Block_Code` INT NOT NULL,
  `TREATMENT_DOCTOR_EMPLOYEE_Employee_ID` INT NOT NULL,
  `TREATMENT_PATIENT_Patient_ID` INT NOT NULL,
  PRIMARY KEY (`APPOINTMENT_Appointment_ID`, `TREATMENT_Treatment_ID`, `TREATMENT_ROOM_Room_Number`, `TREATMENT_ROOM_BLOCK_Block_Code`, `TREATMENT_DOCTOR_EMPLOYEE_Employee_ID`, `TREATMENT_PATIENT_Patient_ID`),
  INDEX `fk_APPOINTMENT_has_TREATMENT_TREATMENT1_idx` (`TREATMENT_Treatment_ID` ASC, `TREATMENT_ROOM_Room_Number` ASC, `TREATMENT_ROOM_BLOCK_Block_Code` ASC, `TREATMENT_DOCTOR_EMPLOYEE_Employee_ID` ASC, `TREATMENT_PATIENT_Patient_ID` ASC) VISIBLE,
  INDEX `fk_APPOINTMENT_has_TREATMENT_APPOINTMENT1_idx` (`APPOINTMENT_Appointment_ID` ASC) VISIBLE,
  CONSTRAINT `fk_APPOINTMENT_has_TREATMENT_APPOINTMENT1`
    FOREIGN KEY (`APPOINTMENT_Appointment_ID`)
    REFERENCES `mydb`.`APPOINTMENT` (`Appointment_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_APPOINTMENT_has_TREATMENT_TREATMENT1`
    FOREIGN KEY (`TREATMENT_Treatment_ID` , `TREATMENT_ROOM_Room_Number` , `TREATMENT_ROOM_BLOCK_Block_Code` , `TREATMENT_DOCTOR_EMPLOYEE_Employee_ID` , `TREATMENT_PATIENT_Patient_ID`)
    REFERENCES `mydb`.`TREATMENT` (`Treatment_ID` , `ROOM_Room_Number` , `ROOM_BLOCK_Block_Code` , `DOCTOR_EMPLOYEE_Employee_ID` , `PATIENT_Patient_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DOCTOR_updates_MEDICAL_RECORD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DOCTOR_updates_MEDICAL_RECORD` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DOCTOR_updates_MEDICAL_RECORD` (
  `DOCTOR_EMPLOYEE_Employee_ID` INT NOT NULL,
  `MEDICAL_RECORD_Medical_Record_ID` INT NOT NULL,
  PRIMARY KEY (`DOCTOR_EMPLOYEE_Employee_ID`, `MEDICAL_RECORD_Medical_Record_ID`),
  INDEX `fk_DOCTOR_has_MEDICAL_RECORD_MEDICAL_RECORD1_idx` (`MEDICAL_RECORD_Medical_Record_ID` ASC) VISIBLE,
  INDEX `fk_DOCTOR_has_MEDICAL_RECORD_DOCTOR1_idx` (`DOCTOR_EMPLOYEE_Employee_ID` ASC) VISIBLE,
  CONSTRAINT `fk_DOCTOR_has_MEDICAL_RECORD_DOCTOR1`
    FOREIGN KEY (`DOCTOR_EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DOCTOR_has_MEDICAL_RECORD_MEDICAL_RECORD1`
    FOREIGN KEY (`MEDICAL_RECORD_Medical_Record_ID`)
    REFERENCES `mydb`.`MEDICAL_RECORD` (`Medical_Record_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prescriptions_has_MEDICATION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Prescriptions_has_MEDICATION` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Prescriptions_has_MEDICATION` (
  `Prescriptions_Date` VARCHAR(45) NOT NULL,
  `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID` INT NOT NULL,
  `MEDICATION_Medication_Code` INT NOT NULL,
  PRIMARY KEY (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`),
  INDEX `fk_Prescriptions_has_MEDICATION_MEDICATION1_idx` (`MEDICATION_Medication_Code` ASC) VISIBLE,
  INDEX `fk_Prescriptions_has_MEDICATION_Prescriptions1_idx` (`Prescriptions_Date` ASC, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Prescriptions_has_MEDICATION_Prescriptions1`
    FOREIGN KEY (`Prescriptions_Date` , `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`)
    REFERENCES `mydb`.`Prescriptions` (`Date` , `DOCTOR_EMPLOYEE_Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Prescriptions_has_MEDICATION_MEDICATION1`
    FOREIGN KEY (`MEDICATION_Medication_Code`)
    REFERENCES `mydb`.`MEDICATION` (`Medication_Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `mydb`.`DEPARTMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('A&E', 'Accident and emergency', 'S. Strange', '1235');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('CARDIO', 'Cardiology', 'B. Banner', '1234');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('DEN', 'Dental', 'L. McCoy', '1237');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('DERMA', 'Dermatology', 'H. Quinn', '1248');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('ENT', 'Ear, Nose, and Throat', 'J. Dorian', '1280');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('FIN', 'Finance Department', 'S. Paredes', '1285');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('HR', 'Human Resources', 'C. Poptile', '1283');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('ICU', 'Intensive/Critical Care', 'F. Frankenstein', '1252');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('INFECD', 'Infectious disease', 'G. House', '1242');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('ITM', 'Information Technology Management', 'S. Wiatr', '1284');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('LAB', 'Laboratory', 'J. Bilkey', '1282');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('MED', 'Medicine', 'S.Murphy', '1238');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('NEURO', 'Neurology', 'D. Howser', '1240');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('NUCMED', 'Nuclear medicine', 'V.Doom', '1256');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('OBGYN', 'Obstetrics/Gynaecology', 'M.Grey', '1246');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('ONCO', 'Oncology', 'J. Georg', '1253');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('OPH', 'Ophthalmology', 'C. McNider', '1254');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('ORTHO', 'Orthopaedics', 'J.Watson', '1236');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('PAE', 'Paediatrics', 'J. Dolittle', '1249');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('PSY', 'Psychiatry', 'H. Lecter', '1244');
INSERT INTO `mydb`.`DEPARTMENT` (`Dept_Code`, `Dept_Name`, `Head_of_Dept`, `Employee_ID`) VALUES ('SUR', 'Surgery', 'C. Turk', '1239');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`SCHEDULE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '8:00:00', '19:00:00', 'A&E');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1', '10:00:00', '16:00:00', 'CARDIO');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '17:00:00', 'DEN');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1', '9:00:00', '16:00:00', 'DERMA');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '8:00:00', '20:00:00', 'ENT');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '17:00:00', 'FIN');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1', '9:00:00', '16:00:00', 'HR');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2, 3', '7:00:00', '18:00:00', 'ICU');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '10:00:00', '18:00:00', 'INFECD');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '17:00:00', 'ITM');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2, 3', '7:00:00', '16:00:00', 'LAB');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '11:00:00', '20:00:00', 'MED');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1', '8:00:00', '16:00:00', 'NEURO');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '17:00:00', 'NUCMED');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '10:00:00', '16:00:00', 'OBGYN');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1', '9:00:00', '17:00:00', 'ONCO');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '10:00:00', '19:00:00', 'OPH');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '20:00:00', 'ORTHO');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '17:00:00', 'PAE');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '9:00:00', '18:00:00', 'PSY');
INSERT INTO `mydb`.`SCHEDULE` (`Date`, `Shift`, `Start_Time`, `End_Time`, `DEPARTMENT_Dept_Code`) VALUES ('2022-12-25', '1, 2', '8:00:00', '23:00:00', 'SUR');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`EMPLOYEE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1234, 'Bruce', 'Banner', '', '1/11/1989', 1234567891, 'Banner@hospital.com', '595 E 19th St Oakland CA 94606', 756893456, 150000, 'CARDIO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1235, 'Stephen', 'Strange', '', '1/12/1989', 1234567892, 'Strange@hospital.com', '595 E 18th St Oakland CA 94606', 756893457, 150000, 'A&E', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1236, 'John', 'Watson', '', '1/13/1989', 1234567893, 'Watson@hospital.com', '596 E 19th St Oakland CA 94606', 756893458, 150000, 'ORTHO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1237, 'Leonard', 'McCoy', '', '1/14/1989', 1234567894, 'McCoy@hospital.com', '596 E 18th St Oakland CA 94606', 756893459, 150000, 'DEN', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1238, 'Shaun', 'Murphy', '', '1/15/1989', 1234567895, 'Murphy@hospital.com', '597 E 19th St Oakland CA 94606', 756893460, 150000, 'MED', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1239, 'Christopher', 'Turk', '', '1/16/1989', 1234567896, 'Turk@hospital.com', '597 E 18th St Oakland CA 94606', 756893461, 150000, 'SUR', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1240, 'Doogie', 'Howser', '', '2/24/1975', 1234567897, 'Howser@hospital.com', '598 E 19th St Oakland CA 94606', 756893462, 150000, 'NEURO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1241, 'Cristina', 'Yang', '', '2/25/1975', 1234567898, 'Yang@hospital.com', '598 E 18th St Oakland CA 94606', 756893463, 150000, 'SUR', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1242, 'Gregory', 'House', '', '2/26/1975', 1234567899, 'House@hospital.com', '599 E 19th St Oakland CA 94606', 756893464, 150000, 'INFECD', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1243, 'Malcolm', 'Sayer', '', '2/27/1975', 1234567900, 'Sayer@hospital.com', '477 Dubey St San Francisico CA 99372', 756893465, 150000, 'A&E', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1244, 'Hannibal', 'Lecter', '', '2/28/1975', 1234567901, 'Lecter@hospital.com', '478 Dubey St San Francisico CA 99372', 756893466, 150000, 'PSY', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1245, 'Hubert', 'Bombay', '', '3/7/1988', 1234567902, 'Bombay@hospital.com', '479 Dubey St San Francisico CA 99372', 756893467, 170000, 'INFECD', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1246, 'Meredith', 'Grey', '', '3/8/1990', 1234567903, 'Grey@hospital.com', '480 Dubey St San Francisico CA 99372', 756893468, 170000, 'OBGYN', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1247, 'Erin', 'Mears', '', '12/24/1984', 1234567904, 'Mears@hospital.com', '481 Dubey St San Francisico CA 99372', 756893469, 170000, 'A&E', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1248, 'Harley', 'Quinn', '', '12/25/1984', 1234567905, 'Quinn@hospital.com', '482 Dubey St San Francisico CA 99372', 756893470, 170000, 'DERMA', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1249, 'John', 'Dolittle', '', '12/26/1984', 1234567906, 'Dolittle@hospital.com', '5415 Avenger\'s Way Syracuse NY 01176', 756893471, 170000, 'PAE', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1250, 'Richard', 'Kimble', '', '12/27/1984', 1234567907, 'Kimble@hospital.com', '5416 Avenger\'s Way Syracuse NY 01176', 756893472, 170000, 'CARDIO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1251, 'Abraham', 'Helsing', 'Van', '12/28/1984', 1234567908, 'Helsing@hospital.com', '5417 Avenger\'s Way Syracuse NY 01176', 756893473, 170000, 'ICU', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1252, 'Frederick', 'Frankenstein', '', '12/29/1984', 1234567909, 'Frankenstein@hospital.com', '5418 Avenger\'s Way Syracuse NY 01176', 756893474, 170000, 'ICU', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1253, 'Johann', 'Georg', 'Faust', '12/30/1984', 1234567910, 'Georg@hospital.com', '5419 Avenger\'s Way Syracuse NY 01176', 756893475, 170000, 'ONCO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1254, 'Charles', 'McNider', 'Mid-Nite', '8/24/1972', 1234567911, 'McNider@hospital.com', '5420 Avenger\'s Way Syracuse NY 01176', 756893476, 170000, 'OPH', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1255, 'Elliot', 'Tolliver', 'Octopus', '8/25/1972', 1234567912, 'Tolliver@hospital.com', '5421 Avenger\'s Way Syracuse NY 01176', 756893477, 170000, 'PSY', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1256, 'Victor', 'Doom', 'Von', '8/26/1972', 1234567913, 'Doom@hospital.com', '5422 Avenger\'s Way Syracuse NY 01176', 756893478, 170000, 'NUCMED', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1257, 'Samantha ', 'Taggart', '', '8/27/1972', 1234567914, 'Taggart@hospital.com', '745 Cooldude Ave Berkeley CA 94888', 756893479, 170000, 'CARDIO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1258, 'Veronica', 'Callahan', '', '8/28/1972', 1234567915, 'Callahan@hospital.com', '746 Cooldude Ave Berkeley CA 94888', 756893480, 170000, 'MED', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1259, 'Peter', 'Petrelli', '', '8/29/1972', 1234567916, 'Petrelli@hospital.com', '747 Cooldude Ave Berkeley CA 94888', 756893481, 135000, 'ICU', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1260, 'Carla', 'Espinosa', '', '8/30/1972', 1234567917, 'Espinosa@hospital.com', '748 Cooldude Ave Berkeley CA 94888', 756893482, 135000, 'A&E', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1261, 'Carol', 'Hathaway', '', '8/31/1972', 1234567918, 'Hathaway@hospital.com', '749 Cooldude Ave Berkeley CA 94888', 756893483, 135000, 'ICU', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1262, 'Christina', 'Hawthorne', '', '9/1/1972', 1234567919, 'Hawthorne@hospital.com', '690 Hell St Stockton CA 95355', 756893484, 135000, 'DEN', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1263, 'Nurse', 'Jackie', '', '9/2/1972', 1234567920, 'Jackie@hospital.com', '691 Hell St Stockton CA 95355', 756893485, 135000, 'SUR', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1264, 'Dell', 'Parker', '', '9/9/1989', 1234567921, 'Parker@hospital.com', '692 Hell St Stockton CA 95355', 756893486, 135000, 'PSY', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1265, 'Helen', 'Rosenthal', '', '9/10/1989', 1234567922, 'Rosenthal@hospital.com', '693 Hell St Stockton CA 95355', 756893487, 135000, 'HR', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1266, 'Christine', 'Chapel', '', '9/11/1989', 1234567923, 'Chapel@hospital.com', '694 Hell St Stockton CA 95355', 756893488, 135000, 'CARDIO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1267, 'Abby', 'Lockhart', '', '9/12/1989', 1234567924, 'Lockhart@hospital.com', '695 Hell St Stockton CA 95355', 756893489, 135000, 'INFECD', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1268, 'Margaret', 'Houlihan', '', '9/13/1989', 1234567925, 'Houlihan@hospital.com', '696 Hell St Stockton CA 95355', 756893490, 135000, 'PAE', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1269, 'Bonnie', 'Hunt', '', '9/14/1989', 1234567926, 'Hunt@hospital.com', '697 Hell St Stockton CA 95355', 756893491, 135000, 'A&E', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1270, 'Naomi', 'Judd', '', '9/15/1989', 1234567927, 'Judd@hospital.com', '698 Hell St Stockton CA 95355', 756893492, 135000, 'ORTHO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1271, 'Charles', 'Cullen', '', '9/16/1989', 1234567928, 'Cullen@hospital.com', '535 Seaside Ct San Diego CA 90210', 756893493, 135000, 'ONCO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1272, 'Luann ', 'Lesseps', 'de', '9/17/1989', 1234567929, 'Lesseps@hospital.com', '536 Seaside Ct San Diego CA 90210', 756893494, 120000, 'OBGYN', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1273, 'Jo', 'Brand', '', '9/18/1989', 1234567930, 'Brand@hospital.com', '537 Seaside Ct San Diego CA 90210', 756893495, 120000, 'PSY', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1274, 'Robin', 'Quivers', 'Jr', '9/19/1989', 1234567931, 'Quivers@hospital.com', '538 Seaside Ct San Diego CA 90210', 756893496, 120000, 'OBGYN', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1275, 'Mercy', 'Street', '', '10/10/1992', 1234567932, 'Street@hospital.com', '539 Seaside Ct San Diego CA 90210', 756893497, 120000, 'OPH', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1276, 'Virgin', 'River', '', '10/11/1992', 1234567933, 'River@hospital.com', '540 Seaside Ct San Diego CA 90210', 756893498, 120000, 'NUCMED', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1277, 'Mary', 'Benjamin', '', '10/12/1992', 1234567934, 'Benjamin@hospital.com', '541 Seaside Ct San Diego CA 90210', 756893499, 120000, 'NEURO', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1278, 'Ann', 'Perkins', '', '10/13/1992', 1234567935, 'Perkins@hospital.com', '321 Commuter\'s Ct Vacaville CA 98620', 756893500, 120000, 'MED', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1279, 'Milo', 'Ventimiglia', '', '10/14/1992', 1234567936, 'Ventimiglia@hospital.com', '322 Commuter\'s Ct Vacaville CA 98620', 756893501, 120000, 'ICU', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1280, 'John', 'Dorian', 'J.D.', '10/15/1992', 1234567937, 'Dorian@hospital.com', '323 Commuter\'s Ct Vacaville CA 98620', 756893502, 120000, 'ENT', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1281, 'Elliot', 'Reid', '', '10/16/1992', 1234567938, 'Reid@hospital.com', '324 Commuter\'s Ct Vacaville CA 98620', 756893503, 120000, 'PAE', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1282, 'John ', 'Bilkey', 'E', '10/17/1992', 1234567939, 'Bilkey@hospital.com', '945 Us Blvd Berkeley CA 94648', 756893504, 120000, 'LAB', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1283, 'Claudia', 'Poptile', 'I', '7/7/1996', 1234567940, 'Poptile@hospital.com', '946 Us Blvd Berkeley CA 94648', 756893505, 100000, 'HR', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1284, 'Sabrina', 'Wiatr', 'F', '7/8/1996', 1234567941, 'Wiatr@hospital.com', '947 Us Blvd Berkeley CA 94648', 756893506, 100000, 'ITM', '2022-12-25');
INSERT INTO `mydb`.`EMPLOYEE` (`Employee_ID`, `Fname`, `Lname`, `MI`, `DOB`, `Phone_Num`, `Email`, `Address`, `SSN`, `Salary`, `DEPARTMENT_Dept_Code`, `SCHEDULE_Date`) VALUES (1285, 'Sonia', 'Paredes', 'U', '7/9/1996', 1234567942, 'Paredes@hospital.com', '948 Us Blvd Berkeley CA 94648', 756893507, 100000, 'FIN', '2022-12-25');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`DOCTOR`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1234, 'Bruce', 'Banner', '', 'Cardiology', 10);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1235, 'Stephen', 'Strange', '', 'Accident and emergency', 15);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1236, 'John', 'Watson', '', 'Orthopaedics', 12);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1237, 'Leonard', 'McCoy', '', 'Dental', 13);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1238, 'Shaun', 'Murphy', '', 'Medicine', 8);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1239, 'Christopher', 'Turk', '', 'Surgery', 9);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1240, 'Doogie', 'Howser', '', 'Neurology', 21);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1241, 'Cristina', 'Yang', '', 'Surgery', 4);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1242, 'Gregory', 'House', '', 'Infectious disease', 6);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1243, 'Malcolm', 'Sayer', '', 'Accident and emergency', 7);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1244, 'Hannibal', 'Lecter', '', 'Psychiatry', 9);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1245, 'Hubert', 'Bombay', '', 'Infectious disease', 10);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1246, 'Meredith', 'Grey', '', 'Obstetrics/Gynaecology', 6);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1247, 'Erin', 'Mears', '', 'Accident and emergency', 11);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1248, 'Harley', 'Quinn', '', 'Dermatology', 23);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1249, 'John', 'Dolittle', '', 'Paediatrics', 3);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1250, 'Richard', 'Kimble', '', 'Cardiology', 5);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1251, 'Abraham', 'Helsing', 'Van', 'Intensive Care', 7);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1252, 'Frederick', 'Frankenstein', '', 'Intensive Care', 8);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1253, 'Johann', 'Georg', 'Faust', 'Oncology', 9);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1254, 'Charles', 'McNider', 'Mid-Nite', 'Ophthalmology', 2);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1255, 'Elliot', 'Tolliver', 'Octopus', 'Psychiatry', 12);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1256, 'Victor', 'Doom', 'Von', 'Nuclear medicine', 11);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1280, 'John', 'Dorian', 'J.D.', 'ENT', 8);
INSERT INTO `mydb`.`DOCTOR` (`EMPLOYEE_Employee_ID`, `Fname`, `Lname`, `MI`, `Speciality`, `YearsOfExperience`) VALUES (1281, 'Elliot', 'Reid', '', 'Paediatrics', 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`PATIENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (59412, 'Jon', 'Snow', 'T', 'In', 'M', '02-09-1995', '2099853396', 'ghostlover67@gmail.com', '595 E 19th St Oakland CA 94606', 465656885, 'Yes', 'MediCal', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (54865, 'Wanyu', 'Bi', 'G', 'In', 'F', '12-22-1985', '2094168382', 'most_lovedd0gs@berkeley.edu', '478 Dubey St San Francisico CA 99372', 975665555, 'Yes', 'Anthem', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (54566, 'Stephen', 'Strange', 'D', 'In', 'M', '01-09-1999', '2092898571', 'avengdrdude@yahoo.com', '55995 Avenger\'s Way Syracuse NY 01176', 866488285, 'Yes', 'Berkeley SHIP', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (97812, 'Ankit', 'Bhawsar', 'N', 'Out', 'M', '05-25-1920', '5099695788', 'body4builds@gmail.com', '745 Cooldude Ave Berkeley CA 94888', 952952595, 'No', 'No Insur', 'Loan');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (84369, 'Aakash', 'Sundaresan', 'L', 'Out', 'M', '06-15-1988', '2132101016', 'deathnotedaddywanted@gmail.com', '690 Hell St Stockton CA 95355', 971861265, 'No', 'No Insur', 'HSA');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (65463, 'Anshul', 'Nidhi', 'S', 'In', 'F', '02-28-2000', '8312271257', 'sunset_sd_ansh@berkeley.edu', '535 Seaside Ct San Diego CA 90210', 584365385, 'Yes', 'BlueCross Blue Shield', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (86458, 'Adedeji', 'Aluko', 'O', 'In', 'M', '06-07-1975', '2092271222', 'mylilstar374@gmail.com', '321 Commuter\'s Ct Vacaville CA 98620', 544521255, 'Yes', 'Anthem', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (65874, 'Stewart', 'Liu', 'P', 'In', 'M', '02-25-2001', '6138345259', 'jpeele_dabest@berkeley.edu', '945 Us Blvd Berkeley CA 94648', 849189556, 'Yes', 'Anthem', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (82835, 'Chirag', 'Maghani', 'G', 'Out', 'M', '03-09-1967', '5109149094', 'urfav_gsi@gmail.com', '7654 Sequel St Oakland CA 94655', 383436438, 'Yes', 'Anthem', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (89146, 'Sofia', 'Paredes', 'E', 'In', 'F', '04-13-1943', '2094169756', 'iluvchad143@berkeley.edu', '954 Brad St Ashby CA 94553', 876565561, 'Yes', 'Berkeley SHIP', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (99945, 'Bora ', 'Unalmis', 'S', 'Out', 'M', '09-12-1996', '2097661264', 'ucb_swimms42@berkeley.edu', '968 Pool St Berkeley CA 97543', 875654658, 'No', 'No Insur', 'Loan');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (98765, 'Serah', 'Varghese', 'S', 'Out', 'F', '01-30-1948', '5108988880', 'sillee3squirls@gmail.com', '411 Zoomba Ave Berkeley CA 93672', 123353564, 'No', 'No Insur', 'Card');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (12340, 'Henry', 'Xu', 'Y', 'Out', 'M', '06-19-2005', '3418794469', 'yaboi384t@gmail.com', '99 Opin Way Oakland CA 98523', 321355542, 'Yes', 'MediCal', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (13723, 'Xinyi', 'Zhang', 'W', 'Out', 'F', '08-19-1998', '9882048987', 'happyjadejacket@berkeley.edu', '93 Bancroft Berkeley CA 94655', 233121345, 'No', 'No Insur', 'Card');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (10388, 'Mickey', 'Mouse', 'D', 'Out', 'M', '01-01-1925', '2095547978', 'ohhoplut0@gmail.com', '43770 Dreamland St Anaheim CA 90456 ', 986654555, 'Yes', 'Anthem', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (17733, 'Luke', 'Skywalker', 'J', 'Out', 'M', '09-06-1968', '5103545654', 'be_with_u@gmail.com', '985 Skywalker Ranch Way Mariposa CA 94255', 687452523, 'Yes', 'Berkeley SHIP', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (81992, 'Arnaud', 'Minondo', 'F', 'Out', 'M', '02-06-1962', '4157166532', 'i_domath@berkeley.edu', '314 Stats St Berkeley CA 98563', 985353222, 'No', 'No Insur', 'Loan');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (50888, 'Sake', 'Amornnorachai', 'M', 'In', 'M', '07-04-1914', '4157451289', 'gone2canad@yahoo.com', '234 Cold St Oakland CA 98566', 215535522, 'No', 'No Insur', 'HSA');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (95650, 'Angela', 'Merkel', 'D', 'Out', 'F', '11-25-1960', '2099604748', 'retir3dpm@gmail.com', '338 Deustche Blvd Los Angeles CA 90244', 321555559, 'Yes', 'Anthem', 'Insur');
INSERT INTO `mydb`.`PATIENT` (`Patient_ID`, `Fname`, `Lname`, `MI`, `Patient_Type`, `Gender`, `DOB`, `Phone_Num`, `Email`, `Address`, `SNN`, `Insurance`, `Insurance Company`, `Payment`) VALUES (99833, 'Tyrion', 'Lanister', 'C', 'In', 'M', '10-11-1954', '5106639587', 'god_of_tandwine2yahoo.com', '100 Casterly Way Westerlands CA 90555', 913232315, 'Yes', 'BlueCross Blue Shield', 'Insur');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`NURSE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Samantha ', 'Taggart', '', 'Cardiac', '', 1257);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Veronica', 'Callahan', '', 'Clinical', '', 1258);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Peter', 'Petrelli', '', 'Critical Care', '', 1259);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Carla', 'Espinosa', '', 'ER', '', 1260);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Carol', 'Hathaway', '', 'Geriatric', '', 1261);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Christina', 'Hawthorne', '', 'Registered', 'Yes', 1262);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Nurse', 'Jackie', '', 'Perioperative', '', 1263);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Dell', 'Parker', '', 'Mental Health', '', 1264);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Helen', 'Rosenthal', '', 'Manager', '', 1265);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Christine', 'Chapel', '', 'Cardiac', '', 1266);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Abby', 'Lockhart', '', 'Clinical', '', 1267);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Margaret', 'Houlihan', '', 'Critical Care', '', 1268);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Bonnie', 'Hunt', '', 'ER', '', 1269);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Naomi', 'Judd', '', 'Geriatric', '', 1270);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Charles', 'Cullen', '', 'Registered', 'Yes', 1271);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Luann ', 'Lesseps', 'de', 'Perioperative', '', 1272);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Jo', 'Brand', '', 'Mental Health', '', 1273);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Robin', 'Quivers', 'Jr', 'Registered', 'Yes', 1274);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Mercy', 'Street', '', 'Registered', 'Yes', 1275);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Virgin', 'River', '', 'Registered', 'Yes', 1276);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Mary', 'Benjamin', '', 'Registered', 'Yes', 1277);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Ann', 'Perkins', '', 'Clinical', '', 1278);
INSERT INTO `mydb`.`NURSE` (`Fname`, `Lname`, `MI`, `Postion`, `Registered`, `EMPLOYEE_Employee_ID`) VALUES ('Milo', 'Ventimiglia', '', 'Critical Care', '', 1279);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`BLOCK`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (11, 'Section A', '1');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (12, 'Section B', '1');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (21, 'Section A', '2');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (22, 'Section B', '2');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (31, 'Section A', '3');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (32, 'Section B', '3');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (41, 'Section A', '4');
INSERT INTO `mydb`.`BLOCK` (`Block_Code`, `Block_Description`, `Block_Floor`) VALUES (42, 'Section B', '4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`APPOINTMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (101, '2022-11-24 10:00', '2022-11-24 11:00', 201, 21, 1234, 59412);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (102, '2022-11-25 9:00', '2022-11-25 10:00', 203, 21, 1234, 54865);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (103, '2022-11-26 10:00', '2022-11-26 11:00', 206, 22, 1235, 54566);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (104, '2022-11-27 11:30', '2022-11-27 12:00', 104, 11, 1243, 97812);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (105, '2022-11-28 10:00', '2022-11-28 11:00', 105, 11, 1247, 84369);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (106, '2022-11-29 10:00', '2022-11-29 11:00', 207, 22, 1251, 65463);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (107, '2022-11-30 15:00', '2022-11-30 15:30', 209, 22, 1252, 86458);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (108, '2022-12-01 10:00', '2022-12-01 11:00', 302, 31, 1253, 65874);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (109, '2022-12-02 14:00', '2022-12-02 15:00', 106, 12, 1254, 82835);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (110, '2022-12-03 10:00', '2022-12-03 11:00', 109, 12, 1255, 89146);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (111, '2022-12-04 13:30', '2022-12-04 14:00', 107, 12, 1256, 99945);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (112, '2022-12-05 10:00', '2022-12-05 11:00', 409, 42, 1240, 98765);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (113, '2022-12-06 13:00', '2022-12-06 13:30', 410, 42, 1250, 12340);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (114, '2022-12-07 10:00', '2022-12-07 11:00', 405, 41, 1250, 13723);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (115, '2022-12-08 9:30', '2022-12-08 10:30', 406, 42, 1240, 10388);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (116, '2022-12-09 10:00', '2022-12-09 11:00', 407, 42, 1241, 17733);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (117, '2022-12-10 11:00', '2022-12-10 11:30', 309, 32, 1245, 81992);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (118, '2022-12-11 10:00', '2022-12-11 11:00', 210, 22, 1247, 50888);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (119, '2022-12-12 13:00', '2022-12-12 14:00', 307, 32, 1234, 95650);
INSERT INTO `mydb`.`APPOINTMENT` (`Appointment_ID`, `Start_time`, `End_time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (120, '2022-12-13 8:00', '2022-12-13 9:00', 301, 31, 1237, 99833);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`MEDICATION`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (1, 'Procrastin-X', 'X', 'Relieves all time management problems');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (2, 'Thesisin', 'Foo Labs', 'Relieves from not graduating');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (3, 'Awakin', 'Bar Labs', 'Relieves falling from a sleep and missing your final');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (4, 'Crescavitin', 'Cal Pharm', 'Relieves all muscle pains');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (5, 'Melioraurin', 'We Rock Labs', 'Relieves all teeth pains');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (6, 'Stressin', 'Cal Pharm', 'Relieves from all kind of unnecessary stress pains');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (7, 'Nosleepin', 'Caffeine Pharm', 'Helps you pull an all nighter and keeps you healthy');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (8, 'Vibin', 'Happy Labs', 'Increases dopamine levels');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (9, 'Survivin', 'IEOR Labs', 'Helps in anxiety attacks');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (10, 'Passin', 'IEOR Labs', 'Helps from failing in life and feel less depressed');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (11, 'PlsgivgudmaRX', 'S.Liu Pharm', 'Helps in passing all things in life');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (12, 'Urdoingagudjob', 'S.Liu GSI Labs', 'Increase confidence level ');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (13, 'Wemadeit', 'IEOR Pharm', 'Relieves all financial burden');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (14, 'Manalytx', 'IEOR Pharm', 'Helps for studying for comprehesive exams');
INSERT INTO `mydb`.`MEDICATION` (`Medication_Code`, `Drug_Generic_Name`, `Brand_Name`, `Description`) VALUES (15, 'CurveurmaRX', 'S.Liu Pharm', 'Helps solve all patients problem');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`TREATMENT`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (1, '2022-11-24 11:00', 201, 22, 1234, 59412);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (2, '2022-11-25 10:00', 203, 22, 1234, 54865);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (3, '2022-11-26 11:00', 206, 22, 1235, 54566);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (4, '2022-11-27 12:30', 104, 11, 1243, 97812);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (4, '2022-11-28 11:00', 105, 11, 1247, 84369);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (6, '2022-11-29 11:00', 207, 22, 1251, 65463);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (7, '2022-11-30 15:30', 209, 22, 1252, 86458);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (4, '2022-12-01 11:00', 302, 31, 1253, 65874);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (9, '2022-12-02 14:00', 106, 12, 1254, 82835);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (5, '2022-12-03 10:00', 109, 12, 1255, 89146);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (11, '2022-12-04 13:30', 107, 12, 1256, 99945);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (9, '2022-12-05 10:00', 409, 42, 1240, 98765);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (13, '2022-12-06 13:00', 410, 42, 1250, 12340);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (4, '2022-12-07 10:00', 405, 41, 1250, 13723);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (15, '2022-12-08 9:30', 406, 42, 1240, 10388);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (13, '2022-12-09 10:00', 407, 42, 1241, 17733);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (17, '2022-12-10 11:00', 309, 32, 1245, 81992);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (3, '2022-12-11 10:00', 210, 22, 1247, 50888);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (19, '2022-12-12 13:00', 307, 32, 1234, 95650);
INSERT INTO `mydb`.`TREATMENT` (`Treatment_ID`, `Treatment_Time`, `ROOM_Room_Number`, `ROOM_BLOCK_Block_Code`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES (20, '2022-12-13 8:00', 301, 31, 1237, 99833);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Prescriptions`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-24 11:00', 1234, 59412);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-25 10:00', 1234, 54865);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-26 11:00', 1235, 54566);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-27 12:00', 1243, 97812);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-28 11:00', 1247, 84369);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-29 11:00', 1251, 65463);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-11-30 15:30', 1252, 86458);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-01 11:00', 1253, 65874);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-02 15:00', 1254, 82835);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-03 11:00', 1255, 89146);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-04 14:00', 1256, 99945);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-05 11:00', 1240, 98765);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-06 13:30', 1250, 12340);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-07 11:00', 1250, 13723);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-08 10:30', 1240, 10388);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-09 11:00', 1241, 17733);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-10 11:30', 1245, 81992);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-11 11:00', 1247, 50888);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-12 14:00', 1234, 95650);
INSERT INTO `mydb`.`Prescriptions` (`Date`, `DOCTOR_EMPLOYEE_Employee_ID`, `PATIENT_Patient_ID`) VALUES ('2022-12-13 9:00', 1237, 99833);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`AMBULANCE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (1, 'A&E');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (2, 'A&E');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (3, 'A&E');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (4, 'A&E');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (5, 'A&E');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (6, 'A&E');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (7, 'OBGYN');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (8, 'OBGYN');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (9, 'OBGYN');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (10, 'OBGYN');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (11, 'INFECD');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (12, 'INFECD');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (13, 'ICU');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (14, 'ICU');
INSERT INTO `mydb`.`AMBULANCE` (`Ambulance_ID`, `DEPARTMENT_Dept_Code`) VALUES (15, 'ICU');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`DEPARTMENT_has_BLOCK`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('A&E', 11);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('CARDIO', 11);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('DEN', 12);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('DERMA', 12);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('ENT', 21);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('FIN', 21);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('HR', 22);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('ICU', 22);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('INFECD', 22);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('ITM', 31);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('LAB', 31);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('MED', 31);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('NEURO', 32);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('NUCMED', 32);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('OBGYN', 32);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('ONCO', 41);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('OPH', 41);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('ORTHO', 41);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('PAE', 42);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('PSY', 42);
INSERT INTO `mydb`.`DEPARTMENT_has_BLOCK` (`DEPARTMENT_Dept_Code`, `BLOCK_Block_Code`) VALUES ('SUR', 42);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Prescriptions_has_MEDICATION`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-24 11:00', 1234, 59412);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-25 10:00', 1234, 54865);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-26 11:00', 1235, 54566);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-27 12:00', 1243, 97812);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-28 11:00', 1247, 84369);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-29 11:00', 1251, 65463);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-11-30 15:30', 1252, 86458);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-01 11:00', 1253, 65874);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-02 15:00', 1254, 82835);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-03 11:00', 1255, 89146);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-04 14:00', 1256, 99945);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-05 11:00', 1240, 98765);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-06 13:30', 1250, 12340);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-07 11:00', 1250, 13723);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-08 10:30', 1240, 10388);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-09 11:00', 1241, 17733);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-10 11:30', 1245, 81992);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-11 11:00', 1247, 50888);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-12 14:00', 1234, 95650);
INSERT INTO `mydb`.`Prescriptions_has_MEDICATION` (`Prescriptions_Date`, `Prescriptions_DOCTOR_EMPLOYEE_Employee_ID`, `MEDICATION_Medication_Code`) VALUES ('2022-12-13 9:00', 1237, 99833);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
