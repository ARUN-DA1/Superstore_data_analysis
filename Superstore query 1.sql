show databases;
show tables;
select * from mytable;
show columns from mytable;
-- 1. Which product category generates the highest revenue?
select product_line, round(sum(gross_income)) as Revenue from mytable
group by product_line
order by revenue desc limit 1;

-- 2 .Which gender(men/women) makes the highest profit margin?
select gender , round(avg(gross_income)) as high_margin from mytable
group by gender;

-- 3. Which products are loss-making?
select product_line, round(avg(gross_income)) as loss_making from mytable
where gross_margin_percentage <=(select avg(gross_income) from mytable)
group by product_line
order by loss_making asc limit 1;

-- 4. customers from which city orders the most?
select city, count(city) as purchase_count from mytable
group by city
order by purchase_count desc;

-- 5. Top 2 products with higest avg review rating?
select product_line ,round(avg(customer_rating),1)as average_rating from mytable
group by product_line
order by average_rating desc;

-- 6. average purchase amount with the payment types
select payment_type, round(avg(gross_income),1) as average_revenue from mytable
group by payment_type 
order by average_revenue desc ;

-- 7. which brance has the most top rated product
select branch, count(rating_category) as count from mytable
where rating_category ='Top Rated'
group by branch
order by count desc;
 
 -- 8.compare the customer type with the avg margin and total revenue
 select customer_type ,count(invoice_id) as order_count ,round(avg(gross_margin_percentage),1), round(sum(gross_income),1) as total_revenue from mytable
 group by customer_type;
 
 -- 9. find the product category having high purchase percentage wihtw the wallet payment?
 select product_line, round(100*sum(case when payment_type= 'Digital' then 1 else 0 end)/count(*),2) as purchase_percentage from mytable
 group by product_line;
 
 
-- 10. Create Rating into bad, average, good based on the rating value and show the each segment?
with tablenew as (
select invoice_id, customer_rating,
case
 when customer_rating <=4 then 'bad'
 when customer_rating between 5 and 7 then 'average'
else 'good'
end as Rating from mytable)

select rating, count(rating)as total from tablenew
group by rating;
 


