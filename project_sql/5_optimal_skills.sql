WITH skills_demand as (
          SELECT 
          skills_dim.skill_id,
           skills_dim.skills,
          COUNT(skills_job_dim.job_id) as demand_count
FROM   job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
          job_title_short = 'Data Analyst' AND
          job_work_from_home = TRUE
          salary_year_avg IS NOT NULL
GROUP BY
          skills_dim.skill_id
),     average_salary as(
          SELECT 
          skills_dim.skill_id,
          round(AVG(salary_year_avg) , 0) as average_salary
          FROM   job_postings_fact
          INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
          INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
          WHERE
          job_title_short = 'Data Analyst' AND
          salary_year_avg IS NOT NULL
          GROUP BY
          skills_dim.skill_id
)
SELECT
          skill_demand.skill_id,
          skill_demand.skills ,
          demand_count,
          average_salary
FROM
          skills_demand
inner JOIN average_salary on skills_demand.skill_id