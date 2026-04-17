-- Feature usage analysis
-- Purpose: which features do retained users use more?

USE ravenstack;

-- top 10 most used features overall
SELECT
  feature_name,
  COUNT(DISTINCT subscription_id) as num_users,
  SUM(usage_count) as total_usage
FROM ravenstack_feature_usage
GROUP BY feature_name
ORDER BY total_usage DESC
LIMIT 10;

-- feature usage: churned vs retained
SELECT
  f.feature_name,
  a.churn_flag,
  COUNT(DISTINCT f.subscription_id) as num_users,
  ROUND(AVG(f.usage_count), 2) as avg_usage
FROM ravenstack_feature_usage f
JOIN ravenstack_subscriptions s ON f.subscription_id = s.subscription_id
JOIN ravenstack_accounts a ON s.account_id = a.account_id
GROUP BY f.feature_name, a.churn_flag
ORDER BY f.feature_name
LIMIT 20;