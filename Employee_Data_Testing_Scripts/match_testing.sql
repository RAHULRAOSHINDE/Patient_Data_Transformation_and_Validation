#match testing using intersect on employee_initial and employee_target.

SELECT eid FROM employee_initial FROM employee_initial
INTERSECT 
SELECT eid FROM employee_target FROM employee_target; 

