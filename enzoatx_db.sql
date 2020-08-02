-- *** EnzoATX Database *** --
-- *** 7/17/2020 15:43PM CST *** --
-- *** By: Vincent T. Leslie *** --

-- *** OVERVIEW *** --
-- This database is used to monitor and insert customer booking inquiries for EnzoATX, as well as displaying our services, our supply counts,
-- as well as our subscribed customers. --

create table customerBookings(
	Customer_ID int,
		Customer_FirstName varchar(15),
        Customer_LastName varchar(15),
        PurchaseDate date,
        Service_Name varchar(50),
        Service_Price int,
        Subscribed_Customer boolean
        );


create table enzoatxServices(
	Service_Name varchar(50),
		Service_Price int
        );

        
create table ongoingSubscriptions(
	Customer_ID int,
        Customer_Subscrption_Type varchar(70),
        Customer_Subscription_RenewalDate date,
        Subscription_Tokens int
        );


create table supplyCount(
	Products_List varchar(20),
    Product_Count int
    );

-- *** Below are all the current customer bookings recorded for July 2020. The Value sets start with an identifier number for each person, 
-- as well as their full names, the date of purchase, the service purchased, the cost of that service, and finally, a boolean value 
-- used to determine if they are a subscribed customer of EnzoATX's Premium Program. *** ==
insert customerBookings values(1,'Paige','Flores','2020-07-01','Basic Interior Clean','30',0);
insert customerBookings values(2,'Jackson','Flores','2020-07-02','Basic Interior Clean','30',0);
insert customerBookings values(3,'Michael','Scott','2020-07-02','Basic Detail Package','45',1);
insert customerBookings values(4,'Andrew','Guitterez','2020-07-06','Stage 1 Paint Correction','150',0);
insert customerBookings values(5,'Kyle','Brentley','2020-07-07','Basic Interior Clean','30',1);
insert customerBookings values(6,'Marcus','Ericson','2020-07-10','Basic Exterior Clean','30',0);
insert customerBookings values(7,'Carolyn','Molina','2020-07-11','Basic Exterior Clean','30',1);
insert customerBookings values(8,'Dominic','Tarantino','2020-07-15','Stage 2 Paint Correction','300',1);
insert customerBookings values(9,'Simon','Sinek','2020-07-18','Basic Interior Clean','30',0);
insert customerBookings values(10,'Alan','Picazo','2020-07-21','Basic Exterior Clean','30',0);
insert customerBookings values(11,'Mario','Andretti','2020-07-21','Basic Exterior Clean','30',0);
insert customerBookings values(12,'Marissa','Audino','2020-07-21','Basic Exterior Clean','30',0);
insert customerBookings values(13,'Ashley','Gonzales','2020-07-23','Basic Interior Clean','30',1);
insert customerBookings values(14,'Rebecca','Martinez','2020-07-24','Stage 3 Paint Correction','450',1);
insert customerBookings values(15,'Anthony','Davidson','2020-07-29','Basic Detail Package','45',0);
insert customerBookings values(16,'Junior','De La Fuente','2020-07-30','Basic Interior Clean','30',0);


-- *** Below are all the services that EnzoATX offers. 
-- The first value set is the service type and the second value set is the price for that service. *** --
insert enzoatxServices values('Basic Interior Clean',30);
insert enzoatxServices values('Basic Exterior Clean',30);
insert enzoatxServices values('Basic Detail Package',45);
insert enzoatxServices values('Advanced Interior Clean',65);
insert enzoatxServices values('Advanced Exterior Clean',65);
insert enzoatxServices values('Advanced Detail Package',100);
insert enzoatxServices values('Stage 1 Paint Correction',150);
insert enzoatxServices values('Stage 2 Paint Correction',300);
insert enzoatxServices values('Stage 3 Paint Correction',450);

-- *** Below are all the currently subscribed customers we have in our database. The first set of data is joined (see code below) with our
-- customerBookings table. These tables are used to display what customers are subscribed, what subscription plan they are paying for, the
-- renewal date of their subscription, as well as how many tokens, or the currency they receive upon the sale of transaction, they have 
-- available. *** --
insert ongoingSubscriptions values(3,'Basic Detail Package Subscription','2020-08-02',0);
insert ongoingSubscriptions values(5,'Basic Subscription','2020-08-07',0); -- Customers 3,5, and 7 decided to use their tokens toward the service
insert ongoingSubscriptions values(7,'Basic Subscription','2020-08-11',0);
insert ongoingSubscriptions values(8,'Advanced Detail Package Subscription','2020-08-15',1); -- This customer bought a Stage 2 Paint correction and decided to use it for another service
insert ongoingSubscriptions values(13,'Basic Subscription','2020-08-23',0);
insert ongoingSubscriptions values(14,'Advanced Detail Package Subscription','2020-08-24',1); -- This customer also decided to save their token toward a future service

-- *** Below are all the current supplies we use for all our services. This is used to manage what inventory counts we have, as well as to see
-- and monitor which products will need to be purchased. *** --
insert supplyCount values('Foaming Wax',5);
insert supplyCount values('Tire Shine', 2);
insert supplyCount values('Microfibre Towels',54);
insert supplyCount values('Interior Cleaner',4);
insert supplyCount values('Leather Cleaner',0);
insert supplyCount values('Polishing Pads',3);
insert supplyCount values('Compound Liquid',2);
insert supplyCount values('Polishing Liquid',3);
insert supplyCount values('Wax Liquid',4);

select * from supplyCount;

select * from customerBookings;

select * from enzoatxServices;

-- *** Below is a join clause used to match the Customer_ID data value to two tables (customerBookings table & ongoingSubscriptions table).
-- This is used to get a dataset of the customer that are currently subscribed (Per the Select statement).
select customerBookings.Customer_ID, Customer_FirstName, Customer_LastName, PurchaseDate
from customerBookings
join ongoingSubscriptions
on customerBookings.Customer_ID = ongoingSubscriptions.Customer_ID;

-- This orders this specific table by its purchase date in an ascending order (Default Order Structure)
select customerBookings.Customer_ID, Customer_FirstName, Customer_LastName, PurchaseDate
from customerBookings 
ORDER BY PurchaseDate;

-- This orders this specific table by its service cost in an ascending order (Default Order Structure)
select customerBookings.Customer_ID, Customer_FirstName, Customer_LastName, PurchaseDate, Service_Price
from customerBookings
order by Service_Price;

-- This clause orders the customerBookings table by Service_Price in a descending order.
select customerBookings.Customer_ID, Customer_FirstName, Customer_LastName, PurchaseDate, Service_Price
from customerBookings
order by Service_Price desc;

-- This clause orders the customerBookings table by first displaying which customers are subscribed (1 being subscribed)
select customerBookings.Customer_ID, Customer_FirstName, Customer_LastName, PurchaseDate, Subscribed_Customer
from customerBookings
order by Subscribed_Customer desc;