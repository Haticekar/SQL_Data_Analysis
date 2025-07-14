/*
**Subqueries** and **Common Table Expressions** (CTEs): Used for organizing and simplifying complex queries.

- Helps break down the query into smaller, more manageable parts
- When to use one over the other?
    - **Subqueries** are for simpler queries
    - **CTEs** are for more complex queries
*/

/* SubQuery Definition
SELECT *
FROM ( -- SubQuery starts here
   SELECT *
   FROM job_postings_fact
   WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here       
*/

/*CTE definition 
WITH january_jobs AS ( -- CTE definition starts here
	  SELECT *
	  FROM job_postings_fact
	  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
FROM january_jobs;
*/

SELECT *
FROM( -- SubQuery starts here 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
) AS january_jobs;
-- SubQuery ends here 

WITH january_jobs AS ( -- CTE definition starts here 
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)-- CTE definition ends here
SELECT * FROM january_jobs;

SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention=true
    ORDER BY company_id
);

/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id
- Return the total number of jobs with the company name
*/
--1
WITH company_job_count AS (
    -- this is core statement using be inside our CTE
    SELECT 
        company_id,
        COUNT(*)
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT * FROM company_job_count

--2
WITH company_job_count AS (
    -- this is core statement using be inside our CTE
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC 