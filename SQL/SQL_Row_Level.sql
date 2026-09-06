/* =======================================================================================================
      SQL BANKING DOMAIN PROJECT : (CUSTOMERS , ACCOUNT , TRANSACTIONS)
==========================================================================================================*/

-- TASK 1 : "Display the full name of each customer in a single field by merging their first and last names in uppercase (Handle Text Formatting).
-- Additionally, generate a short username using the first letter of the first name plus the last name in lowercase, and provide the length of each first name."

select customer_id,
upper(concat(trim(first_name),' ' , trim(last_name))) as Clean_full_name,
lower(concat(left(first_name,1),last_name)) as username,
length(trim(first_name)) as first_name_length
from customers;

-- TASK  2 : Update each transaction description by replacing the word 'Cash' with 'CASH' (Modify Text).

select 
	transaction_id,
    description,replace(description,'Cash','CASH') as description_updated
from transactions;

-- TASK  3 : Round every account balance to the nearest hundred (Handle Numeric Rounding).

select account_id,account_balance,
round(account_balance,-2) as rounded_to_nearest_hundred
from accounts;

-- TASK  4 : Round each account's interest rate to 1 decimal place (Handle Numeric Rounding).

select account_id,account_status,interest_rate,
round(interest_rate,1) as rounded_interest_rate,
round(coalesce(interest_rate,0),1) as Clean_interest_rate
from accounts;

-- TASK  5 : Extract the day, month, year, month name, and quarter from each transaction date, 
-- along with the last date of that month (Extract Date Parts).

select transaction_id,transaction_date,
day(transaction_date) as Txn_day,
month(transaction_date) as Txn_month,
year(transaction_date) as Txn_year,
monthname(transaction_date) as Month_name,
quarter(transaction_date) as Txn_Quarter,
last_day(transaction_date) as Month_end_data
from transactions;

-- TASK  6 : "Calculate the number of days since each account was opened and the date 30 days after opening (Date Calculations).
-- Additionally, find the start of that month, and format, convert, cast, and validate the opening date."

select 
	account_id,open_date,
    datediff(curdate(),open_date) as days_since_opening,
    date_add(open_date, interval 30 day) as grace_period,
    date_format(open_date,'%y-%m-01') as start_of_that_month,
    date_format(open_date,'%d-%M-%Y') as Nicely_formatted_date,
    convert(open_date,date) as converted_date,
    cast(open_date as datetime) as cast_as_datetime,	
		case 
			when open_date is not null then 'Valid Date'
            else 'Invalid Date'
		end as date_status
from accounts;


-- TASK  7 : Find accounts with a missing interest rate and replace it with 0, using both ISNULL and COALESCE (Handle Null Values).
-- Additionally, provide details such as Account ID and Account Type


select 
	account_id,account_type,interest_rate,
    ifnull(interest_rate,0) as ifnull_version,
    coalesce(interest_rate,0) as Coalesce_version
from accounts;

-- TASK  8 : Flag transactions of exactly 1000 by converting the amount to NULL (Handle Null Values Using NULLIF).
-- Additionally, filter the results to only transactions where the merchant category is known."

select 
	transaction_id,transaction_amount,merchant_category,
    nullif(transaction_amount,1000) as Amount_unless_exactly_1000
from transactions
where merchant_category is not null;

-- TASK  9 : Generate a report categorizing each account by balance (Categorize Data):
-- Balance > 100000 : High Balance
-- Balance Between 10000 and 100000 : Medium Balance
-- Balance < 10000 : Low Balance
-- Sort the result from lowest to highest balance."

select 
	account_id,account_balance,
    round(account_balance,-3) as rounded_balance,
    case
		when round(account_balance,-3) < 10000 then 'Low Balance'
        when round(account_balance,-3) between 10000 and 100000 then 'Medium Balance'
        else 'High Balance'
	end as Balance_Calegory
from accounts
order by account_balance asc;

-- TASK  10 : Label each transaction as MONEY IN, MONEY OUT, or TRANSFER based on its transaction type,
-- and display the label in uppercase (Categorize Data).

select 
	transaction_id,transaction_type,
upper(case 
		when transaction_type in ('Deposit','Interest Credit') then 'Money In'
		when transaction_type in ('Withdrawal','Fee') then 'Money Out'
        when transaction_type = 'Transfer' then 'Transfers'
	end) as Plain_English_Tag
from transactions;




















































