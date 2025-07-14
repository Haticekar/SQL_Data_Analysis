/*
`job_posted_date`
The timestamp **`YYYY-MM-DD HH:MM:SS`** of when a job was posted in UTC
*/
SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT '2023-02-19';

SELECT '2023-02-19' :: DATE;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date
FROM job_postings_fact

-- artık saat verileri yok.sadece date verileri var 
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date :: DATE AS date
FROM job_postings_fact

/*
Bu şu demek:
Veritabanındaki job_posted_date değerini UTC olarak kabul et.
Sonra bu saati EST saatine çevir.
UTC olan tarihi alıyor.
EST’ye çeviriyor.
Sonuç olarak sana EST saat diliminde bir tarih gösteriyor.
*/
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 10;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Istanbul' AS date_time
FROM job_postings_fact
LIMIT 10;

/*
Bu ne yapıyor?
📌 job_posted_date kolonundaki tarihin sadece ay (MONTH)
 kısmını alıyor.
Örneğin:
Eğer tarih 2025-07-07 15:00:00 ise → EXTRACT(MONTH FROM ...) sonucu 7 olur.
*/

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM job_postings_fact
LIMIT 10;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(DAY FROM job_posted_date) AS date_month
FROM job_postings_fact
LIMIT 10;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(YEAR FROM job_posted_date) AS date_month
FROM job_postings_fact
LIMIT 10;

SELECT
    job_id,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
LIMIT 5

-- different job_id for each month
SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
     job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_posted_count DESC
LIMIT 12; 