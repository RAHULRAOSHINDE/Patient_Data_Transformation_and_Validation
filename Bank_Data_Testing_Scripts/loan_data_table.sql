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