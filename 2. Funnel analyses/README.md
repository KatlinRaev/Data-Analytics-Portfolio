# Funnel Analysis Task

## Task Overview
The objective of this task is to create a funnel chart using the `raw_events` table, focusing on user events on a website. The funnel will highlight differences between the top 3 countries by event count, providing insights into user behavior and identifying potential areas for improvement in the sales flow.

## Approach

### 1. Data Preparation
- **Analyze Raw Data**: Query the `raw_events` table to familiarize yourself with the data and understand the captured user events.
- **Remove Duplicates**:
  - Write a SQL query to create a unique events table with one distinct event per `user_pseudo_id`.
  - Use the earliest event timestamp to resolve duplicates.

### 2. Funnel Chart Creation
- **Select Relevant Events**:
  - Identify 4-6 key events to include in the funnel (e.g., `session_start`, `view_item`, `add_to_cart`, `begin_checkout`, `purchase`).
- **Country Split**:
  - Aggregate events by country.
  - Identify the top 3 countries based on total event count.
- **Funnel Data Table**:
  - Create a table showing event counts and percentage drop-off values for the top 3 countries.
  - Format the table to include columns such as event order, event name, and percentage drop-offs.

### 3. Visualization
- **Funnel Chart**:
  - Create a funnel chart split by the top 3 countries.
  - Use tools like Google Sheets, Tableau, or Looker Studio for visualization.
- **Additional Insights**:
  - Explore other potential splits (e.g., device type, user segment) to uncover additional insights.

## Deliverables
1. **SQL Queries**:
   - Query for unique events table.
   - Query for aggregated funnel data split by the top 3 countries.
2. **Funnel Data Table**:
   - A structured table showing event counts and drop-off percentages for the top 3 countries.
3. **Visualizations**:
   - Funnel chart(s) highlighting differences between countries.
4. **Insights**:
   - Key observations and actionable recommendations based on the data.

## Evaluation Criteria
- **Accuracy**: Data collected and formatted correctly, adhering to the specified structure.
- **Visualization**: Effective use of funnel charts with a country split and clear presentation.
- **Insights**: At least 1-2 actionable insights provided.
- **Formatting**:
  - Clean and readable tables with conditional formatting.
  - Charts with optimal spacing and aesthetic appeal.
- **Analytical Approach**: Thoughtful analysis and a logical approach to solving the problem.

## Usage
This README serves as a guide for understanding and completing the task. It outlines the steps required for data preparation, visualization, and presentation of findings.
