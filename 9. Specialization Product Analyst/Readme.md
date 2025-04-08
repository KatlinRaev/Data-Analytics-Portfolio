# User Purchase Duration Analysis

## Task Overview
This project addresses a follow-up task from the Product Manager to analyze how much time it takes for a user to make a purchase on the website. The focus is on measuring the duration from a user's first arrival on the website on any given day to their first purchase on the same day. The analysis explores the dynamics of these durations on a daily basis.

## Project Goals
1. **Dynamic Daily Duration Analysis**:
   - Calculate user purchase duration based on daily activity.
   - Highlight daily trends and patterns in purchasing behavior.

2. **Presentation & Insights**:
   - Build a presentation centered around the dynamics of daily purchase durations.
   - Incorporate 1-2 techniques learned in the course material to enhance the presentation.

3. **Exploration & Recommendations**:
   - Explore the data to uncover interesting data points that enhance the analysis.
   - Provide analytical insights, discuss drawbacks of the analysis, and recommend further investigations.

## Approach
1. **Data Extraction**:
   - Extract raw data from the `turing_data_analytics.raw_events` table in BigQuery using SQL.
   - Focus on user sessions and calculate the time duration between the first arrival and first purchase events.

2. **Visualization**:
   - Utilize Power BI to create visualizations highlighting daily duration dynamics.
   - Present patterns, trends, and actionable insights.

3. **Analytical Findings**:
   - Identify user behavior patterns, such as faster purchasing correlating with higher revenue.
   - Explore seasonal trends, device-specific behavior, and country-specific insights.

4. **Recommendations**:
   - Improve user experience for decisive buyers and desktop users.
   - Enhance loyalty programs to maximize revenue from returning customers.
   - Optimize marketing campaigns to align with seasonal and weekday trends.
   - Address drop-offs during the checkout process to boost conversions.

## Results
### Patterns in Purchasing Behavior:
- Faster purchasing correlates with higher revenue.
- Seasonal trends, such as end-of-year holidays, significantly boost revenue.
- Desktop users generate higher revenue, while mobile engagement remains strong.
- Returning customers contribute more revenue per purchase, emphasizing loyalty programs.
- Browser and country-specific trends reveal opportunities for localization and optimization.
- Drop-offs during add-to-cart and checkout stages indicate areas for usability improvement.

### Further Analysis Suggestions:
1. **Traffic Sources**:
   - Analyze customer entry points to understand behavior across channels.

2. **Retention & Loyalty**:
   - Investigate repeat customer rates and strategies to strengthen loyalty.

3. **Checkout Optimization**:
   - Examine cart abandonment and develop solutions to improve the process.

4. **Content Performance**:
   - Assess the impact of product descriptions and visuals on driving purchases.

5. **Regional Trends**:
   - Research purchasing behaviors by location for tailored marketing strategies.

6. **Device-Specific Enhancements**:
   - Optimize mobile and desktop experiences to maximize revenue.


## Tools & Technologies Used
- SQL: For data extraction from BigQuery.

- Power BI: For creating visualizations and analyzing data trends.

- BigQuery: Data storage and management platform.
