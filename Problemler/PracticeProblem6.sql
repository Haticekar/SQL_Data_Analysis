/*
📌 Amaç ne?
Veritabanında kalıcı bir tablo yaratmak.
Yani bu sorgunun sonucu geçici değil, bir tabloya kaydedilmiş oluyor.
*/
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact 
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=3;


SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
LIMIT 10

select job_posted_date from march_jobs