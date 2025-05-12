/*
Question 4: What are the top skills based on salary? 
- Look at the average salary associated with each skill for Data Engineer positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Engineers and 
helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary -- Round to nearest integer
FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL AND 
    job_postings_fact.job_location IN ('Singapore', 'Japan')
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*

Here’s a concise summary in 3 bullet points:
- Cloud-native tools like Aurora, BigQuery, and DynamoDB offer the highest salaries, reflecting strong demand for specialized cloud skills.
- Data visualization and scripting tools (e.g., Tableau, Power BI, Pandas, Terraform) are surprisingly lucrative, showing value in end-to-end data handling.
- Core skills like SQL, Python, and Java, while essential, command slightly lower salaries due to widespread availability.

[
  {
    "skills": "aurora",
    "avg_salary": "155500"
  },
  {
    "skills": "bigquery",
    "avg_salary": "155500"
  },
  {
    "skills": "dynamodb",
    "avg_salary": "151500"
  },
  {
    "skills": "snowflake",
    "avg_salary": "147500"
  },
  {
    "skills": "tableau",
    "avg_salary": "147500"
  },
  {
    "skills": "cassandra",
    "avg_salary": "147500"
  },
  {
    "skills": "flow",
    "avg_salary": "147500"
  },
  {
    "skills": "github",
    "avg_salary": "147500"
  },
  {
    "skills": "go",
    "avg_salary": "147500"
  },
  {
    "skills": "kafka",
    "avg_salary": "147500"
  },
  {
    "skills": "numpy",
    "avg_salary": "147500"
  },
  {
    "skills": "pandas",
    "avg_salary": "147500"
  },
  {
    "skills": "power bi",
    "avg_salary": "147500"
  },
  {
    "skills": "redshift",
    "avg_salary": "147500"
  },
  {
    "skills": "ruby",
    "avg_salary": "147500"
  },
  {
    "skills": "scala",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "147500"
  },
  {
    "skills": "shell",
    "avg_salary": "147500"
  },
  {
    "skills": "hadoop",
    "avg_salary": "140469"
  },
  {
    "skills": "spark",
    "avg_salary": "139300"
  },
  {
    "skills": "unix",
    "avg_salary": "131094"
  },
  {
    "skills": "java",
    "avg_salary": "131094"
  },
  {
    "skills": "python",
    "avg_salary": "130761"
  },
  {
    "skills": "airflow",
    "avg_salary": "130591"
  },
  {
    "skills": "sql",
    "avg_salary": "124719"
  }
]
*/