#hive query to perform check sum testing on pid column between source and target tables created.

SELECT SUM(pid) FROM pstient  WHERE YEAR(dob) <=1995;

SELECT SUM(pid) FROM patients_target;

#The sum of the values of pid column in patient and patient_target tables are 821 and 821 respectively