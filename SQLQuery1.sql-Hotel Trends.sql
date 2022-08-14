-- inital business questions: 
-- #1) Is the hotel's annual revenue growing?
-- #2) Should the hotel's parking lot increase in size?
-- #3) What trends do we see in the data?

--join tables

select * from dbo.['2018$']
union 
select * from dbo.['2019$']
union
select * from dbo.['2020$']
go

--Q#1) exploratory data analysis using SQL 
--create temporary table

with hotels as (
select * from dbo.['2018$']
union 
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels

--no revenue column, but do have ADR and total stays in week nights and weekend night. create a new column in order to see revenue. 
--add total stays in weekends and week night columns, then multiple by ADR (daily rate for hotel)= cost of revenue, give column a name
go 
with hotels as (
select * from dbo.['2018$']
union 
select * from dbo.['2019$']
union
select * from dbo.['2020$'])
select (stays_in_week_nights + stays_in_weekend_nights) * adr as Revenue
from hotels

-- is this increasing by year? add arrival date year colunmn, sum by year, group by year = revenue by year. #Q. revenue is growing
go 
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select arrival_date_year, sum ((stays_in_week_nights + stays_in_weekend_nights) * adr) as Revenue 
from hotels
group by arrival_date_year

--we want revenue by hotel type. add column

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select arrival_date_year, hotel,
sum ((stays_in_week_nights + stays_in_weekend_nights) * adr) as Revenue 
from hotels
group by arrival_date_year, hotel

go
---- round revenue to 2 decimal places

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select arrival_date_year, hotel,
round (sum ((stays_in_week_nights + stays_in_weekend_nights) * adr),2) as Revenue 
from hotels
group by arrival_date_year, hotel

go
select * from dbo.market_segment$  --shows discounts to each market segment.....join this table to temporary 'hotels'table via market segment column
go 
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels
left join dbo.market_segment$ 
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$ 
on meal_cost$.meal =hotels.meal

--querries imported to PWR.BI for viz