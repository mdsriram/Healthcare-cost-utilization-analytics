/*2. vw_MemberAnalytics

One row per member.

Columns
Column
member_id
member_name
age
gender
county
plan_type
Total Claims
Total Admissions
Total Paid Amount
Average Claim Cost
Risk Score
PCP Name*/

CREATE VIEW vw_MemberAnalytics AS

WITH ClaimSummary AS
(
    SELECT
        c.member_id,
        COUNT(c.claim_id) AS TotalClaims,
        SUM(c.paid_amount) AS TotalPaidAmount,
        AVG(c.paid_amount) AS AvgClaimCost,
        SUM(h.risk_weight) AS RiskScore
    FROM Claims c
    LEFT JOIN HCC_Mapping h
        ON c.diagnosis_code = h.diagnosis_code
    GROUP BY c.member_id
),

AdmissionSummary AS
(
    SELECT
        member_id,
        COUNT(admission_id) AS TotalAdmissions
    FROM Admissions
    GROUP BY member_id
)

SELECT
    m.member_id,
    m.member_name,

    DATEDIFF(YEAR, m.dob, GETDATE())
    -
    CASE
        WHEN DATEADD(YEAR,
                     DATEDIFF(YEAR, m.dob, GETDATE()),
                     m.dob) > GETDATE()
        THEN 1
        ELSE 0
    END AS Age,

    m.gender,
    m.county,
    m.plan_type,

    ISNULL(cs.TotalClaims, 0) AS TotalClaims,
    ISNULL(ad.TotalAdmissions, 0) AS TotalAdmissions,
    ISNULL(cs.TotalPaidAmount, 0) AS TotalPaidAmount,
    ISNULL(cs.AvgClaimCost, 0) AS AvgClaimCost,
    ISNULL(cs.RiskScore, 0) AS RiskScore,

    p.provider_name AS PCPName

FROM Members m

LEFT JOIN ClaimSummary cs
    ON m.member_id = cs.member_id

LEFT JOIN AdmissionSummary ad
    ON m.member_id = ad.member_id

LEFT JOIN Providers p
    ON m.pcp_id = p.provider_id;
  

  select * from vw_MemberAnalytics