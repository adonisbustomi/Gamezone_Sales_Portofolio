# Gamezone_Sales_Portofolio

# 🎮 GameZone Sales Analytics – SQL Project

The goal of this project is to analyze GameZone’s sales performance across all products from 2019 to 2022. The company is seeking insights to better understand overall revenue trends and help support strategic decisions across product, marketing, and finance teams. You are tasked with conducting an initial analysis to highlight key patterns in total revenue, product category performance, seasonal trends, and channel effectiveness.

---

## Dataset Structure

I only use 1 dataset that consisted of a single table orders3, including information about transaction timestamps, order amounts, product details, marketing channels, and store locations. This dataset provides sufficient context to analyze trends in revenue, product performance, and marketing effectiveness from 2019 to 2022.


---

## 🔍 Insights Summary
To drive business decisions, we focused on the Sales performance as a KPI

**1. Total Sales Performance**
- GameZone generated over $6,095,289.00 in total sales Over 3 Years.

**2. Yearly Sales Trends**
- Out of a total of $6 million in sales, the year 2020 contributed the highest amount with $4 million, followed by 2019 with $1.5 million. Sales in 2021 were significantly lower at only $500K, as the data covers just the first two months of the year.
- 
**3. Top Selling Products (By Sales)**
- The top three products 27in 4K Gaming Monitor, Nintendo Switch, and Sony PlayStation 5 Bundle, together contributed more than 80% of total sales, with individual sales of $1.95M, $1.64M, and $1.57M, respectively.
- On the other end, the lowest-performing product was the Razer Pro Gaming Headset, with only $879 in total sales. This may indicate missing or incomplete data, and it's recommended to verify this with the product team.
- 
**4. Marketing Channel Performance**
- GameZone utilizes five primary marketing channels to drive product sales: Direct, Email, Affiliate, Social Media, and Unknown sources.
- The Direct channel dominates, contributing over $5.16 million, which is 84.71% of the total sales.
Email marketing follows with $604K (9.92%), showing strong performance as a secondary channel.
Affiliate programs generated $220K (3.61%), while Social Media campaigns brought in $68K (1.13%).
Lastly, sales from Unknown sources accounted for only $38K (0.62%), which may require further tracking improvements.
- These insights suggest that while Direct and Email remain the strongest sales drivers, there may be opportunities to scale up Affiliate and Social Media channels to diversify performance.

**5. Sales Trend by Month (Yearly Aggregation)**
- An analysis of monthly sales across the dataset (2019–2021) reveals clear seasonal and campaign-related trends, with 2020 standing out as the strongest performing year overall.
- December 2020 was the peak sales month, generating $546,143, likely driven by year end promotions and holiday season demand.
- The top 10 months by sales volume were almost entirely from 2020, confirming its position as the company's most profitable year.
- This detailed breakdown can be useful for identifying peak revenue cycles, understanding marketing seasonality, and planning future campaigns around high-performing periods.
  
**6. Sales Growth by Month (Yearly Aggregation)**
- In early 2019, sales fluctuated significantly, with major growth in March (+43.26%) but steep drops in February (-19.96%) and October (-24.39%).
- February 2020 recorded an exceptional +94.33% growth, possibly due to early-year campaigns or product launches.
- During March to April 2020, growth remained positive (+63.11% in March, +16.24% in April), despite the onset of COVID-19, which likely shifted consumer behavior and digital spending patterns.
- December 2020 saw another strong surge (+42.31%), likely from holiday sales and year end promotions.
- However, sales dropped drastically in January 2020 (-47.19%) and January 2021 (-47.09%), suggesting a recurring post-holiday decline pattern.


**7. Product Sales Growth by Month (Yearly Aggregation)**
- Massive Drop in Jan 2020
Sales fell sharply across almost all products in January 2020 — e.g., Nintendo Switch down 60%, 4K Monitor down 63%, likely due to early COVID-19 disruptions.
- Huge Rebound Feb–Mar 2020
Sales surged as lockdowns began: PS5 Bundle up 77%, Dell Gaming Mouse up 308%, showing how COVID-19 boosted home entertainment spending.
- Sustained Growth Mid to Late 2020
Despite small dips mid-year, sales stayed strong and peaked in December — e.g., Nintendo Switch hit 121K units, the highest in 2020.
- Post-Holiday Crash in Early 2021
In Jan–Feb 2021, sales dropped again — often 40–60% — likely due to seasonality and market saturation after a strong 2020.

**8. Average Order Value**
- Strong Growth Over Time
AOV rose from $213.96 (Jan 2019) to $328.01 (Dec 2020) — a +53% increase, showing customers spent more per order as time progressed.
- Pandemic Impact in 2020
COVID-19 likely pushed online shopping, with noticeable spikes in AOV during March, August, October, and December 2020 — peak lockdown and holiday periods.
- Stabilization in 2021
Early 2021 shows a slight drop in AOV (~$290), suggesting consumer behavior started returning to normal after the pandemic surge.
- Upward Trend Overall
Despite some monthly dips, the overall trend is consistently upward, signaling stronger customer intent and larger basket sizes over time.





---


## 🧰 Tools Used

- **SQL (MySQL):** Data cleaning, deduplication, transformation, exploration  
- **Power BI:** Dashboard visualization
- **Excel (for CSV management)**


---


## 📊 Dashboard Preview

![dashboard](![Gamezone Sales Dashboard_page-0001](https://github.com/user-attachments/assets/e5edf7cf-a799-460c-8f53-f61e54277bf0)
![Gamezone Sales Dashboard_page-0002](https://github.com/user-attachments/assets/acb043f1-578d-42a9-8014-7e35d9ec6191)
![Marketing projek_page-0003](https://github.com/user-attachments/assets/29bb73b4-a3cc-494f-b458-e146ba7c42f8)
![Marketing projek_page-0004](https://github.com/user-attachments/assets/bca667b6-0d71-4252-ac95-8f92944708ac)
)  






