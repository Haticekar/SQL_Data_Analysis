/*
Find job postings from the first quarter that have a salary greater than $70k. 
- Combine job postings tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary  > $70,000
- ⚠️ Note:
    - Alias is necessary because it will return an error without it. It’s needed for
    subqueries in the FROM clause.
*/

--1
SELECT * FROM january_jobs
UNION ALL
SELECT * FROM february_jobs
UNION ALL
SELECT * FROM march_jobs

--2
SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date :: DATE
FROM(
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS quarter1_job_postings


--3
SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date :: DATE
FROM(
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg > 70000


--4
SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date :: DATE,
    quarter1_job_postings.salary_year_avg
FROM(
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg > 70000 AND 
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC


--4.1
SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date :: DATE,
    salary_year_avg
FROM(
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS quarter1_job_postings
WHERE salary_year_avg > 70000 AND 
    job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
