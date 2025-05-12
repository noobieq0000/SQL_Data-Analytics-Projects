/*
Question 3: What are the most in-demand skills for data engineer?
- Identify the top 5 most in-demand skills for data engineer roles.
- Focus on job postings within Singapore and Japan.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers. 
*/

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS job_count
FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Engineer' AND
    job_postings_fact.job_location IN ('Singapore', 'Japan') 
GROUP BY
    skills_dim.skills
ORDER BY
    job_count DESC
LIMIT 5
