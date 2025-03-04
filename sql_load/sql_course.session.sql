SELECT
    job_title_short As Title,
    job_location As Location,
    Job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'WAT' As date_time
FROM   
    job_postings_fact
LIMIT
    5;

CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;

select 
    job_title_short,
    job_location,
CASE 
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'local'
    ELSE  'onsite'
END as location_category
FROM
    job_postings_fact
LIMIT 10;


WITH company_job_count AS (
     SELECT
    company_id,
    COUNT (*) as total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id )

SELECT 
    company_dim.name As company_name,
    company_job_count.total_jobs
 FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
     total_jobs ASC

SELECT
    job_id,
    skill_id
FROM
    skills_job_dim

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
