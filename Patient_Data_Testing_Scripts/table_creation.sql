#Creating an external table patient (source table) in hive and loading the data into table

CREATE EXTERNAL TABLE IF NOT EXISTS patient (
pid INT,
pname STRING,
addr STRING,
history STRING,
dob DATE,
allergies STRING
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/BigDataTesting/source'
;

#The loading of data from patient.txt file is from local directory,
LOAD DATA LOCAL INPATH '/root/Desktop/user_repo/To_Participant/AdditionalSuppliedFiles/patient.txt' INTO TABLE patient;

#Business Transformations applied on patient.txt file:

#Filter the patients born after 1995
#To Create a new column 'country code' holding the Extracted portion from '+' onwards in the address column.

CREATE VIEW BusinessTransformations AS 
SELECT pid,pname,addr,history,dob,allergies,
CASE WHEN LOCATE('+',addr)>0
THEN SUBSTR(addr,LOCATE('+',addr)+1)
ELSE NULL
END AS countrycode
FROM patient
WHERE YEAR(dob) > 1995;

#Creating a table patient_target (target table) in hive and loading the data into table 

CREATE EXTERNAL TABLE IF NOT EXISTS patients_target(
pid INT,
pname STRING,
countrycode STRING,
history STRING,
dob DATE,
allergies STRING
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/BigDataTesting/target';

LOAD DATA LOCAL INPATH '/root/Desktop/user_repo/To_Participant/AdditionalSuppliedFiles/patient_target.txt' INTO TABLE patients_target; 







