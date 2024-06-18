select * from customer

select * from credit_card


--Total Revenue
select sum(Annual_Fees + Total_Trans_Amt + Interest_Earned) as Revenue from credit_card


--Total Transaction Amount
select sum(total_trans_amt) as Amount from credit_card

--Total Transaction Volume Amount
select sum(total_trans_vol) as Total_Count from credit_card

--Total Interest Amount
select sum(interest_earned) as interest from credit_card

--Customers contributing more by gender
select gender, sum(Annual_Fees + Total_Trans_Amt + Interest_Earned) as Revenue from credit_card cr
inner join
customer cs on cr.Client_Num = cs.Client_Num
group by gender

--% of Revenue generating by card_category

with totalrevenue as
(
    select sum(annual_fees + total_trans_amt + interest_earned) as total_amount
    from credit_card
),
cardpercentages as 
(
    select 
        card_category, 
        sum(annual_fees + total_trans_amt + interest_earned) as card_amount,
        (sum(annual_fees + total_trans_amt + interest_earned) / (select total_amount from totalrevenue)) * 100 as percentage
    from credit_card
    group by card_category
)
select Card_Category, percentage
from cardpercentages

-- Revenue generating by state

select top 5 state_cd, sum(annual_fees + total_trans_amt + interest_earned) as revenue from credit_card cr
inner join
customer cs on cr.Client_Num = cs.Client_Num
group by state_cd
order by revenue desc

 