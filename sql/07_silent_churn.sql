-- Silent churn detection
-- Purpose: find active accounts with zero feature usage

USE ravenstack;

-- create a temp table of subscriptions that have usage
CREATE TEMPORARY TABLE has_usage AS
SELECT DISTINCT subscription_id
FROM ravenstack_feature_usage;

-- find active subscriptions with no usage
SELECT
  s.plan_tier,
  COUNT(*) as silent_churners,
  SUM(s.mrr_amount) as mrr_at_risk
FROM ravenstack_subscriptions s
LEFT JOIN has_usage h ON s.subscription_id = h.subscription_id
WHERE s.churn_flag = 'False'
  AND s.end_date = ''
  AND h.subscription_id IS NULL
GROUP BY s.plan_tier
ORDER BY mrr_at_risk DESC;

-- clean up
DROP TEMPORARY TABLE has_usage;