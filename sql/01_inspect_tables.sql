-- Inspect all tables
-- Purpose: understand the data before writing any analysis queries

USE ravenstack;
DESCRIBE ravenstack_accounts;

-- accounts: look at first 10 rows
SELECT *
FROM ravenstack_accounts
LIMIT 10;