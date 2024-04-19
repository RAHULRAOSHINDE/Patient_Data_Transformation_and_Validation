--hive query to perform count testing to verify the number of rows in source and target tables created. 

SELECT COUNT(*) FROM patient WHERE YEAR(dob) <= 1995;
SELECT COUNT(*) FROM patients_target;

