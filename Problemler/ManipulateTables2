
/*
Problem Statement
Modify the remote column so that it defaults to FALSE
 in the data_science_job table.
Hint
Use the SET DEFAULT command.
Note
This will not display any results with the SET DEFAULT command.
Additionally, it won’t change the existing rows.
However, if you insert a new row, it will.
Insert this new row after modifying the remote column:
*/
ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;

INSERt INTO data_science_jobs (
    job_id,
    job_title,
    company_name,
    posted_on
)
VALUES (
    4,
    'Data Scientist',
    'Google',
    '2023-02-05'
);
SELECT * FROM data_science_jobs

/* DROP COLUMN - delete a column
ALTER TABLE table_name
DROP COLUMN column_name;*/
ALTER TABLE data_science_jobs
DROP COLUMN company_name;
SELECT * FROM data_science_jobs

/*
## `UPDATE`
📝 **Notes:**
- **`UPDATE`** - used to modify existing data in a table.
- **`SET`** - specifies the column to be updated and the new value for that column.
- **`WHERE`** - filters which rows to update based on a condition.
*/
/*
UPDATE table_name
SET column_name = 'new_value'
WHERE condition;
*/
UPDATE data_science_jobs
SET remote = TRUE
WHERE job_id = 2

SELECT * FROM data_science_jobs

/*
DROP TABLE job_applied;
*/
DROP TABLE data_science_jobs