/* ==============================================================================================================================
              BANKING DOMAIN PROJECT : Aggregate Data , Window Function
================================================================================================================================*/



-- TASK 1 : Generate a report showing the total transaction amount, average transaction amount,
-- and transaction count for each transaction type (Aggregate Data).

select 
	transaction_type,
    round(sum(transaction_amount),2) as Total_Amount,
    round(avg(transaction_amount),2) as Avg_Amount,
    count(*) as Txn_count
from transactions
group by transaction_type;

-- TASK 2 : "Find the minimum and maximum account balance for each customer segment (Aggregate & Filter Groups).
-- Only include segments with more than 5 accounts."


select
	c.customer_segment,
    min(a.account_balance) as Min_Balance,
    max(a.account_balance) as Max_Balance,
    count(*) as Account_Count
from customers c inner join accounts a on c.customer_id = a.customer_id
group by c.customer_segment having count(*) > 5;


-- TASK 3 : Find the total number of transactions overall and the total number of transactions for each account (Window Function Basics).

select 
	transaction_id,account_id,transaction_date,
    count(*) over () as Total_Transaction,
    count(*) over (partition by account_id) as TransactionByAccount
from transactions;

-- TASK 4 : Check the Accounts table for duplicate Account IDs (Window Function Basics).

select * from (select *,
				count(*) over (partition by account_id) as Duplicate_Check
			  from Accounts) t 
where Duplicate_Check >1;


-- TASK 5 : Find the total and average transaction amount overall and for each account (Window Aggregation Functions).

select 
	account_id,transaction_id,transaction_amount,
    sum(transaction_amount) over () as Total_Amount_Overall,
    avg(transaction_amount) over() as Avg_Amount_Overall,
    sum(transaction_amount) over(partition by account_id) as TotalTxnByAccount,
    avg(transaction_amount) over(partition by account_id) as AvgTxnByAccount
from transactions;



-- TASK 6 : "Find the lowest and highest transaction amount for each account (Window Aggregation Functions).
-- Additionally, calculate how far each transaction is from both values."

select 
	transaction_id,account_id,transaction_amount,
    min(transaction_amount) over(partition by account_id) as Lowest_for_Account,
    max(transaction_amount) over (partition by account_id) as Max_for_Account,
    transaction_amount - min(transaction_amount) over ( partition by account_id) as Deviation_from_min,
    max(transaction_amount) over (partition by account_id) - transaction_amount as Deviation_from_Max
from transactions;


-- TASK 7 : "Rank each account based on their balance within their customer segment, from highest to lowest (Window Ranking Functions).
-- Additionally, provide details such as Account ID and Customer Segment."

select
	c.customer_segment,a.account_id, a.account_balance,
    row_number() over(partition by c.customer_segment order by a.account_balance desc) as Row_num_Rank,
    rank() over(partition by c.customer_segment order by a.account_balance desc) as rank_Rank 
from customers c inner join accounts a on c.customer_id = a.customer_id;


-- TASK 8 : Rank each account within their segment without leaving gaps when balances tie,
-- and divide each segment's accounts into 4 equal groups based on balance (Window Ranking Functions).

select
	c.customer_segment,a.account_id,a.account_balance,
    dense_rank() over(partition by c.customer_segment order by a.account_balance desc) as Dense_rank_num,
    ntile(4) over(partition by c.customer_segment order by a.account_balance desc) as Balance_quartile
from customers c inner join	 accounts a on c.customer_id = a.customer_id;



-- TASK 9 : "Find the previous and next transaction amount for each account, ordered by transaction date (Window Value Functions).
-- Additionally, provide details such as Account ID and Transaction Date."

select 
	account_id,transaction_id,transaction_date,transaction_amount,
    lag(transaction_amount) over(partition by account_id order by transaction_date) as Prev_Amount,
    lead(transaction_amount) over(partition by account_id order by transaction_date) as Next_Amount
from transactions ;



-- TASK 10 : Find the first and last transaction amount for each account (Window Value Functions).

select 
	account_id,transaction_id,transaction_date,transaction_amount,
    first_value(transaction_amount) over(partition by account_id order by transaction_date) as First_Transaction_Amount,
    last_value(transaction_amount) over(partition by account_id order by transaction_date 
    rows between unbounded preceding and unbounded following) as Last_Transaction_Amount
from transactions;










































































