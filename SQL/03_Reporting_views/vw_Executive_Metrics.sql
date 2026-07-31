

CREATE VIEW vw_Executive_Metrics AS

SELECT

    (SELECT COUNT(*)
     FROM Members) AS TotalMembers,

    (SELECT COUNT(*)
     FROM Members
     WHERE enrollment_end IS NULL) AS ActiveMembers,

    (SELECT COUNT(*)
     FROM Claims) AS TotalClaims,

    (SELECT COUNT(*)
     FROM Admissions) AS TotalAdmissions,

    (SELECT SUM(paid_amount)
     FROM Claims) AS TotalPaidAmount,

    (SELECT AVG(paid_amount)
     FROM Claims) AS AverageClaimCost,

    (
    SELECT
    SUM(CASE WHEN claim_status='Denied' THEN 1.0 ELSE 0 END)
    /
    COUNT(*)
    FROM Claims
    ) AS DenialRate,

    (
    SELECT
    SUM(paid_amount)
    /
    COUNT(DISTINCT member_id)
    FROM Claims
    ) AS PMPM;

    select *
    from vw_Executive_Metrics