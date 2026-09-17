-- SQL MINI PROJECT TASK: SUPPLY CHAIN SHIPMENT & DELIVERY SLA ANALYTICS

Create database supply_chain_db;

Use supply_chain_db;
-- BUSINESS SCENARIO:
-- A global logistics company manages thousands of customer orders, shipments,
-- warehouses, and delivery partners across different regions.
-- Management wants a SQL-based analytics solution to monitor shipment performance,
-- delivery delays, SLA compliance, warehouse efficiency, and carrier performance.
-- Students must design the database, insert sample data, and solve the following
-- business requirements using SQL.
-- TABLES TO CREATE:
-- 1. Customers
-- 2. Products
-- 3. Warehouses
-- 4. Orders
-- 5. Order_Details
-- 6. Carriers
-- 7. Shipments
-- 8. Delivery_Tracking
-- 9. Returns


-- PROJECT TASKS:

-- 1. Create all required tables with appropriate Primary Keys, Foreign Keys,
-- NOT NULL, UNIQUE, CHECK, and DEFAULT constraints.

-- 1. CUSTOMERS

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    region VARCHAR(50) NOT NULL,
    created_date DATE DEFAULT (CURRENT_DATE)
);


-- 2. PRODUCTS

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2) CHECK (unit_price > 0)
);


-- 3. WAREHOUSES

CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    region VARCHAR(50) NOT NULL
);


-- 4. ORDERS

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(20) DEFAULT 'Pending',
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    
    CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'))
);


-- 5. ORDER_DETAILS

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- 6. CARRIERS

CREATE TABLE carriers (
    carrier_id INT PRIMARY KEY,
    carrier_name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(50) NOT NULL
);


-- 7. SHIPMENTS

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    carrier_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    shipment_date DATE NOT NULL,
    expected_delivery DATE NOT NULL,
    actual_delivery DATE,
    shipment_status VARCHAR(20) DEFAULT 'In Transit',
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (carrier_id) REFERENCES carriers(carrier_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    
    CHECK (shipment_status IN ('In Transit', 'Delivered', 'Delayed', 'Cancelled'))
);


-- 8. DELIVERY_TRACKING

CREATE TABLE delivery_tracking (
    tracking_id INT PRIMARY KEY,
    shipment_id INT NOT NULL,
    tracking_date DATE NOT NULL,
    tracking_status VARCHAR(50) NOT NULL,
    location VARCHAR(100),
    
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);


-- 9. RETURNS

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    return_date DATE NOT NULL,
    return_reason VARCHAR(100),
    return_status VARCHAR(30) DEFAULT 'Requested',
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    
    CHECK (return_status IN ('Requested', 'Approved', 'Rejected', 'Completed'))
);


-- ## 2. Insert realistic sample data covering multiple:
-- 1. CUSTOMERS
INSERT INTO customers
(customer_id, customer_name, email, city, region, created_date)
VALUES
(1, 'Krishna', 'krishna@gmail.com', 'Chennai', 'South', '2025-01-10'),
(2, 'Ajju', 'ajju@gmail.com', 'Bangalore', 'South', '2025-02-15'),
(3, 'Perumal', 'perumal@gmail.com', 'Coimbatore', 'South', '2025-03-12'),
(4, 'Maheswari', 'maheswari@gmail.com', 'Hyderabad', 'South', '2025-04-18'),
(5, 'Surya', 'surya@gmail.com', 'Mumbai', 'West', '2025-05-20'),
(6, 'Ashok', 'ashok@gmail.com', 'Pune', 'West', '2025-06-11'),
(7, 'Prakash', 'prakash@gmail.com', 'Delhi', 'North', '2025-07-05'),
(8, 'Praba', 'praba@gmail.com', 'Jaipur', 'North', '2025-08-22'),
(9, 'Ram', 'ram@gmail.com', 'Kolkata', 'East', '2025-09-14'),
(10, 'Charan', 'charan@gmail.com', 'Bhubaneswar', 'East', '2025-10-08'),
(11, 'Ramesh', 'ramesh@gmail.com', 'Chennai', 'South', '2025-11-19'),
(12, 'Yuthish', 'yuthish@gmail.com', 'Mumbai', 'West', '2025-12-01');


-- 2. PRODUCTS

INSERT INTO products
(product_id, product_name, category, unit_price)
VALUES
(101, 'Laptop', 'Electronics', 65000.00),
(102, 'Monitor', 'Electronics', 22000.00),
(103, 'Keyboard', 'Accessories', 3500.00),
(104, 'Mouse', 'Accessories', 1800.00),
(105, 'Printer', 'Electronics', 18000.00),
(106, 'Headphones', 'Accessories', 4500.00),
(107, 'Tablet', 'Electronics', 30000.00),
(108, 'Webcam', 'Accessories', 5500.00),
(109, 'Router', 'Networking', 6500.00),
(110, 'SSD', 'Storage', 8500.00),
(111, 'Mobile Phone', 'Electronics', 28000.00),
(112, 'Power Bank', 'Accessories', 2500.00);


-- 3. WAREHOUSES

INSERT INTO warehouses
(warehouse_id, warehouse_name, city, region)
VALUES
(201, 'Chennai Central Warehouse', 'Chennai', 'South'),
(202, 'Bangalore Distribution Hub', 'Bangalore', 'South'),
(203, 'Hyderabad Logistics Hub', 'Hyderabad', 'South'),
(204, 'Mumbai Central Warehouse', 'Mumbai', 'West'),
(205, 'Pune Distribution Hub', 'Pune', 'West'),
(206, 'Delhi North Warehouse', 'Delhi', 'North'),
(207, 'Jaipur Distribution Hub', 'Jaipur', 'North'),
(208, 'Kolkata East Warehouse', 'Kolkata', 'East'),
(209, 'Bhubaneswar Hub', 'Bhubaneswar', 'East'),
(210, 'Coimbatore Warehouse', 'Coimbatore', 'South');


-- 4. ORDERS

INSERT INTO orders
(order_id, customer_id, warehouse_id, order_date, order_status)
VALUES
(1001, 1, 201, '2026-01-03', 'Delivered'),
(1002, 1, 201, '2026-01-10', 'Delivered'),
(1003, 1, 202, '2026-01-18', 'Delivered'),
(1004, 1, 203, '2026-02-02', 'Delivered'),
(1005, 1, 201, '2026-02-15', 'Delivered'),
(1006, 1, 202, '2026-03-01', 'Delivered'),
(1007, 2, 202, '2026-03-05', 'Delivered'),
(1008, 3, 210, '2026-03-12', 'Delivered'),
(1009, 4, 203, '2026-03-18', 'Delivered'),
(1010, 5, 204, '2026-04-02', 'Delivered'),
(1011, 6, 205, '2026-04-10', 'Delivered'),
(1012, 7, 206, '2026-04-15', 'Delivered'),
(1013, 8, 207, '2026-04-20', 'Delivered'),
(1014, 9, 208, '2026-05-01', 'Delivered');


-- 5. ORDER_DETAILS

INSERT INTO order_details
(order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 65000.00),
(2, 1002, 107, 2, 30000.00),
(3, 1003, 102, 2, 22000.00),
(4, 1004, 111, 1, 28000.00),
(5, 1005, 101, 1, 65000.00),
(6, 1006, 110, 2, 8500.00),
(7, 1007, 105, 2, 18000.00),
(8, 1008, 101, 2, 65000.00),
(9, 1009, 107, 1, 30000.00),
(10, 1010, 111, 2, 28000.00),
(11, 1011, 102, 3, 22000.00),
(12, 1012, 101, 1, 65000.00),
(13, 1013, 105, 2, 18000.00),
(14, 1014, 107, 2, 30000.00);


-- 6. CARRIERS

INSERT INTO carriers
(carrier_id, carrier_name, region)
VALUES
(301, 'BlueDart', 'South'),
(302, 'Delhivery', 'South'),
(303, 'DHL Express', 'South'),
(304, 'FedEx', 'West'),
(305, 'Ecom Express', 'West'),
(306, 'XpressBees', 'West'),
(307, 'DTDC', 'North'),
(308, 'Shadowfax', 'North'),
(309, 'Ekart', 'North'),
(310, 'Safexpress', 'East'),
(311, 'India Post', 'East'),
(312, 'Gati', 'East');


-- 7. SHIPMENTS

INSERT INTO shipments
(shipment_id, order_id, carrier_id, warehouse_id,
 shipment_date, expected_delivery, actual_delivery, shipment_status)
VALUES
(4001, 1001, 301, 201, '2026-01-04', '2026-01-08', '2026-01-08', 'Delivered'),
(4002, 1002, 302, 201, '2026-01-11', '2026-01-15', '2026-01-16', 'Delayed'),
(4003, 1003, 303, 202, '2026-01-19', '2026-01-23', '2026-01-22', 'Delivered'),
(4004, 1004, 301, 203, '2026-02-03', '2026-02-07', '2026-02-09', 'Delayed'),
(4005, 1005, 302, 201, '2026-02-16', '2026-02-20', '2026-02-20', 'Delivered'),
(4006, 1006, 303, 202, '2026-03-02', '2026-03-06', '2026-03-05', 'Delivered'),
(4007, 1007, 304, 202, '2026-03-06', '2026-03-10', '2026-03-12', 'Delayed'),
(4008, 1008, 305, 210, '2026-03-13', '2026-03-17', '2026-03-17', 'Delivered'),
(4009, 1009, 306, 203, '2026-03-19', '2026-03-23', '2026-03-25', 'Delayed'),
(4010, 1010, 304, 204, '2026-04-03', '2026-04-08', '2026-04-07', 'Delivered'),
(4011, 1011, 305, 205, '2026-04-11', '2026-04-15', '2026-04-18', 'Delayed'),
(4012, 1012, 307, 206, '2026-04-16', '2026-04-20', '2026-04-20', 'Delivered'),
(4013, 1013, 308, 207, '2026-04-21', '2026-04-25', '2026-04-27', 'Delayed'),
(4014, 1014, 310, 208, '2026-05-02', '2026-05-06', '2026-05-05', 'Delivered');


-- 8. DELIVERY_TRACKING

INSERT INTO delivery_tracking
(tracking_id, shipment_id, tracking_date, tracking_status, location)
VALUES
(5001, 4001, '2026-01-04', 'Shipment Picked Up', 'Chennai'),
(5002, 4001, '2026-01-06', 'In Transit', 'Bangalore'),
(5003, 4001, '2026-01-08', 'Delivered', 'Chennai'),

(5004, 4002, '2026-01-11', 'Shipment Picked Up', 'Chennai'),
(5005, 4002, '2026-01-13', 'In Transit', 'Bangalore'),
(5006, 4002, '2026-01-16', 'Delivered', 'Chennai'),

(5007, 4003, '2026-01-19', 'Shipment Picked Up', 'Bangalore'),
(5008, 4003, '2026-01-21', 'In Transit', 'Hyderabad'),
(5009, 4003, '2026-01-22', 'Delivered', 'Chennai'),

(5010, 4004, '2026-02-03', 'Shipment Picked Up', 'Hyderabad'),
(5011, 4004, '2026-02-05', 'In Transit', 'Bangalore'),
(5012, 4004, '2026-02-07', 'Delayed', 'Chennai'),
(5013, 4004, '2026-02-09', 'Delivered', 'Chennai'),

(5014, 4005, '2026-02-16', 'Shipment Picked Up', 'Chennai'),
(5015, 4005, '2026-02-18', 'In Transit', 'Bangalore'),
(5016, 4005, '2026-02-20', 'Delivered', 'Chennai'),

(5017, 4007, '2026-03-06', 'Shipment Picked Up', 'Bangalore'),
(5018, 4007, '2026-03-08', 'In Transit', 'Mumbai'),
(5019, 4007, '2026-03-10', 'Delayed', 'Delhi'),
(5020, 4007, '2026-03-12', 'Delivered', 'Delhi');


-- 9. RETURNS

INSERT INTO returns
(return_id, order_id, product_id, return_date, return_reason, return_status)
VALUES
(6001, 1001, 101, '2026-01-12', 'Damaged Product', 'Completed'),
(6002, 1002, 107, '2026-01-20', 'Wrong Product', 'Completed'),
(6003, 1004, 111, '2026-02-15', 'Product Defect', 'Approved'),
(6004, 1005, 101, '2026-02-28', 'Damaged Product', 'Completed'),
(6005, 1007, 105, '2026-03-20', 'Wrong Product', 'Completed'),
(6006, 1008, 101, '2026-03-25', 'Product Defect', 'Approved'),
(6007, 1009, 107, '2026-03-30', 'Damaged Product', 'Completed'),
(6008, 1010, 111, '2026-04-15', 'Wrong Product', 'Completed'),
(6009, 1011, 102, '2026-04-20', 'Product Defect', 'Approved'),
(6010, 1013, 105, '2026-05-02', 'Damaged Product', 'Completed');

-- Data check
select*from carriers;
select*from customers;
select*from delivery_tracking;
select*from shipments;
select*from returns;
select*from products;
select*from orders;
select*from warehouses;
select*from order_details;
-- 3. Display all orders along with customer name, order date, warehouse,
-- order value, and order status.


select o.order_id,c.customer_name, o.order_date, w.warehouse_name,o.order_status,
sum(od.quantity *od.unit_price) as order_value
from orders o 
left join customers c
on o.customer_id = c.customer_id
left join warehouses w
on o.warehouse_id = w.warehouse_id
left join order_details od
on o.order_id = od.order_id
Group by o.order_id, c.customer_name, o.order_date,w.warehouse_name,o.order_status;

-- 4. Find the top 10 customers based on total order value.
select o.customer_id, c.customer_name, sum(od.quantity*od.unit_price) as order_value
from orders o
join order_details od
on o.order_id = od.order_id
join customers c
on o.customer_id = c.customer_id
group by c.customer_name,o.customer_id
order by order_value desc
limit 10;


-- 5. Find customers who have never placed an order.
select c.customer_name, c.customer_id
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.customer_id is null;

-- 6. Calculate the total number of shipments by carrier.
select *from shipments;
select *from carriers;
select carrier_id, count(shipment_id) as total_shipment
from shipments
group by carrier_id;

-- 7. Identify all shipments that were delivered after the expected delivery date.
select * from shipments
where expected_delivery < actual_delivery;

-- 8. Calculate the number of delivery days for every completed shipment.
select shipment_id, datediff(actual_delivery,shipment_date)as total_days
from shipments
where actual_delivery is not null;

select *from shipments;

-- 9. Create an SLA status:
-- ON TIME
-- SLA BREACHED
## sla - service level agreement
select shipment_id, actual_delivery, expected_delivery,
case when actual_delivery <= expected_delivery then 'on time'
else 'SLA breached'
end as sla_status
from shipments
where actual_delivery is not null;


-- 10. Calculate the SLA compliance percentage for each carrier.
select*from carriers;
select carrier_id, count(shipment_id) as total_shipments,
sum(case when actual_delivery<=expected_delivery then 1
else 0
end) as on_time_shipments, 
Round((sum(case when actual_delivery<=expected_delivery then 1
else 0
end)/ count(shipment_id))*100) as sla_percentage
from shipments 
group by carrier_id;
 
-- 11. Find the best and worst-performing delivery carriers.

with carrier_performance as (select carrier_id, Round((sum(case when actual_delivery<=expected_delivery then 1
else 0
end)/ count(shipment_id))*100) as sla_percentage
from shipments 
group by carrier_id)
Select carrier_id, sla_percentage, 'BEST' as performance
from carrier_performance
where sla_percentage = (select max(sla_percentage) from carrier_performance)

union all

select carrier_id, sla_percentage, 'WORST' as performance
from carrier_performance
where sla_percentage = (select min(sla_percentage) from carrier_performance);



-- 12. Find the top 3 carriers in each region using a window function.
with carrier_performance as (select c.region,c.carrier_id,c.carrier_name,
round((sum(case when s.actual_delivery <= s.expected_delivery then 1
else 0
end) / count(s.shipment_id)) * 100) as sla_percentage
from carriers c
join shipments s
on c.carrier_id = s.carrier_id
group by c.region, c.carrier_id, c.carrier_name),
ranked_carriers as (select region,carrier_id, carrier_name,sla_percentage,
dense_rank() over (partition by region order by sla_percentage desc) as carrier_rank
from carrier_performance)
select *from ranked_carriers
where carrier_rank <= 3;

-- 13. Calculate the average delivery time for each warehouse.

select warehouse_id,
round(avg(datediff(actual_delivery, shipment_date)), 2) as avg_delivery_days
from shipments
where actual_delivery is not null
group by warehouse_id;

-- 14. Identify warehouses having the highest number of delayed shipments.
select warehouse_id, count(shipment_id) as delayed_shipments
from shipments
where actual_delivery > expected_delivery
group by warehouse_id
order by delayed_shipments desc;

-- 15. Calculate the following monthly:
-- Total Orders
-- Total Shipments
-- Delivered Shipments
-- Delayed Shipments
-- SLA Compliance %
select date_format(o.order_date, '%Y-%m') as month,
count(distinct o.order_id) as total_orders,count(distinct s.shipment_id) as total_shipments,
count(distinct case
when s.shipment_status = 'Delivered' then s.shipment_id
end) as delivered_shipments,
count(distinct case
when s.actual_delivery > s.expected_delivery then s.shipment_id
end) as delayed_shipments,
round((count(distinct case when s.actual_delivery <= s.expected_delivery then s.shipment_id
end) / nullif(count(distinct case when s.actual_delivery is not null then s.shipment_id
end), 0)) * 100, 2) as sla_compliance_percentage
from orders o 
left join shipments s
on o.order_id = s.order_id
group by date_format(o.order_date, '%Y-%m')
order by month;

-- 16. Find the region with the highest SLA breach percentage.
select c.region,
round((sum(case when s.actual_delivery>s.expected_delivery then 1 else 0 end)/count(s.shipment_id))*100,2) as sla_breach_percentage
from carriers c
join shipments s
on c.carrier_id = s.carrier_id
group by c.region
order by sla_breach_percentage desc
limit 1;


-- 17. Find the products with the highest return rate.
select p.product_id, p.product_name, count(r.return_id) as total_returns,
count(od.order_detail_id) as total_orders,
round((count(r.return_id)/count(od.order_detail_id))*100,2) as return_rate
from products p
join order_details od
on p.product_id = od.product_id
left join returns r
on p.product_id = r.product_id
group by p.product_id,p.product_name
order by return_rate desc;

-- 18. Find customers who placed more than 5 orders and had at least one returned product.
select c.customer_id,c.customer_name,count(distinct o.order_id) as total_orders,
count(distinct r.return_id) as total_returns
from customers c
join orders o
on c.customer_id = o.customer_id
join returns r
on o.order_id = r.order_id
group by c.customer_id,c.customer_name
having count(distinct o.order_id) > 5
and count(distinct r.return_id) >= 1;

-- 19. Find shipments that had multiple tracking updates before delivery.
select s.shipment_id,count(dt.tracking_id) as tracking_updates
from shipments s
join delivery_tracking dt
on s.shipment_id = dt.shipment_id
where dt.tracking_date < s.actual_delivery
group by s.shipment_id
having count(dt.tracking_id) > 1;

-- 20. Find orders where shipment was delivered late and order value is greater than average order value.
select o.order_id,c.customer_name,
sum(od.quantity*od.unit_price) as order_value,
s.actual_delivery,s.expected_delivery
from orders o
join customers c
on o.customer_id = c.customer_id
join order_details od
on o.order_id = od.order_id
join shipments s
on o.order_id = s.order_id
where s.actual_delivery > s.expected_delivery
group by o.order_id,c.customer_name,s.actual_delivery,s.expected_delivery
having sum(od.quantity*od.unit_price) >
(select avg(order_value)
from(select order_id,sum(quantity*unit_price) as order_value
from order_details
group by order_id) as order_values);

-- 21. Rank warehouses based on delivery performance.
select warehouse_id,
round((sum(case when actual_delivery<=expected_delivery then 1 else 0 end)/count(shipment_id))*100,2) as sla_percentage,
rank() over(order by (sum(case when actual_delivery<=expected_delivery then 1 else 0 end)/count(shipment_id))*100 desc) as warehouse_rank
from shipments
group by warehouse_id;

-- 22. Find the second-highest performing carrier by SLA compliance.
with carrier_performance as
(select carrier_id,round((sum(case when actual_delivery<=expected_delivery then 1 else 0 end)/count(shipment_id))*100,2) as sla_percentage
from shipments
group by carrier_id),
ranked_carriers as(select carrier_id,sla_percentage,
dense_rank() over(order by sla_percentage desc) as carrier_rank
from carrier_performance)
select carrier_id,sla_percentage
from ranked_carriers
where carrier_rank = 2;

-- 23. Find customers whose total spending is greater than average customer spending.
with customer_spending as
(select customer_id,sum(od.quantity*od.unit_price) as total_spending
from orders o
join order_details od
on o.order_id = od.order_id
group by customer_id)
select customer_id,total_spending
from customer_spending
where total_spending >
(select avg(total_spending)
from customer_spending);

-- 24. Create a view named Shipment_Performance_View.
create view shipment_performance_view as
select o.order_id,c.customer_name as customer,w.warehouse_name as warehouse,
ca.carrier_name as carrier,s.shipment_date,s.expected_delivery,s.actual_delivery,
datediff(s.actual_delivery,s.shipment_date) as delivery_days,
case when s.actual_delivery<=s.expected_delivery then 'on time'
else 'sla breached'
end as sla_status
from shipments s
join orders o
on s.order_id = o.order_id
join customers c
on o.customer_id = c.customer_id
join warehouses w
on s.warehouse_id = w.warehouse_id
join carriers ca
on s.carrier_id = ca.carrier_id;

select*from shipment_performance_view;

-- 25. Create indexes for Customer_ID, Order_ID, Shipment_ID, Carrier_ID and Shipment_Date.
create index idx_customer_id
on orders(customer_id);

create index idx_order_id
on shipments(order_id);

create index idx_shipment_id
on delivery_tracking(shipment_id);

create index idx_carrier_id
on shipments(carrier_id);

create index idx_shipment_date
on shipments(shipment_date);


-- FINAL DELIVERABLES:

-- 1. Database creation script
-- 2. Table creation script
-- 3. Sample data insertion script
-- 4. SQL queries for all 25 tasks
-- 5. At least 1 CTE
-- 6. At least 3 JOIN queries
-- 7. At least 3 Window Function queries
-- 8. At least 1 Subquery
-- 9. At least 1 View
-- 10. At least 2 Indexes
-- 11. Final business insights/report based on the query results