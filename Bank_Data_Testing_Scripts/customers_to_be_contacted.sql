#list of customers to be contacted based on busines criteria


#creating a table which consists of customers to be contacted

CREATE EXTERNAL TABLE IF NOT EXISTS customers_to_be_contacted(
cl_custid int,
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
previous_connects int,
ld_custid int,
house_loan string,
personal_loan string
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
;

#inserting data which consists of customers to be contacted

INSERT INTO TABLE customers_to_be_contacted
SELECT cl.custid AS cl_custid,cl.age,cl.job,cl.martial,cl.education,cl.default,cl.balance,cl.contact,cl.day,cl.month,cl.duration,cl.campaign,cl.pdays,cl.previous_connects,ld.custid AS ld_custid,ld.house_loan,ld.personal_loan
from cleansed_contact_data cl
INNER JOIN loan_data ld
ON cl.custid =ld.custid
where cl.age > 18 
AND cl.job NOT IN ('unknown','unemployed','student')
AND cl.default = 'no'
AND ld.personal_loan = "yes" AND cl.balance > 1000 OR ld.house_loan ="no"
AND cl.contact IN ('cellular','telephone')
AND cl.pdays = '-1' OR cl.pdays='60'
AND cl.previous_connects < 3;

