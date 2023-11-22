#checksum testing on eid column

select SUM(eid) FROM employee_initial;

select SUM(eid) FROM employee_target;

#The check sum is 32492 in employee_initial and 32492 in employee_target