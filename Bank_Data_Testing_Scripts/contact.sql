
#Create a table which consists data for contact without header row

CREATE EXTERNAL TABLE IF NOT EXISTS contact_source (
custId int,
age int,
job string,
martial string,
education string,
default string,
balance int,
contact string,
day int,
month string,
duration int,
campaign int,
pdays int,
previous_connects int
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
TBLPROPERTIES("skip.header.line.count"="1")
;

#Load data into contact_source table

LOAD DATA LOCAL INPATH '/root/Desktop/save_folder/Bank_Data_Testing_Scripts/contact.csv' INTO TABLE contact_source;


#Remove duplicate information
#Where contact is not specified, replace it with unknown
#Replace the month with month number

CREATE VIEW contact_data AS
SELECT * FROM(
SELECT DISTINCT custid,age,job,martial,education,default,balance,
CASE 
  WHEN contact NOT IN ('unknown','telephone','cellular')
  THEN 'unknown' ELSE contact
  END AS contact,
  day,
CASE 
  WHEN month = 'jan' THEN 01
  WHEN month = 'feb' THEN 02
  WHEN month = 'mar' THEN 03
  WHEN month = 'apr' THEN 04
  WHEN month = 'may' THEN 05
  WHEN month = 'jun' THEN 06
  WHEN month = 'jul' THEN 07
  WHEN month = 'aug' THEN 08
  WHEN month = 'sep' THEN 09
  WHEN month = 'oct' THEN 10
  WHEN month = 'nov' THEN 11
  WHEN month = 'dec' THEN 12
ELSE NULL
END AS month,
duration,
campaign,
pdays,
previous_connects,
ROW_NUMBER() OVER (PARTITION BY custid ORDER BY day DESC,month DESC) as row_num
FROM contact_source
) latest_contact
WHERE row_num =1;

#Filtering the data with “unknown contact” to a separate file  be sent to the team responsible for maintaining contact information

hive -e "select * from contact_source where contact = 'unknown'" > ~/unknown_contact.csv

#latest contact information 

hive -e "select * from contact_data where contact != 'unknown'" > ~/cleansed_contact_data.csv
       
#Create a table which consists data for cleansed contact data

CREATE EXTERNAL TABLE IF NOT EXISTS cleansed_contact_data (
custId int,
age int,
job string,
martial string,
education string,
default string,
balance int,
contact string,
day int,
month string,
duration int,
campaign int,
pdays int,
previous_connects int
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/cleansed_data'
;

#Load data into cleansed_contact_data table

LOAD DATA LOCAL INPATH '/root/cleansed_contact_data.csv' INTO TABLE cleansed_contact_data;

 
#Create a table which consists data for loan data

CREATE EXTERNAL TABLE IF NOT EXISTS loan_data (
custid int,
house_loan string,
personal_loan string
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
TBLPROPERTIES("skip.header.line.count"="1")
;

#Load data into loan_data table

LOAD DATA LOCAL INPATH '/root/Desktop/user_repo/To_Participant/AdditionalSuppliedFiles/loan.csv' INTO TABLE loan_data;

#Analyzing data 

#criteria : If no record for the customer is found in loan.csv, assume that the customer has no loans
#and extracting the results as a text file and renaming it as campaign_data.txt

INSERT OVERWRITE LOCAL DIRECTORY '/root/Desktop/save_folder/Bank_Data_Testing_Scripts/campaign'
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
SELECT cl.custid AS cl_custid,cl.age,cl.job,cl.martial,cl.education,cl.default,cl.balance,cl.contact,cl.day,cl.month,cl.duration,cl.campaign,cl.pdays,cl.previous_connects
FROM cleansed_contact_data cl
LEFT JOIN loan_data ld
ON cl.custid = ld.custid
WHERE ld.custid is NULL;

mv /root/Desktop/save_folder/Bank_Data_Testing_Scripts/campaign/000000_0 /root/Desktop/save_folder/Bank_Data_Testing_Scripts/campaign/campaign_data.txt

#Validating data

# To check that no of record in contact.csv is equal to sum of records in “Unknown Contact” file in Unix and “Known contact” in Hive”

#converting the endings to unix format

# no of records in contact.csv-->4524

wc -l unknown_contact.csv #to check no of record in unknown_contact.csv

#no of records in unknown_contact.csv  --> 1327

SELECT COUNT(*) FROM cleansed_contact_data;

#no of known_contacts uploaded in hive --> 1919

#no of records in loan_data in hive -1687

SELECT COUNT(*) FROM loan_data ;

#no of records in loan_data in unix --> 1688





