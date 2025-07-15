/*
QUESTION:
**What are the most in-demand skills for data analysts?**

- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.

Identifies the top 5 most demanded skills by counting instances across all jobs postings.

- Counts occurrences of each skill using `COUNT` and get the actual skill `skills`. Both in the `SELECT` statement.
- Uses `FROM` and `INNER JOIN` between `job_postings_fact`, `skills_job_dim`, and `skills_dim` to correlate job postings with skills.
    - `FROM`: First get data from the `job_postings_fact` table.
    - First `INNER JOIN`: (`job_postings_fact` and `skills_job_dim`) - link each job IDs with its corresponding skill ID from the `skills_job_dim` table.
    - Second `INNER JOIN`: (result of the first join and `skills_dim`) - result from the first join (which now includes job IDs and skill IDs from `skills_job_dim`) is then joined with the `skills_dim` table using the `skill_id` field to get the skill name.
- `WHERE` clause filters job titles for ‘Data Analyst’ roles (using `job_title_short`).
- Groups by skill associate with a job posting  (`GROUP BY`).
- Orders by demand aka the count in descending order (`ORDER BY`).
- Limits to top 5 skills (`LIMIT`).
*/

SELECT
    --job_postings_fact.job_id
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS total  
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst' AND
    job_work_from_home = True -- this is adding optional
GROUP BY skills_dim.skills
ORDER BY total DESC
LIMIT 5