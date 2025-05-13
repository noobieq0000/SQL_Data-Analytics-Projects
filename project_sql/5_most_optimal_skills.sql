/*
Question 5: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data Engineer? 
- Identify skills in high demand and associated with high average salaries for Data Engineer roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data engineering.
*/


-- Use modified query #3 
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
		skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
	  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Engineer' AND 
    job_postings_fact.salary_year_avg IS NOT NULL AND 
    job_postings_fact.job_work_from_home = True
  GROUP BY
    skills_dim.skill_id
),
-- Use modified query #4 
average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
	  INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	  -- There's no INNER JOIN to skills_dim because we got rid of the skills_dim.name 
  WHERE
    job_postings_fact.job_title_short = 'Data Engineer' AND 
    job_postings_fact.salary_year_avg IS NOT NULL AND 
    job_postings_fact.job_work_from_home = True
  GROUP BY
    skills_job_dim.skill_id
)
-- Combine the two CTEs to get the most optimal skills
-- Use Query #3 and Query #4
SELECT
  skills_demand.skills,
  skills_demand.demand_count,
  ROUND(average_salary.avg_salary, 0) AS avg_salary --ROUND to nearest integer 
FROM
  skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
  avg_salary DESC,
  demand_count DESC 
LIMIT 25 
 




