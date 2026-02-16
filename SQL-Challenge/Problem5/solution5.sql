SELECT
    ROW_ID,
    MAX(JOB_ROLE) OVER (
        ORDER BY ROW_ID
        
    ) AS JOB_ROLE,
    SKILLS
FROM job_skills;  
