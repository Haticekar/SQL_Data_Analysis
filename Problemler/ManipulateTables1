/*
    CREATE TABLE table_name (
    column_name datatype,
    column_name2 datatype,
   ....
);
*/
CREATE TABLE data_science_jobs(
    job_id INT PRIMARY KEY,
    job_title TEXT,
    company_name TEXT,
    post_date DATE
);
SELECT * FROM data_science_jobs

/*
INSERT INTO table_name (column_name, column_name2, ...)
VALUES (value1, value2, ...);
*/
INSERT INTO data_science_jobs(
    job_id,
    job_title,
    company_name,
    post_date
)
VALUES(
    1,
    'Data Scientist',
    'Tech Innovations',
    'January 1, 2023'
),
(
    2,
    'Machine Learning Engineer',
    'Data Driven Co',
    'January 15, 2023'
),
(
    3,
    'AI Specialist',
    'Future Tech',
    'February 1, 2023'
);
SELECT * FROM data_science_jobs

/*
ALTER TABLE table_name
-- ADD column_name datatype;
-- RENAME COLUMN column_name TO new_name;
-- ALTER COLUMN column_name TYPE datatype;
-- DROP COLUMN column_name;
*/

/*
ALTER TABLE job_applied
ADD contact VARCHAR(50);
*/
ALTER TABLE data_science_jobs
ADD COLUMN remote BOOLEAN

select * from data_science_jobs

/*
ALTER TABLE table_name
RENAME COLUMN column_name TO new_name;
*/
ALTER TABLE data_science_jobs
RENAME COLUMN post_date TO posted_on 

select * from data_science_jobs