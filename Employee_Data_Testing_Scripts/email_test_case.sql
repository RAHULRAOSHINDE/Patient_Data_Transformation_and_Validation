#test case to findout the employees from employee_initial whose Email starts with 'e'

SELECT * FROM employee_initial WHERE SUBSTRING_INDEX(email,1,1) = 'e';