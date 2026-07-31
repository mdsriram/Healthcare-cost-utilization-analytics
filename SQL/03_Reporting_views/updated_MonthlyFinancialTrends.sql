USE [healthcare_analytics]
GO

/****** Object:  View [dbo].[vw_MonthlyFinancialTrends]    Script Date: 7/22/2026 1:43:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER view [dbo].[vw_MonthlyFinancialTrends] as

with MonthlySumaary as
(
 select
      year(claim_date) as ClaimYear,
      month(claim_date) as ClaimMonth,

      count(claim_id) as TotalClaims,
      sum(paid_amount) as MonthlySpend,
      avg(paid_amount) as AvgClaimCost
 from Claims
 group by year(claim_date), month(claim_date)
 )

 select
   ClaimYear,
   ClaimMonth,
   DATENAME(month, DATEFROMPARTS(ClaimYear, ClaimMonth, 1)) as MonthName,
   DATEFROMPARTS(
   ClaimYear,
   ClaimMonth,
   1
   ) as MonthDate,
   TotalClaims,
   MonthlySpend,
   AvgClaimCost,

   SUM(MonthlySpend)
   over(
       order by ClaimYear, ClaimMonth
   ) as RunningTotal,

   AVG(MonthlySpend)
   over(
      order by ClaimYear, ClaimMonth
      rows between 2 preceding and current row
   ) as Rolling3monthAvg,

  100.0 * 
  (MonthlySpend- lag(MonthlySpend) over(order by ClaimYear, ClaimMonth) )
  /
  lag(MonthlySpend) over(order by ClaimYear, ClaimMonth) as YOYGrowth

 from MonthlySumaary
GO


