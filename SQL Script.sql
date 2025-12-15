/* ============================================================
   HR Analytics (MySQL)
   ============================================================ */
    
CREATE DATABASE hr_analytics;
USE hr_analytics;

-- 1) Quick row count check
SELECT COUNT(*) FROM HR_Data;

-- 2) Initial Data Exploration
SELECT * 
FROM HR_Data
LIMIT 10;

-- 3) Overall Attrition Rate
SELECT
	COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TotalAttrition,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    ) AS AttritionRate_Percent
FROM HR_Data;
    
-- 4) Attrition by Department (Grouping and Ordering)
SELECT
    Department,
    COUNT(*) AS DepartmentTotal,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS DepartmentAttrition,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    ) AS AttritionRate_Percent
FROM HR_Data
GROUP BY Department
ORDER BY AttritionRate_Percent DESC, DepartmentTotal DESC;
    
-- 5) Impact of Job Satisfaction on Attrition
SELECT
    JobSatisfaction,
    COUNT(*) AS EmployeeCount,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    ) AS AttritionRate_Percent
FROM HR_Data
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction ASC;
    
-- 6) Analyzing Performance Rating vs. Salary (Identifying "Flight Risk" candidates)
    
WITH RoleAverage AS (
    SELECT
        JobRole,
        AVG(MonthlyIncome) AS AvgIncomeByRole
    FROM HR_Data
    GROUP BY JobRole
)
SELECT
    h.EmployeeNumber,
    h.JobRole,
    h.PerformanceRating,
    h.MonthlyIncome,
    ROUND(r.AvgIncomeByRole, 2) AS AvgIncomeByRole,
    ROUND(r.AvgIncomeByRole - h.MonthlyIncome, 2) AS BelowAvgBy
FROM HR_Data h
JOIN RoleAverage r
    ON h.JobRole = r.JobRole
WHERE h.PerformanceRating = 4
  AND h.Attrition = 'No'
  AND h.MonthlyIncome < r.AvgIncomeByRole
ORDER BY BelowAvgBy DESC, h.MonthlyIncome ASC;
    
    

