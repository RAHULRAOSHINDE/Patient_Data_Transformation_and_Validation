#hive query to perform count testing to verify the number of rows in source and target tables created. 

SELECT COUNT(*) FROM patient WHERE YEAR(dob) <= 1995;
SELECT COUNT(*) FROM patients_target;

#The number of records in the patient table and patient_target table are 5 and 5 respectively.