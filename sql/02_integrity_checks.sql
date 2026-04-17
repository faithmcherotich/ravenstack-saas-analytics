USE ravenstack;

-- are there any subscription rows with an account_id
-- that doesnt exist in the accounts table?
SELECT COUNT(*) as orphan_rows
FROM ravenstack_subscriptions
WHERE account_id NOT IN (
  SELECT account_id FROM ravenstack_accounts
);

-- check support_tickets
SELECT COUNT(*) as orphan_rows
FROM ravenstack_support_tickets
WHERE account_id NOT IN (
  SELECT account_id FROM ravenstack_accounts
);

-- check churn_events
SELECT COUNT(*) as orphan_rows
FROM ravenstack_churn_events
WHERE account_id NOT IN (
  SELECT account_id FROM ravenstack_accounts
);

-- check how many accounts are churned vs retained
SELECT
  churn_flag,
  COUNT(*) as total
FROM ravenstack_accounts
GROUP BY churn_flag;

-- check MRR range in subscriptions
SELECT
  MIN(mrr_amount) as lowest_mrr,
  MAX(mrr_amount) as highest_mrr,
  AVG(mrr_amount) as average_mrr
FROM ravenstack_subscriptions;

-- check for nulls in satisfaction_score
SELECT
  COUNT(*) as total_tickets,
  COUNT(satisfaction_score) as tickets_with_score
FROM ravenstack_support_tickets;
