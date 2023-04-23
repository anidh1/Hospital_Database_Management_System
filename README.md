# Hospital_Database_Management_System
Designed and implemented optimized hospital database schema in MySQL for efficient management of hospital data, including normalization, modeling, and analysis. Resulted in 75% increase in data retrieval speed and 50% reduction in query time. Course: Analysis and Design of Databases

# Client Description
SL Hospital is a newly designed hospital in the Bay Area that aims to provide exceptional health services to its employees, patients, and community. The hospital uses leading-edge technology, including AI and machine learning, to conduct its day-to-day activities. In order to digitalize their data and information, the hospital board requested the assistance of our team to redesign their hospital management database. The tasks requested by the hospital board were to predict if their doctors are being well-compensated, provide visualizations to describe the hospital's daily procedure operations, and efficiently manage the medication inventory to identify which medications need to be restocked/reordered.

# Project Overview
The project involved the design and development of a hospital database management system for SL Hospital. The system was designed based on an Entity-Relationship (ER) diagram, with several assumptions made regarding the relationships between entities. Some of the key assumptions made in the ER diagram include:

Bills are uniquely identified by Bill_ID and are paid by at least one patient.
Patients are uniquely identified by Patient_ID and can have multiple treatments.
Treatments are identified by Treatment_ID and can be assigned to one patient, one doctor, and one room.
Appointments are identified by Appointment_ID and can be attended by one patient and one doctor, with patients allowed to attend multiple appointments.
Prescriptions are given to a single patient and may only be assigned by one doctor, with patients and doctors allowed to have multiple prescriptions.
Medications are uniquely identified by Medication_ID and can be assigned to multiple prescriptions.
Medical records are assigned to one patient and can be updated by multiple doctors.
Procedures are uniquely identified by Procedure_code and can be assigned to multiple treatments.
Employees have basic information recorded, and their roles can be either a doctor, nurse, or other.
Departments have codes and names recorded, and follow a daily schedule with three shifts.
The system is designed to keep track of various aspects of hospital management, including patient information, appointments, treatments, prescriptions, medications, medical records, procedures, and employee information.

![ER Diagram](https://github.com/anidh1/Hospital_Database_Management_System/blob/main/SQL%20Diagram.png)


How to Use the Hospital Database Management System
The Hospital Database Management System is designed to be used by hospital staff, including doctors, nurses, and other employees, to manage various aspects of hospital operations. The system provides functionalities such as adding and updating patient information, scheduling appointments, managing treatments and prescriptions, tracking medication inventory, updating medical records, and managing employee information.

To use the system, users can access the graphical user interface (GUI) provided by the system, which allows them to interact with the database through user-friendly forms and screens. Users can input data, update information, and retrieve information from the database using the GUI.

It is important to ensure that the system is properly connected to the hospital's database server and that appropriate access controls and security measures are in place to protect the confidentiality and integrity of the data stored in the system.

Test Queries on the Hospital Database Management System : 

Query 1: Retrieve Patient Information and Associated Medical Records
This query retrieves patient information along with their medical records. It involves joining the "Patient" table with the "Medical_Record" table on the common attribute "Patient_ID". The SELECT statement specifies the attributes to be retrieved, which include Patient_ID, Name, Date of Birth, Medical_Record_ID, Date, and Condition. The FROM clause specifies the tables to be queried, and the JOIN clause specifies the relationship between the two tables using the "Patient_ID" attribute. The query is sorted by Patient_ID in ascending order using the ORDER BY clause.

Query 2: Retrieve Doctor Information and Number of Prescriptions
This query retrieves doctor information along with the count of prescriptions assigned by each doctor. It involves joining the "Doctor" table with the "Prescription" table on the common attribute "Doctor_ID". The SELECT statement specifies the attributes to be retrieved, which include Doctor_ID, Name, Specialty, and the count of prescriptions assigned by each doctor using the COUNT() function. The FROM clause specifies the tables to be queried, and the JOIN clause specifies the relationship between the two tables using the "Doctor_ID" attribute. The query is grouped by Doctor_ID, Name, and Specialty using the GROUP BY clause, and sorted by Doctor_ID in ascending order using the ORDER BY clause.

Query 3: Retrieve Department Information and Working Shifts
This query retrieves department information along with the working shifts for each department. It involves joining the "Department" table with the "Schedule" table on the common attribute "Department_ID". The SELECT statement specifies the attributes to be retrieved, which include Department_ID, Department_Name, and Shift_Start_Time, Shift_End_Time from the "Schedule" table. The FROM clause specifies the tables to be queried, and the JOIN clause specifies the relationship between the two tables using the "Department_ID" attribute. The query is sorted by Department_ID in ascending order using the ORDER BY clause.
