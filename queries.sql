/* Query: get a list of all employees, ordered by last name. */
SELECT *
FROM employee
ORDER BY lastname;

/* Query: get average salary by employee. */
SELECT e.name,
       e.id,
       AVG(s.amount) AS `average_salary`
FROM employee AS e
         INNER JOIN salary AS s
                    ON e.id = s.employee_id
GROUP BY e.id
ORDER BY `average_salary`;

/* Query: get average and highest salary by position. */
SELECT p.title,
       MAX(e.wage) AS `position_salary_max`,
       AVG(e.wage) AS `position_salary_avg`
FROM employee AS e
         INNER JOIN employees_position_time AS ept
                    ON e.id = ept.employee_id
         INNER JOIN position AS p
                    ON ept.position_id = p.id
GROUP BY p.title;

/* Query: get total number of days every person worked and total income. */
SELECT e.id           AS `employee_id`,
       e.name         AS `employee_name`,
       e.lastname     AS `employee_lastname`,
       COUNT(ta.date) AS `employee_worked_days`,
       SUM(ta.income) AS `employee_sum_income`
FROM employee AS `e`
         INNER JOIN transport_accounting AS `ta`
                    ON e.id = ta.employee_id
GROUP BY e.id
ORDER BY employee_worked_days DESC;

/* Query: get overall (total) income by transport, average income and a number of working days in the descending order. */
SELECT t.id,
       t.title        AS `transport_title`,
       SUM(ta.income) AS `transport_accounting_income_sum`,
       AVG(ta.income) AS `transport_accounting_income_avg`,
       COUNT(ta.date) AS `transport_accounting_date_count`
FROM transport_accounting AS `ta`
         LEFT JOIN transport AS `t`
                   ON ta.transport_id = t.id
GROUP BY t.id
ORDER BY transport_accounting_income_sum DESC;

/* Query: get people who have birthday in May. */
SELECT *
FROM employee
WHERE MONTH(dob) = 5;

/* Query: get a number of years every person works in `CherkasyElektroTrans`
   Add new columns if needed. Create a new database dump when the task is completed. */
SELECT e.id,
       MIN(ept.start_date)                  AS `first_start_date`,
       IFNULL(MAX(ept.end_date), '' - '')   AS `last_end_date`,
       YEAR(IFNULL(MAX(ept.end_date), CURRENT_TIMESTAMP)) -
       IFNULL(YEAR(MIN(ept.start_date)), 0) AS `employee_expirience_years`
FROM employees_position_time AS `ept`
         LEFT JOIN employee AS `e`
                   ON ept.employee_id = e.id
GROUP BY e.id
ORDER BY employee_expirience_years DESC;