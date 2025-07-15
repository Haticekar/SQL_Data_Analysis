/*
1- Problem Statement
Create a unified query that categorizes job postings into two groups: those with salary
information (salary_year_avg or salary_hour_avg is not null) and those without it.
Each job posting should be listed with its job_id, job_title, and an indicator of
whether salary information is provided.
Hint
-Use UNION ALL to merge results from two separate queries.
    For the first query, filter job postings where either salary field is not null to identify
    postings with salary information.
    For the second query, filter for postings where both salary fields are null to identify
postings without salary information.
-Include a custom field to indicate the presence or absence of salary information in the
output.
-When categorizing data, you can create a custom label directly in your query
using string literals, such as 'With Salary Info' or 'Without Salary Info'.
These literals are manually inserted values that indicate specific characteristics
of each record. An example of this is as a new column in the query that doesn’t have salary information, put: 'Without Salary Info' AS salary_info. As the last column in the SELECT statement.
*/


SELECT
    job_id,
    job_title,
    'With Salary Info' AS salary_info -- -- Custom field indicating salary info presence
FROM job_postings_fact
WHERE
    salary_year_avg IS NOT NULL OR
    salary_hour_avg IS NOT NULL

UNION ALL

SELECT
    job_id,
    job_title,
    'Without Salary Info' AS salary_info -- -- Custom field indicating absence of salary info
FROM job_postings_fact
WHERE
    salary_year_avg IS NULL AND 
    salary_hour_avg IS NULL
ORDER BY
    salary_info DESC,
    job_id

/*
2-Retrieve the job id, job title short, job location, job via, skill and skill type for each job posting from the first quarter (January to March). Using a subquery to combine job postings from the first quarter (these tables were created in the Advanced Section - Practice Problem 6 [include timestamp of Youtube video]) Only include postings with an average yearly salary greater than $70,000.

Hint
Use UNION ALL to combine job postings from January, February, and March into a single dataset.
Apply a LEFT JOIN to include skills information, allowing for job postings without associated skills to be included.
Filter the results to only include job postings with an average yearly salary above $70,000.
*/


SELECT
    quarter.job_id,
    quarter.job_title_short,
    quarter.job_location,
    quarter.job_via,
    skills_dim.skills,
    skills_dim.type

FROM(
    -- where statementler bu query lerin altında yer alıyor 
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS quarter
LEFT JOIN skills_job_dim ON quarter.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE quarter.salary_year_avg > 70000
ORDER BY quarter.job_id

/*
3- Problem Statement
Analyze the monthly demand for skills by counting the number of job postings for
each skill in the first quarter (January to March), utilizing data from separate tables
for each month. Ensure to include skills from all job postings across these months.
The tables for the first quarter job postings were created in Practice Problem 6.

Hint
Use UNION ALL to combine job postings from January, February, and March into a consolidated dataset.
Apply the EXTRACT function to obtain the year and month from job posting dates, even though the month will be implicitly known from the source table.
Group the combined results by skill to summarize the total postings for each skill across the first quarter.
Join with the skills dimension table to match skill IDs with skill names.
*/
-- CTE for combining job postings from January, February, and March
-- CTE for combining job postings from January, February, and March


-- CTE for combining job postings from January, February and March
WITH combined_data AS (
    SELECT job_id, job_posted_date FROM january_jobs 
    UNION ALL
    SELECT job_id, job_posted_date FROM february_jobs
    UNION ALL
    SELECT job_id, job_posted_date FROM march_jobs
),
-- CTE for calculating monthly skill demand based on the combined postings
monthly_skill AS(
    SELECT
        skills_dim.skills,
        EXTRACT(YEAR FROM combined_data.job_posted_date) AS year,
        EXTRACT(MONTH FROM combined_data.job_posted_date) AS month,
        COUNT(combined_data.job_id) AS total
    FROM combined_data
    INNER JOIN skills_job_dim ON combined_data.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        skills_dim.skills,
        year,
        month
)
-- Main query to display the demand for each skill during the first quarter
SELECT 
    skills,
    year,
    month,
    total
FROM monthly_skill
ORDER BY
    skills,
    year,
    month;


/*
SQL’de birden fazla CTE (Common Table Expression) tanımlarken:
Sadece ilkine WITH yazılır.
Sonraki CTE'ler sadece virgül (,) ile ayrılır, ama başlarında
WITH olmaz.
*/



