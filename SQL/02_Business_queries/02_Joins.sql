--(20-35)

--Display every claim with the member's name, plan type, and county.

select c.claim_id,
m.member_name,
m.plan_type,
m.county
from Members m
join claims c
on m.member_id = c.member_id

--Show each claim along with the provider's name and specialty.

select c.claim_id,
p.provider_name,
p.specialty
from Claims c
join Providers p
on c.provider_id = p.provider_id

--Display the diagnosis name and HCC category for every claim.

select c.claim_id,
HC.diagnosis_name,
hc.hcc_category
from claims c
join HCC_Mapping hc
on c.diagnosis_code = hc.diagnosis_code

--Show the procedure description and category for every claim.

select c.claim_id,
pl.procedure_name,
pl.procedure_category
from Claims c
join Procedure_Lookup pl
on c.procedure_code = pl.procedure_code

--Display every admission with the member name and provider name.
with member_admi as
(
select a.admission_id,
m.member_name,
a.provider_id
from Members m
join Admissions a
on m.member_id = a.member_id
)
select ma.admission_id,
ma.member_name,
p.provider_name
from member_admi ma
join Providers p
on ma.provider_id = p.provider_id
-----------
SELECT
    a.admission_id,
    m.member_name,
    p.provider_name
FROM Members m
JOIN Admissions a
    ON m.member_id = a.member_id
JOIN Providers p
    ON a.provider_id = p.provider_id;


--Calculate total paid amount by provider specialty.

select p.specialty,
sum(c.paid_amount) as spend
from Claims c
join Providers p
on c.provider_id = p.provider_id
group by p.specialty
order by spend desc;

--Find the average paid amount for each HCC category.

select 
hc.hcc_category,
avg(c.paid_amount) as avg_paid_amount
from claims c
join HCC_Mapping hc
on c.diagnosis_code = hc.diagnosis_code
group by hc.hcc_category
order by avg_paid_amount desc;

--Which procedure categories generated the highest spending?
SELECT
pl.procedure_category,
SUM(c.paid_amount) AS total_spending
FROM Claims c
JOIN Procedure_Lookup pl
ON c.procedure_code=pl.procedure_code
GROUP BY pl.procedure_category
ORDER BY total_spending DESC;

--Calculate total spending by member plan type.

select 
m.plan_type,
sum(c.paid_amount) as spending
from Members m
join claims c
on m.member_id = c.member_id
group by m.plan_type
order by spending desc;

--Find providers who treated the highest number of unique members.

select p.provider_id, p.provider_name,
count(distinct c.member_id) as unique_members
from Providers p
join Claims c
on p.provider_id = c.provider_id
group by p.provider_id, p.provider_name
ORDER BY unique_members DESC;

--Which counties generated the highest healthcare spending?

select 
m.county,
sum(c.paid_amount) as spending
from Members m
join claims c
on m.member_id = c.member_id
group by m.county
order by spending desc;

--Calculate average claim cost by provider network status.

select p.network_status,
avg(c.paid_amount) as avg_claim_cost
from Claims c
join Providers p
on c.provider_id = p.provider_id
group by p.network_status
order by avg_claim_cost desc;

--Which specialties have the highest denial rate?

select p.specialty,
100.0 *

sum(
case 
  when c.claim_status = 'Denied'
  then 1
  else 0
  end
  ) /
  count(*)  as denial_rate
from Claims c
join Providers p
on c.provider_id = p.provider_id
group by p.specialty
order by denial_rate  desc;

--Find members who had both an admission and an ER claim.


select distinct c.member_id,
claim_type
from claims c
join Admissions a
on c.member_id = a.member_id
where a.admission_id is not null
and c.claim_type= 'ER'

--Show the top 10 procedures by total paid amount.

select TOP 10
pl.procedure_name,
sum(c.paid_amount) as total_paid_amount
from Claims c
join Procedure_Lookup pl
on c.procedure_code = pl.procedure_code
group by pl.procedure_name
order by total_paid_amount desc;
