-- MRR analysis
-- Purpose: how is revenue distributed across plan tiers?

USE ravenstack;

-- MRR by plan tier
SELECT
  plan_tier,
  COUNT(DISTINCT account_id) as num_accounts,
  SUM(mrr_amount) as total_mrr,
  ROUND(AVG(mrr_amount), 2) as avg_mrr
FROM ravenstack_subscriptions
WHERE churn_flag = 'False'
  AND end_date = ''
  AND is_trial = 'False'
GROUP BY plan_tier
ORDER BY total_mrr DESC;


-- MRR trend over time
SELECT
  LEFT(start_date, 7) as month,
  COUNT(DISTINCT account_id) as new_subs,
  SUM(mrr_amount) as new_mrr
FROM ravenstack_subscriptions
WHERE is_trial = 'False'
GROUP BY LEFT(start_date, 7)
ORDER BY month ASC;