-------------------------------------------------
--1.How many members are currently enrolled?
------------------------------------------------

select count(*) as member_count
from Members
where enrollment_end is null;

-----------------------------------------
--List all members enrolled in the Premium plan.

select member_id
from Members
where plan_type= 'Premium'

-------------------------------------------------
--Show all claims submitted in March 2025.

select *
from claims
where claim_date >= '2025-03-01'
and claim_date < '2025-04-01'

--------------------------------------
--4. Which providers are out-of-network?

select provider_id, provider_name
from Providers
where network_status = 'out-of-network'

----------------------------------------
--5.Find members older than 65 years.
-- i dont have age column , i have dob 

select member_id
from Members
where datediff(
year,
dob,
GETDATE()) >= 65
group by member_id

--6. Show the top 10 highest paid claims.

select top 10
claim_id,
paid_amount
from Claims
order by paid_amount desc;

--------------------------------------

--7.List all denied claims.

select *
from Claims
where claim_status ='Denied'

--8.Which counties have the highest number of enrolled members?

select county,
count(*) as enrolled_members
from Members
where enrollment_end is null
group by county
order by enrolled_members desc;

--9.Show all ER claims.

select 
*
from claims
where claim_type ='ER'

--List providers specializing in Cardiology.

select provider_id,
specialty
from Providers
where specialty = 'Cardiology'

--Calculate the total paid amount by claim type.

select claim_type,
SUM(paid_amount) as total_paid_amount
from Claims
group by claim_type
order by total_paid_amount desc;

--12.Find the average paid amount for each provider.

select provider_id,
AVG(paid_amount) as avg_amount
from Claims
group by provider_id
order by avg_amount desc;

--13. Which provider submitted the most claims?

select Top 1
provider_id,
count(*) as claim_count
from Claims
group by provider_id
ORDER BY claim_count DESC;

--How many claims were denied for each provider?

select provider_id,
count(*) as denied_claims
from Claims
where claim_status = 'Denied'
group by provider_id

--15.Find providers whose total paid amount exceeds $100,000.

select provider_id,
sum(paid_amount) as total_paid_amount
from Claims
group by provider_id
having sum(paid_amount) > 100000
order by total_paid_amount desc;

--Calculate total healthcare spending by county.

select m.county,
sum(c.paid_amount) as spending
from Members m
join Claims c
on m.member_id = c.member_id
group by m.county
order by spending desc;

--Find average hospital length of stay by admission type.

select admission_type,
avg(
DATEDIFF(
day,
admission_date,
discharge_date)
)as los
from Admissions
group by admission_type
order by los desc;

--Which diagnosis codes generated the highest spending?

select diagnosis_code,
SUM(paid_amount) as spending
from Admissions
group by diagnosis_code
order by spending desc;

--Calculate PMPM (Per Member Per Month) by plan type.

select m.plan_type,
SUM(c.paid_amount)
/ count(distinct m.member_id) as pmpm
from Members m
join claims c
on m.member_id = c.member_id
group by m.plan_type

--Find providers with more than 25 admissions.

select provider_id,
count(*) as admission_count
from Admissions
group by provider_id
having count(*) > 25