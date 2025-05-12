/*
Question 2: What are the skills required for top-paying data engineer jobs?
- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer' AND
        job_location IN ('Singapore', 'Japan') AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY -- best practices on organising the data
    salary_year_avg DESC

/*
Based on job postings from 2023, here is the breakdown of most mentioned skills for data engineering positions:
SQL – 8 mentions
Hadoop – 7 mentions
AWS – 7 mentions
Python – 7 mentions
Spark – 6 mentions
Azure – 5 mentions
Other skills such as Redshift, Unix, Java, and GCP are showing vary degrees of demand

[
  {
    "job_id": 424001,
    "job_title": "Data Engineer",
    "salary_year_avg": "155500.0",
    "company_name": "Match Group",
    "skills": "dynamodb"
  },
  {
    "job_id": 424001,
    "job_title": "Data Engineer",
    "salary_year_avg": "155500.0",
    "company_name": "Match Group",
    "skills": "bigquery"
  },
  {
    "job_id": 424001,
    "job_title": "Data Engineer",
    "salary_year_avg": "155500.0",
    "company_name": "Match Group",
    "skills": "aurora"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "sql"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "azure"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "snowflake"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "spark"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "hadoop"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "tableau"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "power bi"
  },
  {
    "job_id": 91991,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "flow"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "sql"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "python"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "java"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "cassandra"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "azure"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "aws"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "gcp"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "spark"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "airflow"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "hadoop"
  },
  {
    "job_id": 622933,
    "job_title": "Software Engineer, Data Engineering",
    "salary_year_avg": "147500.0",
    "company_name": "Appier",
    "skills": "github"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "sql"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "python"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "scala"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "java"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "shell"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "spark"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "hadoop"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "linux"
  },
  {
    "job_id": 423928,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Lynx Analytics",
    "skills": "sap"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "python"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "scala"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "ruby"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "aws"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "redshift"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "hadoop"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "ruby"
  },
  {
    "job_id": 815410,
    "job_title": "Data Engineer - Global Accounts, Professional Services",
    "salary_year_avg": "147500.0",
    "company_name": "Amazon.com",
    "skills": "unix"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "sql"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "python"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "shell"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "dynamodb"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "aws"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "redshift"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "spark"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "pandas"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "numpy"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "hadoop"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "kafka"
  },
  {
    "job_id": 284605,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Biofourmis",
    "skills": "unix"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "sql"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "python"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "go"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "aws"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "redshift"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "snowflake"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "airflow"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "tableau"
  },
  {
    "job_id": 855635,
    "job_title": "Data Engineering Lead",
    "salary_year_avg": "147500.0",
    "company_name": "ExpressVPN",
    "skills": "terraform"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "sql"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "python"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "nosql"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "azure"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "aws"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "spark"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "hadoop"
  },
  {
    "job_id": 154770,
    "job_title": "Data Engineer",
    "salary_year_avg": "147500.0",
    "company_name": "Unison Consulting Pte Ltd",
    "skills": "flow"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "sql"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "python"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "r"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "azure"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "aws"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "gcp"
  },
  {
    "job_id": 1100937,
    "job_title": "Data Engineer",
    "salary_year_avg": "98301.5",
    "company_name": "Publicis Groupe",
    "skills": "spark"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "sql"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "nosql"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "java"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "mongodb"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "mongodb"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "azure"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "aws"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "oracle"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "hadoop"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "unix"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "linux"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "windows"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "sap"
  },
  {
    "job_id": 92997,
    "job_title": "Data Engineer / Support Engineer",
    "salary_year_avg": "98283.0",
    "company_name": "Denodo Technologies",
    "skills": "git"
  }
]

*/