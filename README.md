# Introduction 
Diving into the data engineering job market in Japan and Singapore
📈. This project explores top-paying jobs , in-demand skills, and where the high demands meeting high salary in data engineering. 💰

🔍 Check out the SQL queries here: [project_sql folder](/project_sql/)

# Background
The motivation behind this project stemmed from my desire to enhance my SQL fundamentals and database skills while gaining a deeper understanding of the data engineering job landscape in Japan and Singapore. My goal was to identify which skills offer both high compensation and demand, making my job search more focused and informed.

The data for this analysis is from Luke Barousse's [SQL Course](https://lukebarousse.com/sql). The data includes details on job titles, salaries, locations, and required skillset. 

Questions behind the project to answer through my SQL queries were: 
1. What are the highest-paying data engineer jobs? 
2. What are the required skills for top-paying data engineer jobs?
3. What are the most in-demand skills for data engineer?
4. What are the lowest paying job based on skills?
5. What are the most optimal skills to learn?

# Tools I Used
To deep dive into the data engineering job market, I have harnessed the power of several key tools: 
- **SQL**: Backbone of my analysis allowing me to query the database and extract insights.
- **PostgreSQL**: Chosen database management system for heandling job posting data. 
- **Visual Studio Code**: For database management and executing SQL queries. 
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis for collaboration and project tracking. 

# Analysis 
Each of the query in this project aimed at gaining specific aspects of the data engineering job market in Singapore and Japan.
Here is how I approached each question: 
### 1. Top Paying Data Companies for Data Engineering
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
```
Breakdown of the top data engineering jobs in 2023 (Japan & Singapore):
- **Wide Salary Range**: Top 10 paying data engineering roles span from $98283 to $155,500 indicating salary potential in the field. 
- **Diverse Employers**: Companies such as Match Group, Amazon, Appier and ExpressVPN are among those offering high salaries showing broad interest across different industries. 
![Top Paying Salary](<top paying data enginerring.jpg>)
*Box plot chart visualizing the top 10 salary and companies for Data Engineer; ChatGPT generated this graph from my SQL query results* 

### 2. Skills for Top Paying Job in Data Engineering
I have joined job postings with the skills data that provide insights into what employers value for high-compensation roles which help to understand what is the required skills for the top-paying jobs in Japan and Singapore market. 

```sql
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
```
Here is the breakdown of the most highest paid skills for data engineering positions: 
- **Aurora & BigQuery**: $155,500
- **DynamoDB**: $151,500
- Other skills like **Snowflake, Tableau, Github and Kafka** is at average salary of $147,500 
![alt text](<top paying job skill.jpg>)
*The chart visualizing the top 10 highest paid skills for Data Engineer in JP & SGP; ChatGPT generated this graph from my SQL query results* 

### 3. Top Demanded Skill in Data Engineering
The query identifies the most frequently requested skills in job postings, helping to highlight areas with the highest demand in the data engineering job market.
```sql
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
```
Breakdown of most demanded skills for data engineer in 2023: 
- **SQL** with a count of 3263: Critical for querying and data management.
- **Python** with a count of 3229: Backbone programming for data engineering.
- **Hadoop/AWS** with a count of 1978: Highlighting their role of programming, big data and cloud skills.
- **Spark** with a count of 1978: a key big data tool 

![alt text](<top demanded skill.jpg>)
*The chart visualizing the top 15 most demanded for Data Engineer; GrokAI generated this graph from my SQL query results* 

### 4. Lowest Paying Job in Data Engineering
Exploring average salaries associated with different skills revealing which skills are the lowest paying.

```sql
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
```
Here is the breakdown of the results for lowest paying skills for Data Engineer: 
- High Supply, Lower Pay: **SQL/Python** are foundational and widely known; the lower average salaries reflect market saturation rather than low importance which they are essential but commoditized skills in the job market. 
- General-purpose Tools vs. Specialized Platforms: **Airflow/Unix** skillset are crucial for data pipeline management and deployment but they are treated as supporting tools rather than core differentiators leading to lower salary influence. 

![alt text](<lowest paying job.jpg>)
*The chart visualizing the top 5 lowest salary for Data Engineer; GrokAI generated this graph from my SQL query results* 

### 5. Most Optimal Skills to Learn in Data Engineering
By integrating demand and salary data, this query sought to identify skills that are both highly sought-after and well-compensated, guiding targeted skill development.

| Skill             | Demand Count | Avg. Salary (USD) | Insight                                                                          |
| ----------------- | ------------ | ----------------- | -------------------------------------------------------------------------------- |
| **Kubernetes**    | 56           | **\$158,190**     | High salary + solid demand. Strong pick for cloud-native orchestration.          |
| **Kafka**         | **134**      | \$150,549         | Extremely in-demand and well-paid; a key tool for real-time data streaming.      |
| **Scala**         | 113          | \$141,777         | High demand & strong salary. Valuable for Spark and big data ecosystems.         |
| **Airflow**       | 151          | \$138,518         | One of the **most in-demand** orchestration tools. Core for pipeline automation. |
| **Spark**         | **237**      | \$139,838         | Highest demand in the list. Critical for large-scale data processing.            |
| **Terraform**     | 44           | \$146,057         | Solid infrastructure-as-code skill with rising importance.                       |
| **Pandas**        | 38           | \$144,656         | Core tool in data manipulation. High salary despite moderate demand.             |
| **Java**          | 139          | \$138,087         | Still essential for many enterprise and performance-focused systems.             |
| **DynamoDB**      | 27           | \$138,883         | Niche AWS NoSQL skill with solid salary.                                         |
| **Elasticsearch** | 21           | \$144,102         | Great for search and analytics pipelines. High-paying, specialized role.         |

*Table of most optimal skills for data engineer* 
# What I Learned 

### Insights
Throughout this project, I have learned several key SQL techniques and skills:
- 🔧**Complex Query Crafting**: Develop my ability in writing advanced SQL queries that join mulitple tables and ultilsing features like **WITH** clauses to create temporary result sets. 
- 📊**Data Aggregation**: Summarizing data effectively by utilizing **GROUP BY** and aggregate function like **COUNT()** and **AVG()**. 
- 💡**Analytical Thinking**: Building the skill to translate real-world problems into actionable SQL queries that generate meaningful insights.
# Conclusion 
Several insights emerged from the analysis: 
1. **Cloud and big data skills dominate**: Tools like Kubernetes, Kafka, Spark, and Airflow consistently appear in high-paying and high-demand roles, highlighting the shift toward cloud-native and scalable data infrastructure.
2. **Foundational skills are essential but saturated**: SQL and Python are required in nearly every job but offer lower salary leverage due to their ubiquity.
3. **Optimal skills combine demand and salary**: Technologies like Scala, Terraform, and Pandas strike a valuable balance—making them strategic targets for learning.
4. **Japan and Singapore have a diverse hiring landscape**: High-paying data engineering roles are spread across tech giants, consulting firms, and startups—indicating broad industry demand.

### Closing Thoughts
This project transformed me from having no SQL knowledge to mastering foundational SQL skills, while uncovering valuable insights into the data engineering job market. The analysis guides my skill development and job search by prioritizing high-demand, high-salary skills. Aspiring data engineers can gain a competitive edge by focusing on these skills, underscoring the need for continuous learning and adaptability to emerging trends in the field.

