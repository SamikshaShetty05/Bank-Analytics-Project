Create database Banking_Project;

#KPI 1 : Total Loan Amount Funded
SELECT SUM(`Funded Amount`) AS `Total Loan Amount Funded` FROM `banking_project`.`fact_loan`;

#KPI 2 : Total Loans
SELECT count(`ï»¿Account ID`) AS `Total Loans` FROM `banking_project`.`fact_loan`;

#KPI 3 : Total Collection
SELECT sum(`Total Rec Prncp`+`Total Rrec int`+`Total Rec Late fee`) AS `Total Collection` FROM `banking_project`.`fact_loan`;

#KPI 4 : Total Interest
SELECT sum(`Total Rrec int`) AS `Total Interest` FROM `banking_project`.`fact_loan`;

#KPI 5 : Branch-Wise Performance
SELECT B.`Branch Name`,SUM(`Total Rrec int`+`Total Fees`+`Funded Amount`) AS `Branch-Wise Performance` FROM `banking_project`.`dim_branch` B 
JOIN `banking_project`.`fact_loan` f
ON B.`ï»¿Branch ID`= F.`Branch ID`
GROUP BY B.`Branch Name` ORDER BY `Branch-Wise Performance` DESC;

#KPI 6 : State-Wise Loan
SELECT B.`State Name`,SUM(`Funded Amount`) AS `State-Wise Loan` FROM `banking_project`.`dim_branch` B 
JOIN `banking_project`.`fact_loan` f
ON B.`ï»¿Branch ID`= F.`Branch ID`
GROUP BY B.`State Name` ORDER BY `State-Wise Loan` DESC;

#KPI 7 : Religion-Wise Loan
SELECT d.Religion, sum(f.`Funded Amount`) as `Total Funded Amount` FROM `banking_project`.`dim_client` D
JOIN `banking_project`.`fact_loan` F
ON D.`ï»¿Client id` = F.`Client id`
group by d.Religion;

#KPI 8 : Product Group-Wise Loan
SELECT P.`Purpose Category`, sum(f.`Funded Amount`) as `Total Funded Amount` FROM `banking_project`.`dim_product` P
JOIN `banking_project`.`fact_loan` F
ON P.`ï»¿Product Id` = F.`Product Id`
group by P.`Purpose Category`;

#KPI 9 : Disbursement Trend
SELECT `Disbursement Date (Years)`, sum(`Funded Amount`) as `Total Funded Amount` FROM `banking_project`.`fact_loan`
group by `Disbursement Date (Years)`;

#KPI 10 : Grade-Wise Loan
SELECT `Grrade`,SUM(`Funded Amount`) AS `Grade-Wise Loan` FROM `banking_project`.`fact_loan`
group by `Grrade` ORDER BY `Grade-Wise Loan`DESC;

#KPI 11 : Default Loan Count
SELECT count(`ï»¿Account ID`) AS `Default Loan Count` FROM `banking_project`.`fact_loan`
WHERE `Is Default Loan` = 1;

#KPI 12 : Delinquent Client Count
SELECT distinct COUNT(`ï»¿Account ID`) AS `Delinquent Client Count` FROM `banking_project`.`fact_loan`
WHERE `Is Delinquent Loan` = 1;

#KPI 13 : Delinquent Loan Rate
SELECT 
    concat(ROUND(
        SUM(CASE 
                WHEN `Is Delinquent Loan` = 1 THEN 1 
                ELSE 0 
            END) 
        / COUNT(*) * 100, 
    2),"%") AS `Delinquent Loan Rate (%)`
FROM `banking_project`.`fact_loan`;

#KPI 14 : Default Loan Rate
SELECT 
    concat(ROUND(
        SUM(CASE 
                WHEN `Is Default Loan` = 1 THEN 1 
                ELSE 0 
            END) 
        / COUNT(*) * 100, 
    2),"%") AS `Default Loan Rate (%)`
FROM `banking_project`.`fact_loan`;

#KPI 15 : Loan Status-Wise Loan
select `Loan Status`, count(`ï»¿Account ID`) as `NO. of Loans` from `banking_project`.`fact_loan`
group by `Loan Status` order by `NO. of Loans` desc;

#KPI 16 : Age Group-Wise Loan
select c.`Age Group`, count(`ï»¿Account ID`) as `NO. of Loans` from `banking_project`.`fact_loan` F
join `banking_project`.`dim_client` C
ON F.`Client id` = C.`ï»¿Client id`
group by c.`Age Group` order by `NO. of Loans` desc;

#KPI 17 : Loan Maturity
select `Term Months`, count(`ï»¿Account ID`) as `NO. of Loans` from `banking_project`.`fact_loan`
group by `Term Months` order by `NO. of Loans` desc;

#KPI 18 : No Verified Loans
SELECT count(`ï»¿Account ID`) AS `Unverified Loans` FROM `banking_project`.`fact_loan`
WHERE `Verification Status` = 'Not Verified';








