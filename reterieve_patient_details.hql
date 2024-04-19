--hive query to retrieve the details of the patients born in the month of october as the hospital is planning to offer health check update for those born in the month of october. 

SELECT * FROM patient WHERE MONTH(dob) = 10;