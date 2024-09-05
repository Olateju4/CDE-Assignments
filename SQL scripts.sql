-- Find order IDs where either gloss_qty or poster_qty is greater than 4000
SELECT id
FROM posey.orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

-- Orders where standard_qty is zero and either gloss_qty or poster_qty is over 1000
SELECT *
FROM posey.orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

-- Company names that start with 'C' or 'W' and primary contact contains 'ana' or 'Ana', but not 'eana'
SELECT name
FROM posey.accounts
WHERE (name LIKE 'C%' OR company_name LIKE 'W%')
  AND primary_poc LIKE '%ana%'
  AND primary_poc NOT LIKE '%eana%';

-- Region for each sales rep along with their associated accounts, sorted by account name
SELECT r.name as Region,sr.name as Sales_Rep,a.name as Account
FROM accounts as a 
INNER JOIN sales_reps AS sr 
    ON a.sales_rep_id = sr.id 
INNER JOIN region AS r 
    ON sr.region_id = r.id
ORDER BY Account_name asc
