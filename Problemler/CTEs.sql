/*
1- Identify companies with the most diverse (unique) job titles. Use a CTE to count the number of unique job titles per company, then select companies with the highest diversity in job titles.

Hint
Use a CTE to count the distinct number of job titles for each company.
After identifying the number of unique job titles per company, join this result with the company_dim table to get the company names.
Order your final results by the number of unique job titles in descending order to highlight the companies with the highest diversity.
Limit your results to the top 10 companies. This limit helps focus on the companies with the most significant diversity in job roles. Think about how SQL determines which companies make it into the top 10 when there are ties in the number of unique job titles.
*/

WITH title AS(
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_value
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    company_dim.name,
    title.unique_value
FROM title
INNER JOIN company_dim ON title.company_id = company_dim.company_id
ORDER BY unique_value DESC
LIMIT 10

/*

2- Explore job postings by listing job id, job titles, company names, and their average salary rates, while categorizing these salaries relative to the average in their respective countries. Include the month of the job posted date. Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages.

Hint
Define a CTE to calculate the average salary for each country. This will serve as a foundational dataset for comparison.
Within the main query, use a CASE WHEN statement to categorize each salary as 'Above Average' or 'Below Average' based on its comparison (>) to the country's average salary calculated in the CTE.
To include the month of the job posting, use the EXTRACT function on the job posting date within your SELECT statement.
Join the job postings data (job_postings_fact) with the CTE to compare individual salaries to the average. Additionally, join with the company dimension (company_dim) table to get company names linked to each job posting.
*/

/*
Problem Amacı: 
Her iş ilanı için:
job_id, job_title, company_name, salary_year_avg
Maaşının ülkesinin ortalama maaşına göre Above/Below Salary olup olmadığını yaz
Ve iş ilanının yayınlandığı ayı göster
*/


WITH calculate_avg AS (
    SELECT
        job_country,
        AVG(job_postings_fact.salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY job_country
)
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
    company_dim.name,
    CASE
        WHEN job_postings_fact.salary_year_avg > calculate_avg.avg_salary THEN 'Below Salary'
        ELSE 'Above Salary'
    END AS country_categorize,
     EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS months
FROM job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id -- Amaç: Şirketin adını almak. Yani bu şekilde her ilana karşılık şirket adını görebiliriz.
INNER JOIN calculate_avg ON job_postings_fact.job_country = calculate_avg.job_country -- Amaç:  Ülkenin ortalama maaşını bulmak. Burda bu şekilde ilan maaşını, ülke ortalamasıyla kıyaslayabiliriz.
ORDER BY months DESC
LIMIT 30;

/*
Calculate the number of unique skills required by each company. Aim to quantify the unique skills required per company and identify which of these companies offer the highest average salary for positions necessitating at least one skill. For entities without skill-related job postings, list it as a zero skill requirement and a null salary. Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.


Use two CTEs:
The first should focus on counting the unique skills required by each company.
The second CTE should aim to find the highest average salary offered by these companies.
Ensure the final output includes companies without skill-related job postings. This involves use of LEFT JOINs to maintain companies in the result set even if they don't match criteria in the subsequent CTEs.
After creating the CTEs, the main query joins the company dimension table with the results of both CTEs.
*/

WITH required_skills AS( --Her şirketin iş ilanlarında geçen farklı skill_id sayısını buluyoruz.
    SELECT
        companies.company_id,
        COUNT(DISTINCT skills_job_dim.skill_id) AS unique_skills
    FROM company_dim AS companies
    -- Neden LEFT JOIN? Çünkü bazı şirketlerin hiç iş ilanı olmayabilir veya hiç skill içermeyen ilanları olabilir. Onları da kaybetmek istemiyoruz.
    LEFT JOIN job_postings_fact ON companies.company_id = job_postings_fact.company_id
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY companies.company_id
),
max_salary AS( -- Skill içeren işler için her şirketin en yüksek maaşını buluyoruz.
    SELECT
        job_postings_fact.company_id,
        MAX(job_postings_fact.salary_year_avg) AS highest_salary
    FROM job_postings_fact
    WHERE job_postings_fact.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY job_postings_fact.company_id
)


SELECT
    companies.name,
    required_skills.unique_skills,
    max_salary.highest_salary
FROM company_dim AS companies
LEFT JOIN --  LEFT JOIN sayesinde tüm şirketleri görüyoruz — skill olmayanlara da 0 ve NULL yazıyor.
    required_skills ON companies.company_id = required_skills.company_id
LEFT JOIN
    max_salary ON companies.company_id = max_salary.company_id
ORDER BY companies.name

/*
Her şirket için şunları bulmak istiyoruz:

Kaç farklı beceri (skill) istiyorlar? (Yani iş ilanlarında geçen farklı skill_id sayısı)
En yüksek ortalama maaş nedir? (Yani beceri isteyen işler arasında en yüksek salary_year_avg)
Eğer bir şirket hiç beceri istemiyorsa → o şirket yine de listede 0 skill ve NULL maaş ile yer alsın.


company_dim → şirketlerin bilgisi (isim vs.)
job_postings_fact → her iş ilanı (hangi şirkete ait, maaş bilgisi vs.)
skills_job_dim → her iş ilanı için hangi beceriler gerekiyor (job_id – skill_id)

*/