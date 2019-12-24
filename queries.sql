/* Query: get a list of all employees, ordered by last name. */
SELECT *
FROM employee
ORDER BY lastname;

/* Query: get average salary by employee. */
SELECT employee.name AS `Name`, AVG(salary.amount) AS `employee_salary`
FROM employee
         LEFT JOIN salary
                   ON employee.id = salary.employee_id
GROUP BY employee.id
HAVING employee_salary IS NOT NULL
ORDER BY `employee_salary`;

/* Query: get average and highest salary by position. */
SELECT position.title,
       MAX(salary.amount) AS `position_salary_max`,
       AVG(salary.amount) AS `position_salary_avg`
FROM employees_position_time AS emp_pos_time
         LEFT JOIN employee
                   ON emp_pos_time.employee_id = employee.id
         LEFT JOIN salary
                   ON employee.id = salary.employee_id
         LEFT JOIN position
                   ON emp_pos_time.position_id = position.id
GROUP BY position.title;

/* Query: get total number of days every person worked and total income. */
SELECT DISTINCT employee.id                               AS `employee_id`,
                employee.name                             AS `employee_name`,
                employee.lastname                         AS `employee_lastname`,
                COUNT(DISTINCT transport_accounting.date) AS `employee_worked_days`,
                SUM(transport_accounting.income)          AS `employee_sum_income`
FROM employees_position_time AS `emp_pos_time`
         LEFT JOIN employee
                   ON emp_pos_time.employee_id = employee.id
         LEFT JOIN salary
                   ON employee.id = salary.employee_id
         LEFT JOIN transport_accounting
                   ON emp_pos_time.id = transport_accounting.employees_position_time_id
WHERE transport_accounting.income IS NOT NULL
   OR transport_accounting.date IS NOT NULL
GROUP BY employee.id
ORDER BY employee_worked_days DESC;

/* Query: get overall (total) income by transport, average income and a number of working days in the descending order. */
SELECT DISTINCT transport.id,
                transport.title                  AS `transport_title`,
                SUM(transport_accounting.income) AS `transport_accounting_income_sum`,
                AVG(transport_accounting.income) AS `transport_accounting_income_avg`,
                COUNT(transport_accounting.date) AS `transport_accounting_date_count`
FROM transport_accounting
         LEFT JOIN transport
                   ON transport_accounting.transport_id = transport.id
GROUP BY transport.id
ORDER BY transport_accounting_date_count DESC;

/* Query: get people who have birthday in May. */
SELECT *
FROM employee
WHERE MONTH(dob) = 5;

/* Query: get a number of years every person works in `CherkasyElektroTrans`
   Add new columns if needed. Create a new database dump when the task is completed. */
SELECT DISTINCT employee.id,
                MIN(emp_pos_time.start_date) AS `first_start_date`,
                MAX(emp_pos_time.end_date) AS `last_end_date`,
                YEAR(MAX(emp_pos_time.end_date))-YEAR(MIN(emp_pos_time.start_date)) AS `employee_expirience_years`
FROM employees_position_time AS `emp_pos_time`
         LEFT JOIN employee
                   ON emp_pos_time.employee_id = employee.id
GROUP BY employee.id
ORDER BY employee_expirience_years DESC;
