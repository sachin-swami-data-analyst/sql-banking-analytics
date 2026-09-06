/* ==============================================================================================================================
              BANKING DOMAIN PROJECT : SUBQUERY , CTE(COMMON TABLE EXPRESSION),VIEW
================================================================================================================================*/
/*==============================================================================================================================
													A) SUBQUERY : 
===============================================================================================================================*/
-- TASK 1 : Find accounts with a balance greater than the average balance of all accounts (Use Subquery).

select 
	account_id,account_type,account_balance
from accounts 
where account_balance > (select avg(account_balance) from accounts) ;


-- TASK 2 : Find customers who own at least one account (Use Subquery with IN).

select
	customer_id,first_name,customer_segment
from customers
where customer_id in (select customer_id from accounts);


-- TASK 3 : "Find the highest balance recorded at each account's branch (Use Correlated Subquery).
-- Additionally, provide details such as Account ID and Branch Name."

select 
	account_id,branch_name,account_balance,
    (select max(a2.account_balance)
    from accounts a2
    where a2.branch_name = a1.branch_name ) as Branch_Highest_Balance
from accounts a1;

/* ===============================================================================================================================
                                         B) CTE(COMMON TABLE EXPRESSION)
=================================================================================================================================*/
-- TASK 4 : Find customers whose total balance across all accounts is greater than 500000 (Use CTE).

with CTE_CustomerTotals as (
select 
	 c.customer_id,c.first_name,c.last_name,
     sum(a.account_balance) as Total_balance
from customers c inner join accounts a on c.customer_id = a.customer_id
group by c.customer_id,c.first_name,c.last_name
)

select * from CTE_CustomerTotals where Total_balance > 500000;


-- TASK 5 : Find the top account by balance in each customer segment (Use CTE with Window Function).

with CTE_Account_Rank as (
select 
	c.customer_segment,a.account_id,a.account_balance,
    row_number() over(partition by c.customer_segment order by a.account_balance desc) as Ranking
from customers c inner join accounts a on c.customer_id = a.customer_id
)
select * 
from CTE_Account_Rank 
where Ranking = 1;


-- TASK 6 : Calculate the net cash flow (total deposits minus total withdrawals) for each account (Use Multiple CTEs).


with CTE_Deposit as (
select account_id, sum(transaction_amount) as Total_Deposit
from transactions
where transaction_type = 'Deposit'
group by account_id
),
CTE_Withdrawal as (
select 
	account_id,
    sum(transaction_amount) as Total_Withdrawal
from transactions
where transaction_type = 'Withdrawal'
group by account_id
)

select
	d.account_id,d.Total_Deposit,w.Total_withdrawal,
    d.total_deposit - ifnull(w.total_withdrawal,0) as Net_Cash_Flow
from CTE_Deposit d left join CTE_Withdrawal w on d.account_id = w.account_id;

/*======================================================================================================================================
                                               C) VIEWS : 
======================================================================================================================================*/
-- TASK 7 : Create a view showing the total balance for each customer ( Create View).

create view V_CustomerTotalBalance as
select
	c.customer_id,c.first_name,c.last_name,c.customer_segment,
    sum(a.account_balance) as Total_Balance 
from customers c inner join accounts a on c.customer_id = a.customer_id
group by c.customer_id,c.first_name,c.last_name,c.customer_segment;

select * from v_customertotalbalance;


-- TASK 8 : Create a view showing accounts that have never had a transaction (Create View).

create View V_DormantAccount as 
select
	a.account_id,a.account_type,a.account_status,a.open_date,
    t.transaction_id
from accounts a left join transactions t on a.account_id = t.account_id
where t.transaction_id is null;

select * from v_dormantaccount;

-- TASK 9 : Create a view showing successful transactions along with customer and account details (Create View).

CREATE view V_SuccessfullTransactions as
select
	t.transaction_id,t.transaction_date,t.transaction_amount,t.transaction_channel,t.transaction_status,
    a.account_type,
    c.first_name,c.last_name,c.customer_segment
from transactions t 
inner join accounts a on t.account_id = a.account_id 
inner join customers c on a.customer_id = c.customer_id
where t.transaction_status = 'Success';

select * from v_successfulltransactions where  transaction_channel = 'ATM';

/*===================================================================================================================================
											D) CTAS & Temp Tables
====================================================================================================================================*/
-- TASK 10 : Create a new table containing only Premium-segment customers (Use CTAS).

create temporary table PremiumCustomers
select 
	 customer_id,first_name,last_name,customer_segment,annual_income
from customers
where customer_segment = 'Premium';

select * from PremiumCustomers;


-- TASK 11 : "Store the total transaction amount for each account in a temporary table (Use Temp Table).
-- Additionally, find accounts with total transactions greater than 200000, then drop the temp table."

create temporary table  AccountActivity 
select
	account_id,sum(transaction_amount) as Total_Amount
from transactions
group by account_id;

select 
	a.account_id,a.account_type,a.account_balance,
    act.total_amount
from accounts a inner join AccountActivity act 
on a.account_id = act.account_id
where act.total_amount > 200000;

drop table AccountActivity;



-- TASK 12 : Create a new permanent table combining each account's details with its total transaction amount (Use CTAS).

create table AccountSummary
select 
	a.account_id,a.account_type,a.account_balance,
    ifnull(sum(t.transaction_amount),0) as Total_transaction_amount
from accounts a left join transactions t on a.account_id = t.account_id
group by a.account_id,a.account_type,a.account_balance;

select * from accountsummary;


/*===================================================================================================================================
											E) Store Prodcedure :
====================================================================================================================================*/


-- TASK 13 : Create a stored procedure to retrieve customers based on a given customer segment (Create Stored Procedure).

delimiter $$
Create procedure GetCustomerBYSegment(Segment varchar(20)) 
begin
	select 
		customer_id,first_name,last_name,customer_segment
	from customers
	where customer_segment = Segment;
end $$
delimiter ;

call GetCustomerBYSegment('Corporate');

-- TASK 14 : Create a stored procedure to retrieve the transaction history for a given Account ID (Create Stored Procedure).

delimiter $$
CREATE PROCEDURE GetAccountTransactionHistory (AccountID int)
BEGIN
	select
		account_id,transaction_id,transaction_date,transaction_type,transaction_amount,transaction_status
	from transactions
    where account_id = AccountID
    order by transaction_date;
END $$
delimiter ;

call GetAccountTransactionHistory(1006);


-- TASK 15 : Create a stored procedure to retrieve accounts with a balance below a given amount (Create Stored Procedure).

delimiter $$
CREATE procedure GetAccountBelowBalance(MinBalance decimal(12,2))
begin
	select 
		account_id,account_type,account_balance
    from accounts
    where account_balance < MinBalance ;
end  $$
delimiter ;

call GetAccountBelowBalance(300000);


/*===============================================================================================================================
                                                          F) TRIGGER :
=================================================================================================================================*/
-- TASK 16 : Create a trigger that automatically logs every new transaction into an audit table (Create Trigger).

create table TransactionAuditLog (
	audit_id int auto_increment primary key ,
    transaction_id int,
    account_id int,
    Transaction_amount Decimal(12,2),
    logged_at datetime default now()
    );


delimiter //
create trigger trg_LogNewTransaction 
after insert on transactions  for each row
begin

	insert into TransactionAuditLog(transaction_id,account_id,Transaction_amount)
    value (new.Transaction_id,new.account_id,new.transaction_amount);

end //
delimiter ;

INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, transaction_amount, transaction_channel, transaction_status, balance_after_transaction, merchant_category, description)
VALUES
    (500101, 1042, '2025-10-09 04:46:12', 'Fee', 699.37, 'ATM', 'Success', 73534.45, NULL, 'Account maintenance / service fee');

select * from transactionauditlog;


-- TASK 17 : Create a trigger that prevents inserting a transaction with a negative amount (Create Trigger).

delimiter //
create trigger trg_PreventNegativeAmount
after insert on transactions for each row
begin
	if new.transaction_amount <0 
    then signal sqlstate '45000'
    set message_text = 'Transaction amount cannot be negative'; 
	end if ;
end //
delimiter ;

INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, transaction_amount, transaction_channel, transaction_status, balance_after_transaction, merchant_category, description)
VALUES
    (500102, 1042, '2025-10-09 04:46:12', 'Fee', -699.37, 'ATM', 'Success', 73534.45, NULL, 'Account maintenance / service fee');

-- TASK 18 : Create a trigger that automatically updates the account balance when a new transaction is inserted (Create Trigger).

delimiter //
create trigger trg_UpdateAccountBalance
after insert on transactions for each row
begin
		if new.transaction_type in ( 'Withdrawal','Fee','Transfer') 
        then
			update accounts 
            set	account_balance = account_balance - new.transaction_amount
            where account_id = new.account_id;
		elseif new.transaction_type in ('Deposit','Interest Credit')
        then
			update accounts
            set account_balance = account_balance + new.transaction_amount
            where account_id = new.account_id;
		end if;
end //
delimiter ;
drop trigger trg_updateaccountbalance;

INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, transaction_amount, transaction_channel, transaction_status, balance_after_transaction, merchant_category, description)
VALUES
    (500104, 1016, '2025-10-09 04:46:12', 'Deposit', 1000, 'ATM', 'Success', 73534.45, NULL, 'Cash/cheque deposit to account');















































