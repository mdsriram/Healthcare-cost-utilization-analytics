USE [healthcare_analytics]
GO

/****** Object:  View [dbo].[vw_ProviderScorecard]    Script Date: 7/17/2026 10:34:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*3. vw_ProviderScorecard

One row per provider.

Columns
Column
provider_id
provider_name
specialty
facility_name
network_status
Total Claims
Total Admissions
Unique Members
Total Reimbursement
Average Claim Cost
Average LOS
Denial Rate

Power BI visuals:

Provider Ranking
Provider Table
Specialty Comparison
Network Performance*/

Alter VIEW [dbo].[vw_ProviderScorecard] AS

WITH ClaimSummary AS
(
    SELECT
        provider_id,
        COUNT(claim_id) AS TotalClaims,
        COUNT(DISTINCT member_id) AS UniqueMembers,
        SUM(paid_amount) AS TotalReimbursement,
        AVG(paid_amount) AS AvgClaimCost,
       
        SUM(CASE
                WHEN claim_status = 'Denied' THEN 1.0
                ELSE 0
            END) / COUNT(*) AS DenialRate
    FROM Claims
    GROUP BY provider_id
),

AdmissionSummary AS
(
    SELECT
        provider_id,
        COUNT(admission_id) AS TotalAdmissions,
        AVG(DATEDIFF(day, admission_date, discharge_date)) AS AvgLOS
    FROM Admissions
    GROUP BY provider_id
)

SELECT
    p.provider_id,
    p.provider_name,
    p.specialty,
    p.facility_name,
    p.city,
    p.state,
    p.network_status,

    ISNULL(cs.TotalClaims,0) AS TotalClaims,
    ISNULL(ad.TotalAdmissions,0) AS TotalAdmissions,
    ISNULL(cs.UniqueMembers,0) AS UniqueMembers,
    ISNULL(cs.TotalReimbursement,0) AS TotalReimbursement,
    ISNULL(cs.AvgClaimCost,0) AS AvgClaimCost,
    ISNULL(ad.AvgLOS,0) AS AvgLOS,
    ISNULL(cs.DenialRate,0) AS DenialRate

FROM Providers p

LEFT JOIN ClaimSummary cs
ON p.provider_id = cs.provider_id

LEFT JOIN AdmissionSummary ad
ON p.provider_id = ad.provider_id;
GO


