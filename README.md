# ELT Pipeline for Keyword Frequency and Sentiment Analysis

<br/>

| Todos                                  | Description                              | Responsible/Accountable
|----------------------------------------|------------------------------------------|-------------------------
| Add table of content                   |                                          |
| Add badges                             |                                          |
| Provide solution architecture          | Provide diagram of pipeline architecture |
| Describe the flaws of the pipeline     |
| Talk about improvements for the future | 

<br/>

# Introduction
Keyword frequency is defined as how often a keyword appears in a given piece of text or content. It is considered in efforts such as Search Engine Optimsation (SEO) and digital marketing.
Sentiment analysis refers a process that seeks to computationally categorise the opinion expressed in a piece of text to learn the writer's attitude towards a particular subject. Generally, categories considered are *positive*, *negative*, and *neutral*.

The goal of the project was to design and a build a reliable data pipeline for the data science consultancy company, PRO Inc. The development of the pipeline was the key to answering some research questions posited by the owners. The owners - Paul, Rashid, and Oliver, allowed a period of three weeks to complete the project.

<br/><br/>

# High-level Task Assignment 

| Task                             | Member Responsible 
|----------------------------------|------------------- 
| Ingestion                        | Rashid Mohammed
| Orchestration                    | Oliver Liu
| Transformation and Quality Tests | Paul Hallaste


<br/><br/>

# Project Management 
Project management - task assignment - was managed using Notion. Project meetings were held on a weekly basis to:
- Make sure team members were on schedule 
- Reschedule tasks were necessary
- Share knowledge

<br/>

## Kanban 
<img src='assets/Kanban.png'/>

<br/><br/>

# Research Questions 
## Twitter data
1. Keyword frequency analysis: How often do data practicioners mention cloud data warehouses and which ones? How often and since when do they mention data space trends such as "data mesh" and "data vault"?
2. Sentiment analysis with regard to data warehouse tools

<br/>

## GitHub
1. How much activity there is in each of the repositories (counted by, for example trendline for no. of commits in the repository)
2. What languages are mainly used in the each of the repos (Python vs. SQL vs. Java etc)
3. Top contributors in the repos?
4. Many contributors, few commits vs. few contributors, many commits?
5. Location of users etc.

<br/><br/>

# Data Sources 
Several data sources were considered however upon careful consideration, we decided to extract the textual data from **GitHub** and **Twitter**. Github and Twitter provide arguably reliable REST API endpoints that can be used to query data. Helpful resources on how to get started with these endpoints are provided in Appedix A of this document. Additionally, the data would be useful for anyone that is interested in trends in the data space, including data practitioners and investors.

<br/>

## Twitter tweets 
We have extracted the tweets from various data influencers and people who are part of Data Twitter as it's sometimes called colloquially. The list of Twitter users was scraped from Twitter handles featured in the [Data Creators Club site](https://datacreators.club/) by [Mehdi Ouazza](https://github.com/mehd-io), to which other influencers active in the data space were added manually.

<br/>

## Github repo activity dataset via official Airbyte Github source.  
The dataset includes the Github repos of 6 prominent open-source data orchestration tools: Airflow, Dagster, Prefect, Argo, Luigi and Orchesto.


<br/><br/>


# Methodology 

## Ingestion 
**Airbyte** was used the data integration tool for the ingestion of data. It was selected because it's open source and it's gaining a lot of traction in the data community. Airbyte was used to extract github repo activity data however, a custom python script was developed to extract the tweets of selected twitter users. The python script can be found in `data-orchestration/dags/tweets_dag/extract_tweets_pipeline.py`.

<br/>

## Transformation 
TBD by Paul

<br/>

## Orchestration 
Pipeline orchestration was performed with **Apache Airflow**. It was built by Maxime Beauchemin in October 2014 and has gained widespread adoption since then. 



<br/><br/>


# Solution architecutre
TBD



<br/><br/><br/><br/>

# Appendices 
## Appendix A
<br/>

### GitHub REST API
https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api

### Twitter API
https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api