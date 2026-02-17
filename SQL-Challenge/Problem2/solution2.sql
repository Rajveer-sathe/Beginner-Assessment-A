SELECT 
    s.emp_name AS EMPLOYEE,

    -- Income
    (SELECT s.base_salary * percentage/100 FROM income WHERE income='Basic') AS BASIC,
    (SELECT s.base_salary * percentage/100 FROM income WHERE income='Allowance') AS ALLOWANCE,
    (SELECT s.base_salary * percentage/100 FROM income WHERE income='Others') AS OTHERS,

    -- Gross
    (SELECT SUM(s.base_salary * percentage/100) FROM income) AS GROSS,

    -- Deductions
    (SELECT s.base_salary * percentage/100 FROM deduction WHERE deduction='Insurance') AS INSURANCE,
    (SELECT s.base_salary * percentage/100 FROM deduction WHERE deduction='Health') AS HEALTH,
    (SELECT s.base_salary * percentage/100 FROM deduction WHERE deduction='House') AS HOUSE,

    -- Total Deduction
    (SELECT SUM(s.base_salary * percentage/100) FROM deduction) AS TOTAL_DEDUCTIONS,

    -- Net Pay
    (SELECT SUM(s.base_salary * percentage/100) FROM income) -
    (SELECT SUM(s.base_salary * percentage/100) FROM deduction) AS NET_PAY

FROM salary s
ORDER BY s.emp_name;
