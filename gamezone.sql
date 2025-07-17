create database gamezone;
use gamezone;
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
SHOW VARIABLES LIKE 'secure_file_priv';
set global local_infile = 1;
SET SQL_SAFE_UPDATES = 0;

############## membuat table orders
create table orders
(
USER_ID VARCHAR(155),
ORDER_ID VARCHAR(155),
PURCHASE_TS TEXT,
SHIP_TS TEXT,
PRODUCT_NAME VARCHAR(155),
PRODUCT_ID VARCHAR(155),
USD_PRICE DECIMAL (10,2),
PURCHASE_PLATFORM VARCHAR(155),
MARKETING_CHANNEL VARCHAR(155),
ACCOUNT_CREATION_METHOD VARCHAR (155),
COUNTRY_CODE VARCHAR (50)
);

select
	*
from
	orders;
    
####### memasukan data csv ke sql
set global local_infile = 1;
load data local infile 'C:/Data housing/gamezone.csv'
into table orders
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines;

select
	*
from
	orders;
    
############################ DATA CLEANING #######################

-- 1. create a new table for staging
create table orders2
like orders;

insert into orders2
select * from orders;


#### Remove Duplicates ####
with duplicates as
(
select
	*,
    row_number() over(partition by
    order_id,
    purchase_ts,
    ship_ts,
    product_name,
    product_id,
    usd_price,
    purchase_platform,
    marketing_channel,
    account_creation_method,
    country_code) as row_num
from
	orders2
)
select
	*
from
	duplicates
where
	row_num >1;

-- 1. buat table baru untuk menghapus duplicate 
create table orders3
(
USER_ID VARCHAR(155),
ORDER_ID VARCHAR(155),
PURCHASE_TS TEXT,
SHIP_TS TEXT,
PRODUCT_NAME VARCHAR(155),
PRODUCT_ID VARCHAR(155),
USD_PRICE DECIMAL (10,2),
PURCHASE_PLATFORM VARCHAR(155),
MARKETING_CHANNEL VARCHAR(155),
ACCOUNT_CREATION_METHOD VARCHAR (155),
COUNTRY_CODE VARCHAR (50),
ROW_NUM INT
);

insert into orders3
select
	*,
    row_number() over(partition by
    order_id,
    purchase_ts,
    ship_ts,
    product_name,
    product_id,
    usd_price,
    purchase_platform,
    marketing_channel,
    account_creation_method) as row_num
from
	orders2;

select
	*
from
	orders3
where
	row_num > 1;

delete
from orders3
where row_num > 1;


#### Standardize ####

-- 1. memotong purhcase_ts yang ada time nya menjadi date aja menggunakan substring_index
select
	*
from
	orders3;

select
	distinct purchase_ts,
    str_to_date(purchase_ts, '%d/%m/%Y'),
    substring_index(purchase_ts, ' ', 1)
from
	orders3
where
	str_to_date(purchase_ts, '%d/%m/%Y') is null;

update orders3
set purchase_ts = substring_index(purchase_ts, ' ', 1);


-- 2. menghapus purchase_ts yang formatnya m d y dan mengahpus yang blank
select
	purchase_ts,
    str_to_date(purchase_ts, '%d/%m/%Y')
from
	orders3
where
	str_to_date(purchase_ts, '%d/%m/%Y') is null;
    
delete
from orders3
where purchase_ts LIKE '%-%-%';

delete
from orders3
where purchase_ts = '';

-- 3. mengganti format purchase_ts menjadi format date yang benar

update orders3
set purchase_ts = str_to_date(purchase_ts, '%d/%m/%Y');

select * from orders3;

-- 4. mengganti format ship_ts menjadi format date yang benar
update orders3
set ship_ts = str_to_date(ship_ts, '%d/%m/%Y');

select * from orders3;
-- 5. mengganti tipe data purchase_ts dan ship_ts
alter table orders3
modify column purchase_ts DATE;

alter table orders3
modify column ship_ts DATE;

-- 5. standardize product name 27inches 4k gaming monitor jadi 27in 4K gaming monitor
select
	distinct product_name
from	
	orders3
order by 1;

update orders3
set product_name = '27in 4K gaming monitor'
where product_name like '27inch%';

-- 6. ada harga barang yang 0 usdprice
select
	distinct(usd_price)
from
	orders3
order by 1;


-- 7. standardize blank values menjadi unkown
select
	distinct marketing_channel
from
	orders3
order by 1;

update orders3
set marketing_channel = 'unknown'
where marketing_channel = '';

-- 8.standardize blank values menjadi unkown
select
	distinct account_creation_method
from
	orders3
order by 1;

update orders3
set account_creation_method = 'unknown'
where account_creation_method = '';

-- 9.
select
	*
from
	orders3
where
	marketing_channel = 'unknown' and account_creation_method = 'unknown'
order by 1;


#### remove null or blank values ####
select
	*
from
	orders3;
    
#### drop unnecessary column ####

alter table orders3
drop column row_num;

##################################### EDA ###############

SELECT
	*
FROM
	ORDERS3;
-- Query 1 total sales
select
	sum(usd_price)
from
	orders3;

-- Query 2 yearly sales
select
	year(purchase_ts) as calendar_year,
    sum(usd_price) as sales
from
	orders3
group by 1;
    

-- Query 3 product sales

select
	product_name,
    sum(usd_price) as sales
from
	orders3
group by 1	
order by 2 desc;

-- Query 4 marketing channel sales
select
	marketing_channel,
    sum(usd_price) as sales,
    rank() over(order by sum(usd_price) desc) as ranking
from
	orders3
group by 1;

-- Query 5 sales per year and month
select
	year(purchase_ts) as calendar_year,
    month(purchase_ts) as calendar_month,
    sum(usd_price) as sales,
    rank() over(order by sum(usd_price)desc) as ranking
from
	orders3
group by
	1,2
order by
	3 desc;

-- Query 6 year&month sales growth
with year_month_sales as
(	
select
	year(purchase_ts) as calendar_year,
    month(purchase_ts) as calendar_month,
    sum(usd_price) as sales
from
	orders3
group by
	1,2
order by
	3 desc
),
growth as
(
select
	calendar_year,
    calendar_month,
    sales,
    lag(sales) over(order by calendar_year, calendar_month) as prev_sales,
    round(
    (sales-lag(sales) over(order by calendar_year, calendar_month)) /
    lag(sales) over(order by calendar_year, calendar_month) * 100 ,2
    ) as percentage
from
	year_month_sales
)

select
	*
from
	growth;

-- Query 7 product sales by year and month growth
with monthly_sales as
(
select
	year(purchase_ts) as calendar_year,
    month(purchase_ts) as calendar_month,
    product_name,
    sum(usd_price) as sales
from
	orders3
group by 1,2,3
order by 4 desc
),
growth as
(
select
	calendar_year,
    calendar_month,
    product_name,
    sales,
    lag(sales) over(partition by product_name order by calendar_year, calendar_month) as prev_sales,
    round(
    (sales - lag(sales) over(partition by product_name order by calendar_year, calendar_month)) / 
    lag(sales) over(partition by product_name order by calendar_year, calendar_month) * 100,2
    ) as percentage
from
	monthly_sales
)
select
	*
from
	growth;

select * from orders3;
-- Query 8 AOV
SELECT
  YEAR(purchase_ts) AS year,
  MONTH(purchase_ts) AS month,
  ROUND(SUM(usd_price) / COUNT(DISTINCT order_id), 2) AS AOV
FROM orders3
GROUP BY year, month
ORDER BY year, month;



select * from orders3;

SELECT distinct usd_price FROM orders3 



