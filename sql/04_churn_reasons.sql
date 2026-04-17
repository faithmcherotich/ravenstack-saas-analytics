-- Churn reason analysis
-- Purpose: find out why customers are leaving
-- What are the top churn reasons?

USE ravenstack;

-- churn reasons ranked
SELECT
  reason_code,
  COUNT(*) as total
FROM ravenstack_churn_events
GROUP BY reason_code
ORDER BY total DESC;


-- check what reason codes exist in churn_events
SELECT
  reason_code,
  COUNT(*) as total
FROM ravenstack_churn_events
GROUP BY reason_code
ORDER BY total DESC;

-- churn reasons by plan tier
SELECT
  ravenstack_accounts.plan_tier,
  ravenstack_churn_events.reason_code,
  COUNT(*) as total
FROM ravenstack_churn_events
JOIN ravenstack_accounts
  ON ravenstack_churn_events.account_id = ravenstack_accounts.account_id
GROUP BY ravenstack_accounts.plan_tier, ravenstack_churn_events.reason_code
ORDER BY ravenstack_accounts.plan_tier, total DESC;