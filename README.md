# 🚀 HR Analytics: Identifying Employee Flight Risks & Performance Drivers

## 🌟 Project Goal & Business Value

This project utilizes SQL to perform an in-depth analysis of a corporate Human Resources dataset. The primary goal was to move beyond simple reporting and provide **actionable, data-driven recommendations** to the C-suite on how to reduce costly employee attrition (turnover) and better manage compensation.

## 💾 Dataset Overview

* **Source:** Kaggle (IBM HR Analytics - Employee Attrition & Performance)
* **Technology:** Analysis performed using **[MySQL]**.
* **Key Data Points:** Employee $ID$, $Attrition$ (Yes/No), $Department$, $JobRole$, $MonthlyIncome$, $JobSatisfaction$ and $PerformanceRating$.

## 🛠️ Key SQL Analysis & Insights

### 1. The Attrition Problem: Where it Hurts Most

The overall company attrition rate stands at **16.12%**. Further segmentation revealed a critical department-level issue:

| Department | Attrition Rate | **Actionable Insight** |
| :--- | :--- | :--- |
| **Sales** | **20.63%** | This is the highest rate. Immediate review of sales commission structures and work-life balance initiatives is necessary to stabilize this core revenue function. |
| **Human Resources** | **19.05%** | High turnover in the HR department itself is a major red flag for company culture and management. |

### 2. Correlation: Satisfaction Directly Drives Retention

A clear negative correlation was found between job satisfaction scores ($1$=Low, $4$=High) and the likelihood of leaving the company.

| Job Satisfaction Score | Attrition Rate |
| :--- | :--- |
| **1 (Low)** | **22.84%** |
| **4 (High)** | **11.33%** |

> **💡 Insight:** Employees with the lowest satisfaction score are **twice as likely to leave** as those with the highest score. Investment in employee engagement and workplace environment improvements is essential.

### 3. Identifying Underpaid High-Performers (The "Flight Risk" List)

This was the core finding of the project, using a **Common Table Expression (CTE)** to compare an employee's salary against their specific role's average.

**The Query Identified: 120** high-performing employees ($PerformanceRating = 4$) who are currently earning **below** the average monthly income for their $\text{JobRole}$.

> **🔥 Critical Recommendation:** **This list of 120 employees represents the highest retention risk.** These are the company's best talents who are statistically underpaid. Prioritizing immediate compensation adjustments for this small, high-value cohort will yield the highest return on retention investment.
