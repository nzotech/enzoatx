-- *** EnzoATX Database *** --
-- *** 7/17/2020 15:43PM CST *** --
-- *** By: Vincent T. Leslie *** --

-- *** OVERVIEW *** --
-- This database is used to monitor and insert customer booking inquiries for EnzoATX, as well as displaying our services, our supply counts,
-- as well as our subscribed customers. --
create table customer(
	Customer_ID int,
		Customer_FirstName varchar(15),
        Customer_LastName varchar(15)
        );

create table customerBookings(
	CustomerBooking_ID int,
		Customer_ID int,
        Purchase_Date date,
        Subscribed_Customer boolean
        );

create table enzoatxServices(
	Service_ID int,
    Service_Name varchar(50),
		Service_Price int
        );
        
create table ongoingSubscriptions(
	Subscription_ID int, -- informal primary key
    Customer_ID int,
        Customer_Subscrption_Type varchar(70),
        Customer_Subscription_RenewalDate date,
        Subscription_Tokens int
        );

create table supplyCount(
	Supply_ID int,
		Products_List varchar(20),
		Product_Count int
    );

-- Below are a current list of customers in our database. This table is in first normal form (1NF). This is used to prevent duplication issues
-- within the database for the 'customerBookings' table
insert customer values(1,'Paige','Flores');
insert customer values(2,'Jackson','Flores');
insert customer values(3,'Michael','Scott');
insert customer values(4,'Andrew','Guitterez');
insert customer values(5,'Kyle','Brentley');
insert customer values(6,'Marcus','Ericson');
insert customer values(7,'Carolyn','Molina');
insert customer values(8,'Dominic','Tarantino');
insert customer values(9,'Simon','Sinek');
insert customer values(10,'Alan','Picazo');
insert customer values(11,'Mario','Andretti');
insert customer values(12,'Marissa','Audino');
insert customer values(13,'Ashley','Gonzales');
insert customer values(14,'Rebecca','Martinez');
insert customer values(15,'Anthony','Davidson');
insert customer values(16,'Junior','De La Fuente');

-- *** Below are all the current customer bookings recorded for July 2020. The Value sets start with an identifier number for each person, 
-- as well as their full names, the date of purchase, the service purchased, the cost of that service, and finally, a boolean value 
-- used to determine if they are a subscribed customer of EnzoATX's Premium Program. *** ==
insert customerBookings values(1,1,'2020-07-01',0);	
insert customerBookings values(2,2,'2020-07-02',0);					
insert customerBookings values(3,3,'2020-07-02',1);
insert customerBookings values(4,4,'2020-07-06',0);
insert customerBookings values(5,5,'2020-07-07',1);
insert customerBookings values(6,6,'2020-07-10',0);
insert customerBookings values(7,7,'2020-07-11',1);
insert customerBookings values(8,8,'2020-07-15',1);
insert customerBookings values(9,9,'2020-07-18',0);
insert customerBookings values(10,10,'2020-07-21',0);
insert customerBookings values(11,11,'2020-07-21',0);
insert customerBookings values(12,12,'2020-07-21',0);
insert customerBookings values(13,13,'2020-07-23',1);
insert customerBookings values(14,14,'2020-07-24',1);
insert customerBookings values(15,15,'2020-07-29',0);
insert customerBookings values(16,16,'2020-07-30',0);
insert customerBookings values(15,15,'2020-07-29',0);


-- *** Below are all the services that EnzoATX offers. 
-- The first value set is the service type and the second value set is the price for that service. *** --
insert enzoatxServices values(1,'Basic Interior Clean',30);
insert enzoatxServices values(2,'Basic Exterior Clean',30);
insert enzoatxServices values(3,'Basic Detail Package',45);
insert enzoatxServices values(4,'Advanced Interior Clean',65);
insert enzoatxServices values(5,'Advanced Exterior Clean',65);
insert enzoatxServices values(6,'Advanced Detail Package',100);
insert enzoatxServices values(7,'Stage 1 Paint Correction',150);
insert enzoatxServices values(8,'Stage 2 Paint Correction',300);
insert enzoatxServices values(9,'Stage 3 Paint Correction',450);

-- *** Below are all the currently subscribed customers we have in our database. The first set of data is joined (see code below) with our
-- customerBookings table. These tables are used to display what customers are subscribed, what subscription plan they are paying for, the
-- renewal date of their subscription, as well as how many tokens, or the currency they receive upon the sale of transaction, they have 
-- available. *** --
insert ongoingSubscriptions values(1,3,'Basic Detail Package Subscription','2020-08-02',0);
insert ongoingSubscriptions values(2,5,'Basic Subscription','2020-08-07',0); -- Customers 3,5, and 7 decided to use their tokens toward the service
insert ongoingSubscriptions values(3,7,'Basic Subscription','2020-08-11',0);
insert ongoingSubscriptions values(4,8,'Advanced Detail Package Subscription','2020-08-15',1); -- This customer bought a Stage 2 Paint correction and decided to use it for another service
insert ongoingSubscriptions values(5,13,'Basic Subscription','2020-08-23',0);
insert ongoingSubscriptions values(6,14,'Advanced Detail Package Subscription','2020-08-24',1); -- This customer also decided to save their token toward a future service

-- *** Below are all the current supplies we use for all our services. This is used to manage what inventory counts we have, as well as to see
-- and monitor which products will need to be purchased. *** --
insert supplyCount values(1,'Foaming Wax',5);
insert supplyCount values(2,'Tire Shine', 2);
insert supplyCount values(3,'Microfibre Towels',54);
insert supplyCount values(4,'Interior Cleaner',4);
insert supplyCount values(5,'Leather Cleaner',0);
insert supplyCount values(6,'Polishing Pads',3);
insert supplyCount values(7,'Compound Liquid',2);
insert supplyCount values(8,'Polishing Liquid',3);
insert supplyCount values(9,'Wax Liquid',4);


-- *** Below is a join clause used to match the Customer_ID data value to two tables (customerBookings table & ongoingSubscriptions table).
-- This is used to get a dataset of the customer that are currently subscribed (Per the Select statement).
select customerBookings.Customer_ID, customer.Customer_FirstName, customer.Customer_LastName, customerBookings.Purchase_Date
from customerBookings
inner join customer
	on customerBookings.Customer_ID = customer.Customer_ID;

-- Below is a groupBy clause used to define the groups of subscribed customers with zero tokens and more than zero tokens
select ongoingSubscriptions.Customer_ID, ongoingSubscriptions.Subscription_ID, customer.Customer_FirstName, customer.Customer_LastName, ongoingSubscriptions.Subscription_Tokens
from ongoingSubscriptions
join customer
	on ongoingSubscriptions.Customer_ID = customer.Customer_ID
WHERE ongoingsubscriptions.Subscription_Tokens =0;


-- This orders this specific table by its purchase date in an ascending order (Default Order Structure)
select customerBookings.Customer_ID, customer.Customer_FirstName, customer.Customer_LastName, customerBookings.Purchase_Date
from customerBookings 
inner join customer
	on customerBookings.Customer_ID = customer.Customer_ID
ORDER BY Purchase_Date;

-- This orders this specific table by its service cost in an ascending order (Default Order Structure)
select customerBookings.Customer_ID,customer.Customer_FirstName, customer.Customer_LastName, enzoatxServices.Service_Name, enzoatxServices.Service_Price
from customerBookings
inner join customer
	on customerBookings.Customer_ID = customer.Customer_ID
order by Service_Price; -- You can also order it in descending order by putting 'desc' after the value being ordered (order by Service_Price desc;)


-- This clause orders the customerBookings table by first displaying which customers are subscribed (1 being subscribed)
select customerBookings.Customer_ID, customer.Customer_FirstName, customer.Customer_LastName, customerBookings.Subscribed_Customer
from customerBookings 
inner join customer
	on customerBookings.Customer_ID = customer.Customer_ID
order by Subscribed_Customer;