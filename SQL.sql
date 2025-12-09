create database Food_delivery;
use Food_delivery;

create table customer(
C_id int primary key auto_increment,
C_Name varchar(30) not null,
C_City varchar(20)
);

create table resturent(
r_id int primary key auto_increment,
r_Name varchar(30) not null,
Cuisine varchar(50)
);

create table orders(
or_id int primary key,
C_id int,
r_id int,
or_amount int,
or_date date,
foreign key(C_id)references customer(C_id),
foreign key(r_id)references resturent(r_id)
);

insert into customer(C_Name,C_City) values("Ganesh","Bangalore"),("Akula","Chennai"),("MRCE","Mumbai"),("Jeevan","Hyderabad"),("Sai Likith","Bangalore"),("Sai charan","Mumbai"),("Sharan","Chennai"),("Aman","Hyderabad"),("Nithish","Chennai"),("Janaki","Mumbai");
select * from customer;

insert into resturent(r_Name,Cuisine) values("Sai Ram","Indian");
alter table resturent
auto_increment = 101;
select * from resturent;
delete from resturent 
where r_id=1;

insert into orders values(1009,4,102,800,"2025-10-07"),(1010,5,110,6969,"2025-12-16");

update orders
set r_id=1001 where or_id=1;
SET SQL_SAFE_UPDATES = 0;
select * from orders;



print(#total revenue of all orders) 

select sum(or_amount) as revenue from orders;

print("which resturent earned most")

select r.r_Name,sum(o.or_amount)as Resturent_revenue from orders o
join resturent r on r.r_id = o.r_id
group by r.r_Name
order by Resturent_revenue desc
limit 1;

print(#which custmor spent more money)

select c.C_Name, sum(o.or_amount) as Cust_Most from orders o
join customer c on o.C_id = c.C_id
group by c.C_Name
order by Cust_Most desc
limit 1;

#no.of order per Cuisine 

select r.Cuisine,count(o.or_amount) as Total_Cuisene from orders o
join resturent r on o.r_id = r.r_id
group by r.Cuisine;

# which place has most no.of orders

select c.C_City,count(o.or_amount) as Top_City from orders o
join customer c on o.C_id = c.C_id
group by c.C_City;

#What is the average order amount per restaurant?

select r.r_Name,round(avg(o.or_amount),2) as avg_order from orders o
join resturent r on r.r_id = o.r_id
group by r.r_Name;

#which month has highest 

select date_format(o.or_date,'%y - %m'),sum(o.or_amount) as Monthly from orders o
group by date_format(o.or_date,'%y - %m')
order by Monthly;

#List customers who placed more than 1 order.

select c.C_Name,count(o.or_id) as No_of_orders from orders o
join customer c on o.c_id = c.c_id
group by c.C_Name
order by No_of_orders desc;

#top 3 highest order amounts

select r.r_Name, o.or_amount
from orders o
join resturent r on o.r_id = r.r_id
order by o.or_amount desc
limit 3;

#show tottal revenue for each resturent

select r.r_Name as Total_amount,sum(o.or_amount) as Total_Revenew from orders o
join resturent r on o.r_id = r.r_id
group by r.r_Name;

#resturnts monthly revenue

select r.r_Name as Resturent, date_format(o.or_date,'%y-%m') as Monthly,sum(o.or_amount) from orders o
join resturent r on o.r_id = r.r_id
group by date_format(o.or_date,'%y-%m'),Resturent
order by Monthly;

