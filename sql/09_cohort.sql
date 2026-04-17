-- Cohort analysis
-- Purpose: which signup cohorts retain best?

USE ravenstack;

SELECT
  LEFT(a.signup_date, 7) as cohort_month,
  LEFT(s.start_date, 7) as active_month,
  COUNT(DISTINCT a.account_id) as accounts_active
FROM ravenstack_accounts a
JOIN ravenstack_subscriptions s ON a.account_id = s.account_id
WHERE s.is_trial = 'False'
GROUP BY LEFT(a.signup_date, 7), LEFT(s.start_date, 7)
ORDER BY cohort_month, active_month;