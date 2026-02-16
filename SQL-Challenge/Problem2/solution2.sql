WITH income_calc AS (
    SELECT 
        s.emp_id,
        s.emp_name,
        i.income,
        (s.base_salary * i.percentage / 100) AS amount
    FROM salary s
    CROSS JOIN income i
),
deduction_calc AS (
    SELECT 
        s.emp_id,
        s.emp_name,
        d.deduction,
        (s.base_salary * d.percentage / 100) AS amount
    FROM salary s
    CROSS JOIN deduction d
)

SELECT 
    s.emp_name AS EMPLOYEE,

    -- Income Pivot
    MAX(CASE WHEN ic.income = 'Basic' THEN ic.amount END) AS BASIC,
    MAX(CASE WHEN ic.income = 'Allowance' THEN ic.amount END) AS ALLOWANCE,
    MAX(CASE WHEN ic.income = 'Others' THEN ic.amount END) AS OTHERS,

    -- Gross Salary
    SUM(ic.amount) AS GROSS,

    -- Deduction Pivot
    MAX(CASE WHEN dc.deduction = 'Insurance' THEN dc.amount END) AS INSURANCE,
    MAX(CASE WHEN dc.deduction = 'Health' THEN dc.amount END) AS HEALTH,
    MAX(CASE WHEN dc.deduction = 'House' THEN dc.amount END) AS HOUSE,

    -- Total Deductions
    SUM(dc.amount) AS TOTAL_DEDUCTIONS,

    -- Net Pay
    SUM(ic.amount) - SUM(dc.amount) AS NET_PAY

FROM salary s
JOIN income_calc ic ON s.emp_id = ic.emp_id
JOIN deduction_calc dc ON s.emp_id = dc.emp_id

GROUP BY s.emp_id, s.emp_name
ORDER BY s.emp_name;
