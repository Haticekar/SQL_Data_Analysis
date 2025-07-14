/*
SELECT
    CASE -- begins the expression 
        WHEN column_name = 'Value1' THEN 'Description for Value1' -- specific conditions 
        WHEN column_name = 'Value2' THEN 'Description for Value2'
        ELSE 'Other' -- optional(provides the output )
    END AS column_description -- case ifadesini tamamlar 
FROM
    table_name;
*/

SELECT
    job_title_short,
    job_location
FROM job_postings_fact;

/*
Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'Local'
- Otherwise 'Onsite'
*/

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

-- group by aggregate function
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
GROUP BY location_category;

-- only data analyts jobs
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;


SELECT
    job_id,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Boston, MA' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

SELECT 
  CASE
	WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'Boston, MA' THEN 'Local'
	ELSE 'Onsite'
  END AS location_category,
  COUNT(job_id) AS number_of_jobs 
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category
ORDER BY    
    number_of_jobs DESC;