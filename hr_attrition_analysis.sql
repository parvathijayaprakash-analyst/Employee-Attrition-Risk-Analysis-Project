-- ============================================
-- QUERY 1: Overall Attrition Situation
-- Business Question: What is the scale of 
-- our people problem?
-- ============================================

SELECT
    COUNT(*) AS total_employees,
    
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        AS total_exits,
    
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) 
        AS total_retained,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 1
    ) AS attrition_rate_pct

FROM hr_data;

FINDING: PeopleFirst has 16.1% attrition rate.
237 of 1,470 employees left.
Industry benchmark is 13% — we are 3.1% above.

-- ============================================
-- QUERY 2: Attrition by Department
-- Business Question: Where is the problem 
-- concentrated?
-- ============================================

SELECT
    Department,
    
    COUNT(*) AS total_headcount,
    
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        AS total_exits,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
* 100.0 / COUNT(*), 1
    ) AS attrition_rate_pct,
    
    ROUND(AVG(MonthlyIncome), 0) 
        AS avg_monthly_salary,
    
    ROUND(AVG(JobSatisfaction), 2) 
        AS avg_job_satisfaction,
    
    ROUND(AVG(YearsAtCompany), 1) 
        AS avg_tenure_years

FROM hr_data
GROUP BY Department
ORDER BY attrition_rate_pct DESC;


-- ============================================
-- QUERY 3: Attrition by Tenure
-- Business Question: When do employees leave?
-- ============================================

SELECT
    CASE
        WHEN YearsAtCompany <= 1  THEN '1. 0-1 Years'
        WHEN YearsAtCompany <= 3  THEN '2. 1-3 Years'
        WHEN YearsAtCompany <= 5  THEN '3. 3-5 Years'
        WHEN YearsAtCompany <= 10 THEN '4. 5-10 Years'
        ELSE                           '5. 10+ Years'
    END AS tenure_band,
    
    COUNT(*) AS employees,
    
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        AS exits,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 1
    ) AS attrition_rate_pct,
    
    ROUND(AVG(MonthlyIncome), 0) AS avg_salary,
    ROUND(AVG(JobSatisfaction), 2) AS avg_satisfaction

FROM hr_data
GROUP BY tenure_band
ORDER BY tenure_band;

FINDING: 34.9% of 0-1 year employees leave.
That is 1 in 3 new joiners quitting before Year 1.
Attrition drops dramatically after Year 3.
Root cause: onboarding failure, not company-wide problem.

-- ============================================
-- QUERY 4: Overtime vs Attrition
-- Business Question: Is burnout driving exits?
-- ============================================

SELECT
    OverTime,
    
    COUNT(*) AS total_employees,
    
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        AS exits,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 1
    ) AS attrition_rate_pct,
    
    ROUND(AVG(MonthlyIncome), 0) AS avg_salary,
    ROUND(AVG(WorkLifeBalance), 2) AS avg_work_life_balance,
    ROUND(AVG(JobSatisfaction), 2) AS avg_satisfaction

FROM hr_data
GROUP BY OverTime
ORDER BY attrition_rate_pct DESC;

FINDING: Overtime employees leave at 30.5% vs 10.4%.
That is a 3x burnout multiplier.
416 employees work overtime — that is 28% of workforce.
Work life balance score is also lower for overtime group.
Direct evidence that workload policy is driving attrition.

-- ============================================
-- QUERY 5: Salary Band vs Attrition
-- Business Question: Does pay drive retention?
-- ============================================

SELECT
    CASE
        WHEN MonthlyIncome < 3000  THEN '1. Low (<$3K)'
        WHEN MonthlyIncome < 6000  THEN '2. Mid ($3K-6K)'
        WHEN MonthlyIncome < 10000 THEN '3. High ($6K-10K)'
        ELSE                            '4. Very High ($10K+)'
    END AS income_band,
    
    COUNT(*) AS employees,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 1
    ) AS attrition_rate_pct,
    
    ROUND(AVG(MonthlyIncome), 0) AS avg_salary,
    ROUND(AVG(YearsAtCompany), 1) AS avg_tenure

FROM hr_data
GROUP BY income_band
ORDER BY income_band;

FINDING: Low earners leave at 29.4% — 3x the rate
of high earners at 8.7%.
Clear inverse relationship: higher pay = lower attrition.
383 employees in low band = immediate compensation review needed.

-- ============================================
-- QUERY 6: Promotion Gap vs Attrition
-- Business Question: Are people leaving because
-- they feel career-stuck?
-- ============================================

SELECT
    CASE
        WHEN YearsSinceLastPromotion = 0 THEN '1. Just Promoted'
        WHEN YearsSinceLastPromotion <= 2 THEN '2. 1-2 Years'
        WHEN YearsSinceLastPromotion <= 4 THEN '3. 3-4 Years'
        ELSE                                   '4. 5+ Years Stagnant'
    END AS promotion_gap,
    
    COUNT(*) AS employees,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 1
    ) AS attrition_rate_pct,
    
    ROUND(AVG(JobSatisfaction), 2) AS avg_satisfaction,
    ROUND(AVG(MonthlyIncome), 0) AS avg_salary,
    ROUND(AVG(YearsAtCompany), 1) AS avg_tenure

FROM hr_data
GROUP BY promotion_gap
ORDER BY promotion_gap;

FINDING: Employees stagnant for 5+ years have
16% attrition vs 14.8% for recently reviewed.
Combined with low satisfaction scores —
career plateau is a contributing attrition factor.
Promotion pipeline needs review for 413 stagnant employees.

-- ============================================
-- QUERY 7: High Risk Segment Identification
-- Business Question: Who are our most expensive
-- losses and what is the financial exposure?
-- ============================================

SELECT
    Department,
    JobRole,
    
    COUNT(*) AS high_risk_exits,
    
    ROUND(AVG(MonthlyIncome), 0) AS avg_monthly_salary,
    
    ROUND(AVG(MonthlyIncome) * 12, 0) 
        AS avg_annual_salary,
    
    ROUND(AVG(MonthlyIncome) * 12 * 0.5, 0) 
        AS replacement_cost_per_person,
    
    ROUND(COUNT(*) * AVG(MonthlyIncome) * 12 * 0.5, 0) 
        AS total_financial_exposure,
    
    ROUND(AVG(YearsSinceLastPromotion), 1) 
        AS avg_promotion_gap,
    
    ROUND(AVG(JobSatisfaction), 2) 
        AS avg_satisfaction

FROM hr_data
WHERE 
    Attrition = 'Yes'
    AND MonthlyIncome > 5000
    AND YearsSinceLastPromotion >= 2

GROUP BY Department, JobRole
HAVING COUNT(*) >= 2
ORDER BY total_financial_exposure DESC
LIMIT 10;

FINDING: Top 3 high-value exit segments represent
over $1.9M in financial exposure.
Research Scientists and Sales Executives leaving
after 2+ years without promotion = career stagnation
driving out expensive talent.
These 41 employees cost more to replace than
fixing the underlying career growth problem.