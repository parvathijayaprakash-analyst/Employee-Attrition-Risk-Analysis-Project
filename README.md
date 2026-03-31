**Employee-Attrition-Risk-Analysis Project**

Identifying why PeopleFirst Technologies is losing $2.8M annually to employee attrition


 * Project Overview

This project analyzes workforce instability and employee attrition patterns for PeopleFirst Technologies using Excel, SQL, and Power BI.

The goal was to uncover the key drivers of attrition, identify high-risk employee segments, and provide actionable business recommendations to reduce annual turnover losses.

---

* Business Problem

PeopleFirst Technologies experienced a 40% rise in customer complaints linked to workforce instability.
Leadership needed answers to:

- Which departments are losing the most employees?
- Why are employees leaving?
- Which workforce factors are driving attrition?
- What actions can reduce the $2.8M annual attrition cost?

---

* Key Business Questions

1. Which department has the highest attrition rate?
2. When in their career are employees most likely to leave?
3. Is overtime contributing to burnout and exits?
4. Does compensation impact retention?
5. Who are the highest flight-risk current employees?

---

* Methodology

- Data familiarization — analyzed 35 columns and 1,470 employee records
- Excel analysis — built 6 pivot tables for exploratory analysis
- SQL analysis — wrote 7 analytical queries, including window functions
- Power BI dashboarding — created a 4-page interactive dashboard
- Root cause analysis — applied 5 Whys methodology to interpret drivers

---

* Key Findings

1) Department Risk

The Sales department recorded the highest attrition at 20.6%, which is 50% above the company average of 16.1%.

Insight: Sales also showed the lowest satisfaction levels and the highest overtime rate, indicating a strong burnout-retention link.

---

2) Onboarding Crisis

34.9% of employees leave within their first year.

Insight: Nearly 1 in 3 new joiners exits before completing Year 1, suggesting onboarding and early employee experience issues rather than long-term culture alone.

---

3) Burnout Signal

Employees working overtime leave at 31%, compared to just 10% for employees not working overtime.

Insight: Overtime creates a 3× attrition risk, making workload management a major retention lever.

---

4) Compensation Gap

Employees earning less than $3K/month show 29% attrition, versus 9% for employees earning $10K+.

Insight: Compensation is a measurable and actionable retention driver.

---

5) Flight Risk Segmentation

The dashboard identified:

- 15 Critical Risk employees
- 43 High Risk employees

Insight: These active employees may require immediate intervention to prevent near-term exits.

---

* Business Recommendations

Priority| Action| Timeline| Estimated Annual Saving
1| Conduct Sales workforce audit and hire 3 additional staff| Week 1–2| ~$800K
2| Redesign onboarding and first-year employee experience| Month 1–2| ~$600K
3| Perform compensation benchmarking review| Month 2–3| ~$200K

* Total Recoverable Value

~$1.4M annually

---

* Dashboard Preview

Executive Overview

"Executive Overview" <img width="1340" height="743" alt="HR Attrition Powerbi dashboard page 1 Executive Overview" src="https://github.com/user-attachments/assets/4668825c-54be-4902-b554-d515f6d49fde" />


Flight Risk Dashboard

"Risk Dashboard" <img width="1327" height="742" alt="HR Attrition Powerbi dashboard page 4 Risk dashboard" src="https://github.com/user-attachments/assets/b867aa33-1231-408e-8829-a5cc82fb1216" />


---

* Tools Used

Tool| Purpose
Excel| Data cleaning, pivot analysis, exploratory insights
SQL (MySQL)| Analytical queries and workforce trend analysis
Power BI| Interactive dashboard development
DAX| Calculated columns and KPI measures

---

* Repository Structure

File / Folder| Description
"data/hr_attrition_raw.csv"| Raw HR dataset (1,470 records)
"excel/hr_attrition_analysis.xlsx"| Excel analysis and pivot insights
"sql/hr_attrition_analysis.sql"| SQL queries used for analysis
"powerbi/hr_attrition_dashboard.pbix"| Power BI dashboard file
"screenshots/"| Dashboard preview images

---

* Dataset Information

- Source: IBM HR Analytics Dataset (Kaggle)
- Records: 1,470 employees
- Features: 35 columns
- Analysis Period: Simulated FY2026 business case

---

* Business Impact

This project demonstrates how HR analytics can move beyond reporting into decision-making support by helping leadership:
- identify attrition hotspots,
- quantify workforce risk,
- prioritize interventions,
- and estimate financial recovery opportunities.

---

* Author

Parvathi Jayaprakash
Data Analyst | Excel | SQL | Power BI

---
