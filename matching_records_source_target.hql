#hive query to find out number of matching records in the source and target tables using 'intersect' keyword

SELECT pid,pname,SUBSTR(addr,LOCATE('+',addr)),history,dob,allergies 
FROM patient 
WHERE YEAR(dob) <=1995 
INTERSECT 
SELECT * FROM patients_target;