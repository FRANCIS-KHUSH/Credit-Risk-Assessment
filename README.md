# Credit Risk Assessment using Logistic Regression

## Description
This project provides an in-depth exploration of credit risk assessment at Apex Trust Bank, utilizing R to enhance lending operations and minimize the impact of non-performing loans.

## Key Learning Points
- Exploratory Data Analysis (EDA) techniques to understand data distributions and relationships.
- Implementation of Logistic Regression for binary classification.
- Development of a predictive model to assess credit risk.
- Evaluation of model performance .

## Business Overview
Apex Trust Bank is facing an increasing number of non-performing loans, which negatively impacts profitability and financial stability. This project aims to identify potential high-risk borrowers through data-driven insights, thus aiding in informed lending decisions.

## Rationale for the Project
Logistic regression is a powerful statistical technique suitable for binary outcomes, making it ideal for predicting credit risk. This method helps in understanding the relationship between borrower characteristics and their likelihood of defaulting.

## Aim of the Project
The primary aim of this project is to assess credit risk by evaluating the likelihood of loan default based on borrower information and historical data, thereby supporting Apex Trust Bank in reducing potential financial losses.

## Data Description
- **Status**: Categorical variable representing the status of the borrower's checking account.
- **Duration**: Credit duration in months, indicating the length of the loan.
- **Credit History**: Categorical variable reflecting the borrower's credit history.
- **Purpose**: The reason for taking out the loan (e.g., education, car purchase).
- **Amount**: Loan amount requested by the borrower.
- **Savings**: Borrower's savings account status.
- **Employment Duration**: Length of the borrower's employment.
- **Installment Rate**: Ratio of the installment payment to the borrower's income.
- **Other Variables**: Additional features that may impact credit risk (e.g., age, number of credits, job type).

## Tech Stack
- R Programming Language
- R Libraries: `tidyverse`, `tidymodels`, `ggplot2`, `caret`, and more.

## Project Scope
- **Exploratory Data Analysis**: Summary statistics and visualizations to uncover patterns and insights within the data.
- **Model Development**: Splitting the dataset into training and test sets, followed by fitting a logistic regression model.
- **Model Evaluation**: Assessing the model's performance using accuracy, confusion matrices, and feature importance metrics.

