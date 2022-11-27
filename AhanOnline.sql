--1.

select sum(Quantity*UnitPrice) as Totalsale
from dbo.[Sale Table]

--2.

select count(DISTINCT Customer) as CustomerCount
from dbo.[Sale Table]

--3.

select Product,count(Quantity) as QuantityCount
from dbo.[Sale Table]
Group by Product


--4.

select customer, sum(Quantity*UnitPrice) as Totalsale,COUNT(SalesID) as CountBuy,sum(Quantity) as TotalQuantity
from dbo.[Sale Table]
Group By customer
having sum(Quantity*UnitPrice) > 1500


--5.


update dbo.[Sale Profit]
set ProfitRatio = Replace(ProfitRatio,'%','')

select sum(ISNULL(ProfitRatio, 10)*UnitPrice*0.01*Quantity) AS TotalProfit,sum(convert(float,ISNULL(ProfitRatio, 10)))  AS PercentageProfit
from dbo.[Sale Table]
FULL JOIN dbo.[Sale Profit] on dbo.[Sale Profit].Product = dbo.[Sale Table].Product


-- 6.

select COUNT(distinct customer) CountCustomer,Date
from dbo.[Sale Table]
group By Date



-- 7.


CREATE TABLE chart3 (
  id int,
  fname VARCHAR(20),
  manager VARCHAR(20),
  manager_id int,
);
 
INSERT 
INTO chart3 (id, fname, manager, manager_id)
VALUES (1, 'ken', NULL, NUll),
(2, 'Hugo',	NULL	,NULL),
(3, 'James'	,'Carol	',5),
(4, 'Mark'	,'Morgan'	,13),
(5, 'Carol',	'Alex',	12),
(6, 'David',	'Rose',	21),
(7, 'Michael',	'Markos',	11),
(8, 'Brad',	'Alex',	12),
(9,'Rob',	'Matt',	15),
(10, 'Dylan',	'Alex',	12),
(11,'Markos',	'Carol',	5),
(12, 'Alex',	'Ken',	1),
(13, 'Morgan',	'Matt',	15),
(14, 'Jennifer',	'Morgan',	13),
(15, 'Matt',	'Hugo',	2),
(16, 'Tom',	'Brad',	8),
(17, 'Oliver',	'Dylan',	10),
(18,'Daniel',	'Rob',	9),
(19, 'Amanda',	'Markos',	11),
(20, 'Ana',	'Dylan',	10),
(21, 'Rose',	'Rob',	9),
(22, 'Robert',	'Rob',	9),
(23, 'Fill'	,'Morgan'	,13),
(24,'Antoan'	,'David' ,6),
(25,'Eddie',	'Mark',	4);


-- Root ken


WITH empdata AS (
  (SELECT id, fname, manager, manager_id, 1 AS level
  FROM chart3
  WHERE id = 1)
  UNION ALL
  (SELECT this.id, this.fname, this.manager, this.manager_id, prior.level + 1
  FROM empdata prior
  INNER JOIN chart3 this ON this.manager_id = prior.id)

)
SELECT e.id, e.fname, e.manager, e.manager_id, e.level
FROM empdata e
ORDER BY e.level;


-- Root Hugo

WITH empdata AS (
  (SELECT id, fname, manager, manager_id, 1 AS level
  FROM chart3
  WHERE id = 2)
  UNION ALL
  (SELECT this.id, this.fname, this.manager, this.manager_id, prior.level + 1
  FROM empdata prior
  INNER JOIN chart3 this ON this.manager_id = prior.id)

)
SELECT e.id, e.fname, e.manager, e.manager_id, e.level
FROM empdata e
ORDER BY e.level;






