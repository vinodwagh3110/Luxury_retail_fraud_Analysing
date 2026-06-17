create database Fraud_Anaysis;

use Fraud_Anaysis;

-- Enter data from csv file 

-- Change the table name 

alter table `new clean data`
rename to Fraud_analysis;

select * from Fraud_analysis;

-- 1. Total transactions
SELECT COUNT(*) AS total_transactions
		FROM Fraud_analysis;

		-- We can see that in it total 2133 Transactions occur
        
-- 2. Missing Customer Age values
SELECT COUNT(*) AS missing_customer_age
FROM Fraud_analysis
WHERE Customer_Age IS NULL;
		-- We can see in it Missing customer it is 0
        
-- 3. Unique Customers and Stores
SELECT COUNT(DISTINCT Customer_ID) AS unique_customers,
       COUNT(DISTINCT Store_ID) AS unique_stores
FROM Fraud_analysis;

		-- we see that no of Unique_Customers = 2133 and unique_Stores = 10

-- 4. Fraud vs Non-Fraud
select Fraud_Flag, count(*) as Count 
	from Fraud_analysis 
    group by Fraud_Flag;
		
        -- we see that no of Fraud = 66 and Non-Fraud = 2067
        
-- 5. Fraud by Payment Method
select Payment_Method,sum(Fraud_Flag) as Fraud_trans, count(*) as count , sum(Fraud_Flag)*100/count(*) as Fraud_Percentage 
	from Fraud_analysis
    group by Payment_Method
    order by Fraud_trans desc;
		
        -- we see that " Debit_Card > Gift_Card > Mobile_Payment > Credit_Card > Others " occures fraud 
    
-- 6. Fraud by Location
select Location ,sum(Fraud_Flag) as Fraud_trans, count(*) as count , sum(Fraud_Flag)*100/count(*) as Fraud_Percentage 
	from Fraud_analysis
    group by Location
    order by Fraud_trans desc;
    
		-- we see that more fraud occur " Las Vegas Placeit is 8 " 
    
-- 7. Fraud by Loyality_trier
select Customer_Loyalty_Tier ,sum(Fraud_Flag) as Fraud_trans, count(*) as count , sum(Fraud_Flag)*100/count(*) as Fraud_Percentage 
	from Fraud_analysis
    group by Customer_Loyalty_Tier
    order by Fraud_trans desc;
    
		-- fraud by loyality tier "Bronze > Silver > Gold > Platinum > VIP > Other "

-- 8. Average spend by Loyalty Tier
select Customer_Loyalty_Tier, avg(Purchase_Amount) as Average_Amount 
	from Fraud_analysis
    group by Customer_Loyalty_Tier
    order by Average_Amount desc;
    
		-- Avg amount spend by loyality_tier ' others > Bronze >Silver > VIP > Gold > Platinum '
    
-- 9. Age group fraud patterns
			select  case 
						when Customer_Age < 25 then "Under 25"
                        when Customer_Age between 25 and 40 then '25-40'
                        when Customer_Age between 41 and 60 then '41-60'
                        else '60+'
                        end as Age_Group ,
                        sum(Fraud_Flag) as Fraud_Flag,
                        count(*) as Total_Transactions ,
                        sum(Fraud_Flag)*100/count(*) as Fraud_Percentage 
				from Fraud_analysis
				group by Age_Group
				order by Fraud_Flag desc;
                
                -- we see that the fraud occur by age group 41-60 > 25-40 > under 25 > 60+ we can see more fraud occur in 41-60 age Group

-- 9. Fraud Transactions Trend (by Month)
select monthname(Transaction_Date) as Month, sum(Fraud_Flag) as Count
		from Fraud_analysis
        group by  monthname(Transaction_Date)
        order by Count desc;
        
				-- In July Month  occurs more Frauds Compare to others 
        
-- 11. Average Footfall by Store
select Store_ID, avg(Footfall_Count) as Avgerage
			from Fraud_analysis
            group by Store_ID
            order by Avgerage desc;
            
            -- Average Foot_count by Store_id 
            
-- 12. Store Performance with Fraud %
select Store_ID, sum(Fraud_Flag) as Fraud_Flag, sum(Fraud_Flag)*100 / count(*) as Fraud_percentage
			from Fraud_analysis
            group by Store_ID
            order by Fraud_Flag desc;
            
            -- We can see that in that in which store happen more Fraud 
            