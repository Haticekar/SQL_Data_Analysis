/*
QUESTION:
**What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst?** 

- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis

**🖥️ Query:**

- CTE `skills_demand` - identifies skills in demand for Data Analyst roles (aggregates count by skill):
    - This is similar to Query #3.
    - In the `SELECT` statement it gets:
        - `skill_id` for the id of the skill
        - `skills` for skill name
        - Counts job (`job_id`) using `COUNT`.
    - Uses `FROM` and `INNER JOIN` to match `job_postings_fact` with `skills_dim` through `skills_job_dim`, to link job postings with the required skills.
        - `FROM`: First get the data from the `job_postings_fact` table.
        - First `INNER JOIN`: (`job_postings_fact` and `skills_job_dim`) - link each job IDs with its corresponding skill ID from the `skills_job_dim` table.
        - Second `INNER JOIN`: (result of the first join and `skills_dim`) - result from the first join (which now includes job IDs and skill IDs from `skills_job_dim`) is then joined with the `skills_dim` table using the `skill_id` field to get the skill name
    -
- Filters in the `WHERE` clause:
    - 'Data Analyst' positions
    - with specified salaries,
    - that are remote
- Groups by skill ID (`GROUP BY`).
- CTE `average_salary` - calculates the average salary per skill for Data Analyst roles (aggregates average salary by skill):
    - This is similar to Query #4.
    - In `SELECT` statement it:
        - Gets `skill_id`
        - Average salary (`salary_year_avg`) using `AVG`.
    - Uses `FROM` and `INNER JOIN` to link job postings to skills.
        - `FROM:` We’ll be first grabbing data from the `job_postings_fact` table.
        - `INNER JOIN`: (`job_postings_fact` and `skills_job_dim`) - link each job IDs with its corresponding skill ID from the `skills_job_dim` table.
    - Filters in the `WHERE` clause:
        - 'Data Analyst' positions
        - with specified salaries,
        - that are remote.
    - Groups by skill ID (`GROUP BY`).

*/

WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND 
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_work_from_home = True
    GROUP BY skills_dim.skill_id
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        AVG(job_postings_fact.salary_year_avg) AS avg_salary
    FROM job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    -- There's no INNER JOIN to skills_dim because we got rid of the skills_dim.name 
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_work_from_home = True 
    GROUP BY skills_job_dim.skill_id
)

SELECT
    skills_demand.skills,
    skills_demand.demand_count,
    ROUND(average_salary.avg_salary,2) AS avg_salary
FROM skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25