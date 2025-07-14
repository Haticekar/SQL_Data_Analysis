/*
Combine result sets of two or more `SELECT` statements into a single result set. 
- `UNION`: Remove duplicate rows
- `UNION ALL`: Includes all duplicate rows
*/

/*
- `UNION` - combines results from two or more `SELECT` statements
- They need to have the same amount of columns, and the data type must match
SELECT column_name
FROM table_one
UNION -- combine the two tables 
SELECT column_name
FROM table_two;
*/

SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION 

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs

/*
- `UNION ALL` - combine the result of two or more SELECT statements
- They need to have the same amount of columns, and the data type must match

SELECT column_name
FROM table_one
UNION ALL -- combine the two tables 
SELECT column_name
FROM table_two;
*/

SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs


/*
UNION
Tekrarlı (duplicate) satırları otomatik olarak kaldırır.
Her satırın benzersiz olmasını sağlar.
Bu nedenle daha yavaş çalışabilir, çünkü verileri karşılaştırmak ve tekrarları elemek için ekstra işlem yapar.

UNION ALL
Tüm satırları getirir, tekrarları da dahil eder.
Bu nedenle daha hızlıdır çünkü tekrar kontrolü yapılmaz.
*/