-- What is the churn rate by plan tier?

USE ravenstack;

-- overall churn rate
SELECT
  COUNT(*) as total_accounts,
  SUM(CASE WHEN churn_flag = 'True' THEN 1 ELSE 0 END) as churned,
  ROUND(SUM(CASE WHEN churn_flag = 'True' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as churn_rate_pct
FROM ravenstack_accounts;

-- churn rate by plan tier
SELECT
  plan_tier,
  COUNT(*) as total,
  SUM(CASE WHEN churn_flag = 'True' THEN 1 ELSE 0 END) as churned,
  ROUND(SUM(CASE WHEN churn_flag = 'True' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as churn_rate_pct
FROM ravenstack_accounts
GROUP BY plan_tier
ORDER BY churn_rate_pct DESC;