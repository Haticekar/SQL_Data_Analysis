/*
QUESTION:
- Identify the top 10 highest-paying Data Analyst roles that are avaliable remotely.
- Focuses on job postings with specified salaries(remove nulls).
- Why? Highlighting the top-paying opportunities for Data Analyst, offering insights into employement options and location flexibility.
*/

-- join is not necessary but we want to show the highest price in the data analysis the company name we can do the join 
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS comapany_name
FROM job_postings_fact
LEFT JOIN company_dim ON --left table is job_postings_fact
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10




