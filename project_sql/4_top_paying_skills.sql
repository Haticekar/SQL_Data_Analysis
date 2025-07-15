/*
QUESTION: 
What are the top skills based on salary?** 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
    helps identify the most financially rewarding skills to acquire or improve 

Calculates the average salary per skill for Data analyst positions. 

- Aggregates average salary by skill. In the `SELECT` statement: use `skills_dim.skills` to get the skill name and `AVG` to calculate the average yearly salary associated with each skill (`AVG(job_ostings_fact.salary_year_avg)`). It uses `ROUND` to round the average to 2 decimal places.
- Uses `FROM` and `INNER JOIN` between `job_postings_fact`, `skills_job_dim`, and `skills_dim` to correlate job postings with skills.
    - `FROM`: First get the data from the `job_postings_fact` table.
    - First `INNER JOIN`: (`job_postings_fact` and `skills_job_dim`) - link each job IDs with its corresponding skill ID from the `skills_job_dim` table.
    - Second `INNER JOIN`: (result of the first join and `skills_dim`) - result from the first join (which now includes job IDs and skill IDs from `skills_job_dim`) is then joined with the `skills_dim` table using the `skill_id` field to get the skill name.
- It filters jobs (in `WHERE` clause) based on:
    - The job title is 'Data Analyst'
    - A salary exists for the job posting
- Groups by skills (`GROUP BY`).
- Orders by average salary in descending order (`ORDER BY`).

*/

SELECT
    skills_dim.skills AS skill_name,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) AS average_salary
FROM job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skill_name
ORDER BY average_salary DESC
