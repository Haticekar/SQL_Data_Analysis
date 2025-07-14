/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name and count of postings requiring the skill.
*/

/*
💡**Solution:**

- `remote_job_skills` CTE counts how many times each skill is associated with a remote job posting from the `job_postings` table
- The main query joins CTE with the `skills` table to get the actual skill names associated with each `skill_id`
- The result is ordered by the `skill_count` from the largest amount of skills to the least
- Use `LIMIT`; we only get the top 5 skills
-
*/

--1
SELECT
    job_id,
    skill_id
FROM
    skills_job_dim AS skills_to_job


--2
SELECT
    job_postings.job_id,
    skill_id
FROM
    skills_job_dim AS skills_to_job
INNER JOIN
    job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id


--3
SELECT 
    job_postings.job_id,
    skill_id,
    job_postings.job_work_from_home
FROM 
    skills_job_dim AS skills_to_job
INNER JOIN
    job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE


--4
SELECT 
    job_postings.job_id,
    skill_id
FROM 
    skills_job_dim AS skills_to_job
INNER JOIN
    job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE


--5
SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM skills_job_dim AS skills_to_job
INNER JOIN
    job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE
GROUP BY skill_id


--6
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = TRUE
    GROUP BY skill_id
)
SELECT * FROM remote_job_skills


--7 
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = TRUE
    GROUP BY skill_id
)
SELECT * FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id


--8
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = TRUE
    GROUP BY skill_id
)
SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5 


--9 EXTRA 
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5