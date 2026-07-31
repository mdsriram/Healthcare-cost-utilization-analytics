--(Advanced (36–45))

--36. Find the top 10 members by total healthcare spending.

select TOP 10
m.member_id,
m.member_name,
sum(c.paid_amount) as spend
from Members m
join claims c
on m.member_id = c.member_id
group by m.member_id,
m.member_name
order by spend desc;

--37.Rank providers by total reimbursement.

WITH provider_spending AS
(
SELECT
provider_id,
SUM(paid_amount) AS total_reimbursement
FROM Claims
GROUP BY provider_id
)

SELECT *,
RANK() OVER(
ORDER BY total_reimbursement DESC
) AS provider_rank
FROM provider_spending;

--Find the most common diagnosis for each county.
WITH diagnosis_count AS
(
SELECT
m.county,
c.diagnosis_code,
COUNT(*) AS total
FROM Members m
JOIN Claims c
ON m.member_id=c.member_id
GROUP BY
m.county,
c.diagnosis_code
)

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY county
ORDER BY total DESC
) AS rn
FROM diagnosis_count;

--Find providers with above-average reimbursement.
with providers_reim as
(
select provider_id,
sum(paid_amount) as reimbur
from claims
group by provider_id
)
select *
from providers_reim
where reimbur >
(select avg(reimbur)
from providers_reim)

--Calculate cumulative monthly healthcare spending.
with cumm_monthly as
(
select
year(claim_date) as year,
month(claim_date) as month,
sum(paid_amount) as spending
from Claims
group by year(claim_date),
month(claim_date)
)
select *,
sum(spending) over(
order by year, month
ROWS UNBOUNDED PRECEDING

) as cummulative 
from cumm_monthly

--Find members with more than one admission.

select m.member_id, m.member_name,
count(*) as admission_count
from Members m
join Admissions a
on m.member_id = a.member_id
group by m.member_id, m.member_name
having count(*) > 1
order by admission_count desc;

--Find providers whose average claim cost exceeds the overall provider average.
with providers_avg_cost as
(
select p.provider_name,
avg(c.paid_amount) as avg_claim_cost
from Claims c
join Providers p
on c.provider_id = p.provider_id
group by p.provider_name
)
select *
from providers_avg_cost
where avg_claim_cost > 
(select avg(avg_claim_cost)
from providers_avg_cost)

--Rank procedures by total reimbursement within each category.
with procedure_rank as
(
select pl.procedure_category,
pl.procedure_name,
sum(c.paid_amount) as spend
from Claims c
join Procedure_Lookup pl
on c.procedure_code = pl.procedure_code
group by pl.procedure_category,pl.procedure_name
)
select *,
ROW_NUMBER() over(
PARTITION BY procedure_category
order by spend
) as rk
from procedure_rank

--Calculate the percentage of spending by claim type.

select claim_type,
sum(paid_amount) as spend,
100.0 * 
sum(paid_amount) /
(select sum(paid_amount)
 from Claims) as spend_percentage
from Claims
group by claim_type


--Find the highest-paid claim for every provider.
with provider_claims as
(
select provider_id,
claim_id,
paid_amount,
ROW_NUMBER()
OVER(
PARTITION BY provider_id
ORDER BY paid_amount DESC
) AS rn
from Claims
)
select *
from provider_claims
where rn =1