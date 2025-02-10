# DA.PY.3.5

# Coursera Course Dataset Analysis

## Sprint Overview

Project focuses on analyzing the Coursera Course dataset using Pandas. The objective is to explore various data processing techniques, including data cleaning, exploratory data analysis (EDA), and visulization. The dataset contains the Coursera Course dataset and includes various features such as course titles, organizations, available course certifications, ratings, difficulty level and enrolled student numbers.

## Objectives

- Working with data from Kaggle.
- Performing basic Exploratory Data Analysis (EDA).

## Requirements

All nessesery requirements are listed in text file what is in repository under the name - Requirements.txt

Main Tools Used
- Python
- Jupyter Notebook
- Matplotlib
- Seaborn

## About the Dataset

### Context

This dataset was generated during a hackathon for a project purpose. The data was scraped from the Coursera official website. Our project aims to help any new learner get the right course to learn by just answering a few questions. It is an intelligent course recommendation system. Hence we had to scrape data from a few educational websites. This data was scraped from the Coursera website.


### Content

This dataset contains mainly 6 columns and 890 course data. The detailed description:

- **course_title**: Contains the course title.
- **course_organization**: Tells which organization is conducting the courses.
- **course_Certificate_type**: Details about the different certifications available in courses.
- **course_rating**: Contains the ratings associated with each course.
- **course_difficulty**: Describes the level of difficulty of the course.
- **course_students_enrolled**: Number of students enrolled in the course.

  
# Key Takeaways

**1. Overall High Ratings**: The dataset shows consistently high ratings across all courses, with an average rating of 4.68 and a small standard deviation, indicating general satisfaction among learners.

**2. Beginner Courses Dominate**: Beginner level courses are the most popular, accounting for the largest share across all certification types. This suggests a strong demand for entry-level education.

**3. Popularity Doesn't Compromise Quality**: Courses with higher enrollment numbers do not show a decline in ratings. This indicates that popular courses maintain high quality despite large numbers of students.

**4. 'Course' Certification Type Leads**: The 'Course' certification type is the most common, followed by 'Specialization' and 'Professional Certificates'. Although 'Professional Certificates' have a slightly lower median rating, they offer more consistent feedback.

**5. Top Providers Are Prestigious Institutions**: Leading providers include renowned universities and institutions such as the University of Pennsylvania, University of Michigan, and Google Cloud. These providers dominate the course offerings.

**6. Technical Skills in High Demand**: The top courses focus heavily on technical skills like data science, machine learning, and programming, reflecting the demand for expertise in these areas.

**7. Importance of Soft Skills**: Courses on career development and negotiation highlight the need for well-rounded professionals, showcasing the importance of soft skills alongside technical knowledge.

**8. Bayesian Adjustments for Accurate Ratings**: The Bayesian method provides a more accurate reflection of course ratings by adjusting for the number of courses offered by each institution. This helps identify reliable ratings and adjust for potential overestimations.


# Next Steps in Analysis

**1. Collect More Data**:
- Gather student reviews and comments to gain deeper insights into their experiences and opinions.

**2. Sentiment Analysis**:
- Perform sentiment analysis on student reviews and comments to understand the overall sentiment and identify common themes or issues.

**3. Detailed Provider Analysis**:
- Dive deeper into the course providers, examining factors such as provider reputation, course quality, and provider-specific trends.

**4. Course Costing Data**:
- Collect data on course costs and analyze how pricing affects enrollment rates and student ratings.
- Explore the relationship between course cost, quality, and overall value perceived by students.

