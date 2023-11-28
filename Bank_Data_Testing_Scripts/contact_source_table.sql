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

