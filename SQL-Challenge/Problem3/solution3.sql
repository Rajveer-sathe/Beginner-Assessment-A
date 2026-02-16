select * from student_marks;

SELECT TEST_ID, MARKS
FROM (
    SELECT 
        TEST_ID,
        MARKS,
        LAG(MARKS, 1, 0) OVER (ORDER BY TEST_ID) AS prev_marks
    FROM student_marks
) t
WHERE MARKS > prev_marks;

SELECT TEST_ID, MARKS
FROM (
    SELECT 
        TEST_ID,
        MARKS,
        LAG(MARKS) OVER (ORDER BY TEST_ID) AS prev_marks
    FROM student_marks
) t
WHERE MARKS > prev_marks;
