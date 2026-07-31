--Which HCC categories account for the highest percentage of healthcare spending?
with healthcare_spending as
(
select h.hcc_category,
sum(c.paid_amount) as spend
from claims c
join HCC_Mapping h
on c.diagnosis_code = h.diagnosis_code
group by h.hcc_category
)
select *,
100.0 *
sum(spend)/
(select sum(spend) from healthcare_spending) as spending_percentage
from healthcare_spending
order by spending_percentage desc;

--Which providers have the highest average DRG weight?
with highest_drg as
(
select p.provider_id,
p.provider_name,
AVG(a.drg_weight) as avg_drg
from Providers p
join Admissions a
on p.provider_id = a.provider_id
group by p.provider_id, p.provider_name
)
select * from
(
select *,
DENSE_RANK() over(order by avg_drg) as rk
from highest_drg
)t
where rk =1

--Which members have the highest risk score based on all their diagnoses?
with highest_score as
(
select c.diagnosis_code,
c.member_id,
sum(h.risk_weight) as risk_score
from claims c
join HCC_Mapping h
on c.diagnosis_code = h.diagnosis_code
group by c.diagnosis_code, c.member_id
)
select * from
(
select *,
DENSE_RANK() over(
order by risk_score) as r
from highest_score
)t
where r =1

--Identify members readmitted within 30 days of discharge.
WITH readmission AS
(
SELECT
member_id,
admission_date,
discharge_date,

LAG(discharge_date)
OVER(
PARTITION BY member_id
ORDER BY admission_date
) AS previous_discharge

FROM Admissions
)

SELECT *
FROM readmission
WHERE DATEDIFF(day,
previous_discharge,
admission_date)<=30;

--Create a Provider Performance Scorecard containing:

select p.provider_id,
p.provider_name,


count(distinct c.member_id
) as unique_member,

count(c.claim_id
) as total_Claims,

count(a.admission_id
) as total_admissions,

avg(c.paid_amount
) as avg_paid_claim,

SUM(c.paid_amount
) AS total_reimbursement,

avg(
datediff(
day,
a.admission_date,
a.discharge_date)
) as avg_los,


100.0 *
sum(
  case 
   when c.claim_status = 'Denied' 
   then 1
   else 0
end)/
count(*) as Denial_rate

from Providers p
left join claims c
on p.provider_id = c.provider_id

left join Admissions a
on p.provider_id = a.provider_id

group by p.provider_id,
p.provider_name

