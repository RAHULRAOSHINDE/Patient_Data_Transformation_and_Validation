--hive query to perform check sum testing on pid column between source and target tables created.

SELECT SUM(pid) FROM pstient  WHERE YEAR(dob) <=1995;

SELECT SUM(pid) FROM patients_target;

