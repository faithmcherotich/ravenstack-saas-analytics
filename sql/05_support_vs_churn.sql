-- Support tickets vs churn
-- Purpose: do accounts with more tickets churn more?

USE ravenstack;

-- ticket count per account
SELECT
  account_id,
  COUNT(*) as ticket_count,
  AVG(satisfaction_score) as avg_score
FROM ravenstack_support_tickets
GROUP BY account_id
ORDER BY ticket_count DESC
LIMIT 20;

-- compare ticket count: churned vs retained
SELECT
  ravenstack_accounts.churn_flag,
  COUNT(DISTINCT ravenstack_accounts.account_id) as num_accounts,
  ROUND(AVG(ticket_counts.ticket_count), 1) as avg_tickets,
  ROUND(AVG(ticket_counts.avg_score), 2) as avg_satisfaction
FROM ravenstack_accounts
LEFT JOIN (
  SELECT
    account_id,
    COUNT(*) as ticket_count,
    AVG(satisfaction_score) as avg_score
  FROM ravenstack_support_tickets
  GROUP BY account_id
) as ticket_counts
  ON ravenstack_accounts.account_id = ticket_counts.account_id
GROUP BY ravenstack_accounts.churn_flag;