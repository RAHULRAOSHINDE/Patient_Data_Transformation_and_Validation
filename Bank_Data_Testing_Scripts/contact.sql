
#no of rows in contact table =13572
#no of rows in temp table = 4258
# hive -e "select * from contact_view where contact = 'unknown' > ~/unknown_contact.txt


#Create a table which consists data for contact but without header row
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

INSERT OVERWRITE TABLE contact_source 
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
previous_connects
FROM contact_source;
;

#











