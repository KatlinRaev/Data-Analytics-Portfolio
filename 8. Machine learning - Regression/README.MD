# Regression: Cardiovascular Disease Prediction

## Sprint Overview

Project focuses on predictive modeling including analyzing the Cardiovascular Disease Prediction dataset using Pandas. The objective is to explore various data processing techniques, including data cleaning, exploratory data analysis (EDA), and visulization and use predictive modeling. 

## Objectives

- Predictive modeling
- Working with data from Kaggle
- Performing basic Exploratory Data Analysis (EDA)

## Requirements

All nessesery requirements are listed in text file what is in repository under the name - Requirements.txt

Main Tools Used
- Python
- Jupyter Notebook
- Matplotlib
- Seaborn
- Sklearn
- Spicy

## About the Dataset

### Context

The dataset is publically available on the Kaggle website, and it is from an ongoing cardiovascular study on residents of the town of Framingham, Massachusetts. The classification goal is to predict whether the patient has 10-year risk of future coronary heart disease (CHD).The dataset provides the patients’ information.


## Content

This dataset contains over 4,000 records and 15 attributes. The detailed description:

### Demographic
- **Sex**: male or female ("M" or "F")
- **Age**: Age of the patient (Continuous - Although the recorded ages have been truncated to whole numbers, the concept of age is continuous)

### Behavioral
- **is_smoking**: whether or not the patient is a current smoker ("YES" or "NO")
- **Cigs Per Day**: the number of cigarettes that the person smoked on average in one day (can be considered continuous as one can have any number of cigarettes, even half a cigarette)

### Medical (history)
- **BP Meds**: whether or not the patient was on blood pressure medication (Nominal)
- **Prevalent Stroke**: whether or not the patient had previously had a stroke (Nominal)
- **Prevalent Hyp**: whether or not the patient was hypertensive (Nominal)
- **Diabetes**: whether or not the patient had diabetes (Nominal)

### Medical (current)
- **Tot Chol**: total cholesterol level (Continuous)
- **Sys BP**: systolic blood pressure (Continuous)
- **Dia BP**: diastolic blood pressure (Continuous)
- **BMI**: Body Mass Index (Continuous)
- **Heart Rate**: heart rate (Continuous - In medical research, variables such as heart rate, though in fact discrete, yet are considered continuous because of large number of possible values)
- **Glucose**: glucose level (Continuous)

### Predict variable (desired target)
- **10-year risk of coronary heart disease CHD**: binary ("1" means "Yes", "0" means "No")

## Key Takeaways

### Key Predictors of 10-Year CHD Risk

#### Demographics and Risks:
- **Sex Impact**: Men are at a higher risk of CHD compared to women.
- **Age Impact**: CHD risk increases with age, peaking around 55-60 years. The majority "Not at Risk" are aged 45-50.

#### Behavioral Factors:
- **Smoking Status**: Correlates with higher cholesterol, blood pressure, and glucose levels. The number of cigarettes per day does not significantly impact these health indicators.

#### Medical History and Current Conditions:
- **Hypertension**: Stands out as a significant medical history factor associated with a higher risk of CHD, with strong correlations observed with both systolic and diastolic blood pressure.
- **Diabetes**: Shows a weaker correlation with CHD risk.
- **Health Measurements**: Individuals "At Risk" for CHD generally have higher blood pressure and glucose levels, with no notable difference in BMI between the two groups.

Overall, your analysis highlights the importance of sex, age, smoking status, hypertension, and glucose levels as key predictors of CHD risk. Further statistical tests or machine learning models are recommended to better quantify these relationships.

### Predictive Modeling Conclusions

#### Model 1: Base Logistic Regression
- **Strengths**: Excellent at predicting the absence of CHD (Class 0), with high precision and recall for "No."
- **Weaknesses**: Struggles to predict CHD presence (Class 1), with very low recall for "Yes," resulting in missed diagnoses.

#### Model 2: Balanced Class Weights
- **Strengths**: Improves recall for CHD presence (Class 1) to 0.60, making it better at detecting positive cases.
- **Weaknesses**: Low precision for "Yes" (many false positives), and accuracy drops due to the class imbalance correction.

#### Model 3: Adjusted Threshold (0.3)
- **Strengths**: Maximizes recall for CHD presence (0.89), highly sensitive to detecting positive cases.
- **Weaknesses**: Precision for "Yes" drops significantly (0.17), leading to many false positives, and accuracy decreases to 0.37.

## Next Steps in Modeling

- **Model 2 (Balanced Weights)**: For further analysis, adjusting class weights or hyperparameters (e.g., C) could help better balance recall and precision.
- **Model 3 (Adjusted Threshold)**: Exploring thresholds between 0.3 and 0.5 might improve the balance between recall and precision.
- **Alternative Models**: Other algorithms, like tree-based models (Random Forest, Gradient Boosting), could be tested for potentially better results on imbalanced datasets.
- **Precision-Recall Focus**: F1-score could be prioritized over accuracy to better balance precision and recall.
- **Feature Engineering**: Exploring techniques like oversampling or undersampling might enhance model performance.
- **Domain Evaluation**: Further consultation with domain experts may ensure the model’s predictions are aligned with practical requirements.

