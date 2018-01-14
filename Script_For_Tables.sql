-- coffeeHouse.sql
create database coffeeHouse;
go

use coffeeHouse;
go

-- Create tables for the database
drop table transaction_items;
drop table sale_transaction;
drop table club_members;
drop table store_supplies;
drop table food_ingredients;
drop table orders;
drop table clerk;
drop table manager;
drop table employee;
drop table item; 
drop table supplies;
drop table supplier;


SET FOREIGN_KEY_CHECKS=0;
create table supplier 
	(supplier_id int not null, 
	spr_name varchar(40) not null);

alter table supplier
add primary key (supplier_id);

create table supplies
	(supplies_id int not null, 
	sname varchar(40) not null, 
	qty int not null , 
	cost float not null, 
	supplier_id int not null);

alter table supplies
add primary key (supplies_id);
alter table supplies
add foreign key (supplier_id) references supplier(supplier_id);

create table item
	(item_id int not null,
	supplies_id int not null, 
	iname varchar(40) not null, 
	price float not null, 
	itype varchar(10) not null);

alter table item
add primary key (item_id);
alter table item
add foreign key (supplies_id) references supplies(supplies_id);


create table employee
	(eid int not null, 
	epass varchar(40) not null, 
	ename varchar(40) not null,
	salary float not null);

alter table employee
add primary key (eid);

create table manager 
	(eid int not null);

alter  table manager 
add primary key (eid);
alter table manager
add foreign key (eid) references employee (eid);

create table clerk
	(eid int not null, 
	manager_eid int not null);

alter table clerk
add primary key (eid);
alter table clerk
add foreign key (manager_eid) references manager(eid);



create table orders
	(oid int not null, 
	supplies_id int not null, 
	eid int not null,  
	total_price float not null, 
	day date not null, 
	qty int);


alter table orders
add primary key (oid);
alter table orders
add foreign key (eid) references employee(eid);
alter table orders
add foreign key (supplies_id) references supplies(supplies_id);


create table food_ingredients
	(supplies_id int not null, 
	oid int not null, 
	exdate date not null);

alter table food_ingredients
add primary key (supplies_id, oid);
alter table food_ingredients
add foreign key (oid) references orders(oid);
alter table food_ingredients
add foreign key (supplies_id) references supplies(supplies_id);


create table store_supplies
	(supplies_id int not null);
alter table store_supplies
add primary key (supplies_id);
alter table store_supplies 
add foreign key (supplies_id) references supplies(supplies_id);



create table club_members
	(cid int not null, 
	cname varchar(40) not null, 
	phone varchar(16) not null, 
	email varchar(40) not null, 
	points int not null,
	eid int not null,
	unique(phone));

alter table club_members
add primary key  (cid);
alter table club_members
add foreign key (eid) references employee(eid);

create table sale_transaction
	(tid int not null,
	amount float not null, 
	ttime datetime not null, 
	payment_type varchar(10) not null, 
	eid int not null , 
	cid int);

alter table sale_transaction
add primary key (tid);
alter table sale_transaction
add foreign key (eid) references manager(eid);
alter table sale_transaction
add foreign key (cid) references club_members(cid);


create table transaction_items
	(tid int not null, 
	item_id int not null, 
	qty int not null);

alter table transaction_items
add primary key (tid, item_id); 

alter table transaction_items
add foreign key (tid) references sale_transaction(tid);
alter table transaction_items
add foreign key (item_id) references item(item_id);





insert into supplier values
(1, 'Coffee Beans Co.');
insert into supplier values
(2, 'Tea Company');
insert into supplier  values
(3, 'Kirkland Salads');
insert into supplier  values
(4, 'Granville Soup Market'); 
insert into supplier  values
(5, 'Sandwich Company');
insert into supplier values
(8, 'Restaurant Supplies ltd.');

insert into supplies values
(1, 'coffee beans', 100, 0.50, 1);
insert into supplies values
(2, 'espresso beans', 100, 0.75, 1);
insert into supplies values
(3, 'cocoa beans', 100, 0.60, 1);
insert into supplies values
(4, 'black tea leaves', 100, 0.50, 2);
insert into supplies values
(5, 'black tea leaves', 100, 0.50, 2);

insert into supplies values
(6, '50/50 mix package', 30, 2.00, 3);
insert into supplies values
(7, 'Soup base', 30, 1.50, 4);
insert into supplies values
(8, 'Mozza and bread', 30, 4.00, 5);
insert into supplies values
(9, 'Turkey', 30, 4.50, 5);
insert into supplies values
(10, 'Avocado mix', 30, 3.50, 5);

-- store_supplies
insert into supplies values
(20, 'cup', 400, 0.10, 8);
insert into supplies values
(21, 'lid', 400, 0.15, 8);
insert into supplies values
(22, 'napkin', 400, 0.05, 8);

insert into item values
(1, 1, 'Coffee', 2.00, 'beverage');
insert into item values
(2, 2, 'Espreso', 3.00, 'beverage');
insert into item values
(3, 2, 'Americano', 3.25, 'beverage');
insert into item values
(4, 2, 'Macchiato', 3.25, 'beverage');
insert into item values
(5, 2, 'Cappucino', 3.50, 'beverage');
insert into item values
(6, 2, 'Flat White', 3.50, 'beverage');
insert into item values
(7, 2, 'Latte', 4.00, 'beverage');
insert into item values
(8, 2, 'Mocha', 4.50, 'beverage');
insert into item values
(9, 3, 'Hot Chocolate', 3.50, 'beverage');
insert into item values
(10, 4, 'Black Tea', 3.00, 'beverage');
insert into item values
(11, 5, 'Green Tea', 3.00, 'beverage');

-- food types
insert into item values
(20, 6, 'Salad', 6.00 , 'food');
insert into item values
(21, 7, 'Soup', 5.00 , 'food');
insert into item values
(22, 8, 'Grilled Cheese Sandwich', 7.50 , 'food');
insert into item values
(23, 9, 'Turkey Sandwich', 8.25 , 'food');
insert into item values
(24, 10, 'Vegetarian Sandwich', 8.00 , 'food');

-- employee
insert into employee values
(1, SHA1('password1'), 'Christine Chu', 17.50);
insert into employee values
(2, SHA1('password2'), 'Mehryar Maalem', 11.00);
insert into employee values
(3, SHA1('password3'), 'Zack Wong', 11.00);
insert into employee values
(4, SHA1('password4'), 'Billy Liu', 11.00);

-- manager
insert into manager values (1);
-- clerks
insert into clerk values (2, 1);
insert into clerk values (3, 1);
insert into clerk values (4, 1);

insert into orders values
(2, 1, 1, 50.00, '2017-03-17', 100);
insert into orders values
(3, 2, 1, 75.00, '2017-03-17',100);
insert into orders values
(1, 3, 1, 30.00, '2017-03-25',50);
insert into orders values
(4, 3, 1, 30.00, '2017-03-18',50);
insert into orders values
(5, 4, 1, 25.00, '2017-03-18',50);
insert into orders values
(6, 4, 1, 25.00, '2017-03-22',50);
insert into orders values
(7, 5, 1, 50.00, '2017-03-18',100);
insert into orders values
(8, 6, 1, 60.00, '2017-03-18',30);
insert into orders values
(9, 7, 1, 45.00, '2017-03-18',30);
insert into orders values
(10, 8, 1, 120.00, '2017-03-17',30);
insert into orders values
(11, 9, 1, 135.00, '2017-03-20',30);
insert into orders values
(12, 10, 1, 105.00, '2017-03-20',30);

-- store supply orders
insert into orders values
(13, 20, 1, 40.00, '2017-03-20',400);
insert into orders values
(14, 21, 1, 60.00, '2017-03-20',400);
insert into orders values
(15, 22, 1, 20.00, '2017-03-20',400);


insert into food_ingredients values
(1, 2, '2017-04-18');
insert into food_ingredients values
(2, 3, '2017-04-18');
insert into food_ingredients values
(3, 1, '2017-04-25');
insert into food_ingredients values
(3, 4, '2017-04-18');
insert into food_ingredients values
(4, 5, '2017-04-22');
insert into food_ingredients values
(4, 6, '2017-04-18');
insert into food_ingredients values
(5, 7, '2017-04-18');
insert into food_ingredients values
(6, 8, '2017-04-05');
insert into food_ingredients values
(7, 9, '2017-04-05');
insert into food_ingredients values
(8, 10, '2017-04-10');
insert into food_ingredients values
(9, 11, '2017-04-10');
insert into food_ingredients values
(10, 12, '2017-04-11');

-- store_supplies
insert into store_supplies values (20);
insert into store_supplies values (21);
insert into store_supplies values (22);

-- club members
insert into club_members values
(1, 'Laks VS. Lakshamanan', '778-222-7898', 'laks@gmail.com', 200, 1);
insert into club_members values
(2, 'Joe Flacco', '778-222-7888', 'joe@gmail.com', 200, 1);
insert into club_members values
(3, 'Eli Manning', '778-282-7898', 'eli@gmail.com', 100, 1);
insert into club_members values
(4, 'Aaron Rodgers', '778-229-7898', 'aaron@gmail.com', 500, 1);
insert into club_members values
(5, 'Michael Jordan', '778-222-8898', 'michael@gmail.com', 800, 2);
insert into club_members values
(6, 'Lebron James', '604-222-7898', 'lbj@gmail.com', 900, 2);
insert into club_members values
(7, 'JR Smith', '403-222-7898', 'jrsmith@gmail.com', 400, 2);
insert into club_members values
(8, 'Steph Curry', '406-222-7898', 'steph@gmail.com', 250, 2);
insert into club_members values
(9, 'Kevin Durant', '412-222-7898', 'kevin@gmail.com', 210, 2);
insert into club_members values
(10, 'Adrian Peterson', '400-222-7898', 'adrianp@gmail.com', 250, 2);
insert into club_members values
(11, 'Tim Duncan', '614-222-7898', 'timduncan@gmail.com', 900, 2);
insert into club_members values
(12, 'Kevin Garnett', '614-322-7898', 'kevingarnett@gmail.com',1000, 3);
insert into club_members values
(13, 'Greg Popovich', '614-422-7898', 'greg@gmail.com', 400, 3);
insert into club_members values
(14, 'Jason Pierre-Paul', '403-422-7898', 'jason@gmail.com', 10, 3);
insert into club_members values
(15, 'Kyle Lowry', '403-522-7898', 'kyle@gmail.com', 0, 3);
insert into club_members values
(16, 'Rajon Rondo', '403-622-7898', 'rajon@gmail.com', 1000, 4);
insert into club_members values
(17, 'Chris Paul', '403-722-7898', 'chrispaul@gmail.com', 500, 4);
insert into club_members values
(18, 'Blake Griffin', '403-822-7898', 'blakeg@gmail.com', 200, 4);
insert into club_members values
(19, 'Orleans Darkwa', '403-922-7898', 'odarkwa@gmail.com', 600, 4);
insert into club_members values
(20, 'Hazra Imran', '777-222-7898', 'hazra@gmail.com', 850, 4);


-- Insert sale_transaction

insert into sale_transaction values
(0001, 4.00, '2017-01-01 10:12:45', 'cash', 2, 20);
insert into sale_transaction values
(0002, 10.00, '2017-01-01 10:36:45', 'debit', 2, null);
insert into sale_transaction values
(0003, 6.50, '2017-01-01 11:16:45', 'cash', 2, null);
insert into sale_transaction values
(0004, 9.00, '2017-01-01 11:42:45', 'credit', 2, 3);
insert into sale_transaction values
(0005, 12.00, '2017-01-01 12:12:45', 'cash', 2, 17);
insert into sale_transaction values
(0006, 11.75, '2017-01-01 12:42:45', 'cash', 2, null);
insert into sale_transaction values
(0007, 11.00, '2017-01-01 12:57:45', 'credit', 2, null);
insert into sale_transaction values
(0008, 10.50, '2017-01-01 13:16:45', 'credit', 2, 1);
insert into sale_transaction values
(0009, 3.25, '2017-01-01 13:24:45', 'credit', 2, 11);
insert into sale_transaction values
(0010, 6.00, '2017-01-01 13:29:45', 'credit', 2, null);
insert into sale_transaction values
(0011, 5.00, '2017-01-01 13:37:45', 'credit', 2, null);
insert into sale_transaction values
(0012, 3.25, '2017-01-01 13:48:45', 'credit', 2, 18);
insert into sale_transaction values
(0013, 10.00, '2017-01-01 14:25:45', 'credit', 2, null);
insert into sale_transaction values
(0014, 12.00, '2017-01-01 14:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0015, 8.25, '2017-01-01 14:52:45', 'cash', 2, null);
insert into sale_transaction values
(0016, 3.25, '2017-01-01 15:15:45', 'cash', 2, null);
insert into sale_transaction values
(0017, 11.00, '2017-01-01 15:33:45', 'cash', 2, null);
insert into sale_transaction values
(0018, 3.50, '2017-01-01 16:11:45', 'cash', 2, 9);

insert into sale_transaction values
(0019, 14.25, '2017-01-02 10:08:45', 'cash', 3, null);
insert into sale_transaction values
(0020, 3.25, '2017-01-02 10:37:45', 'cash', 3, 11);
insert into sale_transaction values
(0021, 4.50, '2017-01-02 11:13:45', 'credit', 3, null);
insert into sale_transaction values
(0022, 3.50, '2017-01-02 11:42:45', 'credit', 3, null);
insert into sale_transaction values
(0023, 11.00, '2017-01-02 12:05:45', 'debit', 3, 12);
insert into sale_transaction values
(0024, 2.00, '2017-01-02 12:43:45', 'credit', 3, 2);
insert into sale_transaction values
(0025, 3.00, '2017-01-02 12:53:45', 'credit', 3, null);
insert into sale_transaction values
(0026, 11.50, '2017-01-02 13:01:45', 'cash', 3, null);
insert into sale_transaction values
(0027, 12.00, '2017-01-02 13:11:45', 'credit', 3, 1);
insert into sale_transaction values
(0028, 4.00, '2017-01-02 13:13:45', 'credit', 3, null);
insert into sale_transaction values
(0029, 3.50, '2017-01-02 13:23:45', 'debit', 3, 3);
insert into sale_transaction values
(0030, 6.00, '2017-01-02 13:48:45', 'credit', 3, null);
insert into sale_transaction values
(0031, 6.00, '2017-01-02 14:07:45', 'credit', 3, null);
insert into sale_transaction values
(0032, 3.25, '2017-01-02 14:19:45', 'credit', 3, 14);
insert into sale_transaction values
(0033, 5.00, '2017-01-02 14:50:45', 'credit', 3, 9);
insert into sale_transaction values
(0034, 12.75, '2017-01-02 15:26:45', 'credit', 3, null);
insert into sale_transaction values
(0035, 3.25, '2017-01-02 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0036, 5.00, '2017-01-02 16:18:45', 'credit', 3, null);

insert into sale_transaction values
(0037, 3.50, '2017-01-03 10:02:45', 'credit', 4, null);
insert into sale_transaction values
(0038, 10.50, '2017-01-03 10:43:45', 'credit', 4, 2);
insert into sale_transaction values
(0039, 3.00, '2017-01-03 11:12:45', 'debit', 4, null);
insert into sale_transaction values
(0040, 8.25, '2017-01-03 11:50:45', 'credit', 4, 20);
insert into sale_transaction values
(0041, 3.00, '2017-01-03 12:21:45', 'cash', 4, 18);
insert into sale_transaction values
(0042, 3.25, '2017-01-03 12:33:45', 'credit', 4, null);
insert into sale_transaction values
(0043, 5.00, '2017-01-03 12:50:45', 'credit', 4, null);
insert into sale_transaction values
(0044, 11.5, '2017-01-03 13:11:45', 'debit', 4, 13);
insert into sale_transaction values
(0045, 8.25, '2017-01-03 13:20:45', 'cash', 4, 7);
insert into sale_transaction values
(0046, 2.00, '2017-01-03 13:26:45', 'debit', 4, null);
insert into sale_transaction values
(0047, 3.25, '2017-01-03 13:36:45', 'cash', 4, null);
insert into sale_transaction values
(0048, 6.50, '2017-01-03 13:52:45', 'credit', 4, 3);
insert into sale_transaction values
(0049, 5.00, '2017-01-03 14:12:45', 'cash', 4, 17);
insert into sale_transaction values
(0050, 8.00, '2017-01-03 14:42:45', 'cash', 4, null);
insert into sale_transaction values
(0051, 4.50, '2017-01-03 14:57:45', 'credit', 4, null);
insert into sale_transaction values
(0052, 9.50, '2017-01-03 15:16:45', 'credit', 4, 1);
insert into sale_transaction values
(0053, 7.5, '2017-01-03 15:24:45', 'debit', 4, 11);
insert into sale_transaction values
(0054, 7.5, '2017-01-03 16:29:45', 'credit', 4, null);

insert into sale_transaction values
(0055, 6.50, '2017-01-04 10:07:45', 'credit', 2, null);
insert into sale_transaction values
(0056, 9.50, '2017-01-04 10:28:45', 'credit', 2, 3);
insert into sale_transaction values
(0057, 4.00, '2017-01-04 11:25:45', 'credit', 2, null);
insert into sale_transaction values
(0058, 3.50, '2017-01-04 11:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0059, 3.00, '2017-01-04 12:13:45', 'cash', 2, null);
insert into sale_transaction values
(0060, 7.50, '2017-01-04 12:15:45', 'cash', 2, null);
insert into sale_transaction values
(0061, 8.25, '2017-01-04 12:37:45', 'debit', 2, null);
insert into sale_transaction values
(0062, 4.50, '2017-01-04 13:11:45', 'cash', 2, 9);
insert into sale_transaction values
(0063, 7.50, '2017-01-04 13:28:45', 'credit', 2, null);
insert into sale_transaction values
(0064, 5.00, '2017-01-04 13:37:45', 'cash', 2, 20);
insert into sale_transaction values
(0065, 3.00, '2017-01-04 13:39:45', 'credit', 2, null);
insert into sale_transaction values
(0066, 3.50, '2017-01-04 13:46:45', 'credit', 2, null);
insert into sale_transaction values
(0067, 3.00, '2017-01-04 14:09:45', 'debit', 2, 11);
insert into sale_transaction values
(0068, 4.00, '2017-01-04 14:22:45', 'credit', 2, 16);
insert into sale_transaction values
(0069, 6.00, '2017-01-04 14:45:45', 'credit', 2, null);
insert into sale_transaction values
(0070, 8.25, '2017-01-04 15:26:45', 'cash', 2, 4);
insert into sale_transaction values
(0071, 4.50, '2017-01-04 15:41:45', 'credit', 2, null);
insert into sale_transaction values
(0072, 5.5, '2017-01-04 16:13:45', 'credit', 2, null);

insert into sale_transaction values
(0073, 6.00, '2017-01-05 10:13:45', 'credit', 3, 3);
insert into sale_transaction values
(0074, 3.25, '2017-01-05 10:48:45', 'debit', 3, null);
insert into sale_transaction values
(0075, 3.25, '2017-01-05 11:02:45', 'credit', 3, 18);
insert into sale_transaction values
(0076, 2.00, '2017-01-05 11:20:45', 'cash', 3, null);
insert into sale_transaction values
(0077, 7.50, '2017-01-05 12:02:45', 'credit', 3, 5);
insert into sale_transaction values
(0078, 7.50, '2017-01-05 12:05:45', 'credit', 3, null);
insert into sale_transaction values
(0079, 4.5, '2017-01-05 12:23:45', 'debit', 3, 12);
insert into sale_transaction values
(0080, 9.50, '2017-01-05 13:06:45', 'credit', 3, 13);
insert into sale_transaction values
(0081, 3.00, '2017-01-05 13:14:45', 'credit', 3, null);
insert into sale_transaction values
(0082, 3.00, '2017-01-05 13:37:45', 'debit', 3, 4);
insert into sale_transaction values
(0083, 6.00, '2017-01-05 13:42:45', 'credit', 3, null);
insert into sale_transaction values
(0084, 7.50, '2017-01-05 13:50:45', 'credit', 3, 1);
insert into sale_transaction values
(0085, 3.50, '2017-01-05 14:21:45', 'cash', 3, null);
insert into sale_transaction values
(0086, 3.00, '2017-01-05 14:32:45', 'credit', 3, null);
insert into sale_transaction values
(0087, 7.50, '2017-01-05 14:46:45', 'credit', 3, 6);
insert into sale_transaction values
(0088, 12.75, '2017-01-05 15:20:45', 'credit', 3, null);
insert into sale_transaction values
(0089, 7.50, '2017-01-05 15:36:45', 'credit', 3, null);
insert into sale_transaction values
(0090, 5.00, '2017-01-05 16:24:45', 'credit', 3, 11);

insert into sale_transaction values
(0091, 3.00, '2017-01-06 10:12:45', 'debit', 4, null);
insert into sale_transaction values
(0092, 3.50, '2017-01-06 10:37:45', 'credit', 4, null);
insert into sale_transaction values
(0093, 3.00, '2017-01-06 11:08:45', 'credit', 4, 18);
insert into sale_transaction values
(0094, 4.00, '2017-01-06 11:25:45', 'credit', 4, null);
insert into sale_transaction values
(0095, 6.00, '2017-01-06 12:01:45', 'debit', 4, 7);
insert into sale_transaction values
(0096, 12.75, '2017-01-06 12:13:45', 'cash', 4, null);
insert into sale_transaction values
(0097, 3.50, '2017-01-06 12:27:45', 'cash', 4, 15);
insert into sale_transaction values
(0098, 2.00, '2017-01-06 13:06:45', 'credit', 4, null);
insert into sale_transaction values
(0099, 6.00, '2017-01-06 13:11:45', 'cash', 4, 9);
insert into sale_transaction values
(0100, 4.00, '2017-01-06 13:28:45', 'debit', 4, null);
insert into sale_transaction values
(0101, 6.00, '2017-01-06 13:37:45', 'cash', 4, 8);
insert into sale_transaction values
(0102, 4.00, '2017-01-06 13:39:45', 'credit', 4, null);
insert into sale_transaction values
(0103, 3.00, '2017-01-06 14:12:45', 'credit', 4, null);
insert into sale_transaction values
(0104, 3.50, '2017-01-06 14:20:45', 'credit', 4, 1);
insert into sale_transaction values
(0105, 9.00, '2017-01-06 14:47:45', 'debit', 4, null);
insert into sale_transaction values
(0106, 4.5, '2017-01-06 15:15:45', 'credit', 4, 2);
insert into sale_transaction values
(0107, 11.00, '2017-01-06 15:26:45', 'credit', 4, null);
insert into sale_transaction values
(0108, 8.25, '2017-01-06 16:11:45', 'credit', 4, 3);

insert into sale_transaction values
(0109, 6.00, '2017-01-07 10:13:45', 'credit', 3, 2);
insert into sale_transaction values
(0110, 3.00, '2017-01-07 10:23:45', 'credit', 3, null);
insert into sale_transaction values
(0111, 8.00, '2017-01-07 11:18:45', 'credit', 3, 5);
insert into sale_transaction values
(0112, 4.50, '2017-01-07 11:50:45', 'credit', 3, null);
insert into sale_transaction values
(0113, 10.50, '2017-01-07 12:03:45', 'credit', 3, null);
insert into sale_transaction values
(0114, 4.00, '2017-01-07 12:25:45', 'credit', 3, 12);
insert into sale_transaction values
(0115, 6.00, '2017-01-07 12:50:45', 'credit', 3, 19);
insert into sale_transaction values
(0116, 4.00, '2017-01-07 13:02:45', 'credit', 3, null);
insert into sale_transaction values
(0117, 3.00, '2017-01-07 13:12:45', 'credit', 3, 1);
insert into sale_transaction values
(0118, 3.50, '2017-01-07 13:37:45', 'credit', 3, null);
insert into sale_transaction values
(0119, 9.00, '2017-01-07 13:46:45', 'credit', 3, 3);
insert into sale_transaction values
(0120, 12.00, '2017-01-07 13:50:45', 'credit', 3, null);
insert into sale_transaction values
(0121, 3.50, '2017-01-07 14:23:45', 'credit', 3, 8);
insert into sale_transaction values
(0122, 8.25, '2017-01-07 14:30:45', 'credit', 3, null);
insert into sale_transaction values
(0123, 6.00, '2017-01-07 14:52:45', 'credit', 3, 16);
insert into sale_transaction values
(0124, 3.00, '2017-01-07 15:19:45', 'credit', 3, null);
insert into sale_transaction values
(0125, 8.00, '2017-01-07 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0126, 4.50, '2017-01-07 16:50:45', 'credit', 3, 13);


insert into sale_transaction values
(0127, 10.50, '2017-01-08 10:12:45', 'cash', 2, 20);
insert into sale_transaction values
(0128, 3.25, '2017-01-08 10:36:45', 'debit', 2, null);
insert into sale_transaction values
(0129, 6.00, '2017-01-08 11:16:45', 'cash', 2, null);
insert into sale_transaction values
(0130, 5.00, '2017-01-08 11:42:45', 'credit', 2, 3);
insert into sale_transaction values
(0131, 4.00, '2017-01-08 12:12:45', 'cash', 2, 17);
insert into sale_transaction values
(0132, 10.00, '2017-01-08 12:42:45', 'cash', 2, null);
insert into sale_transaction values
(0133, 6.50, '2017-01-08 12:57:45', 'credit', 2, null);
insert into sale_transaction values
(0134, 9.00, '2017-01-08 13:16:45', 'credit', 2, 1);
insert into sale_transaction values
(0135, 12.00, '2017-01-08 13:24:45', 'credit', 2, 11);
insert into sale_transaction values
(0136, 11.75, '2017-01-08 13:29:45', 'credit', 2, null);
insert into sale_transaction values
(0137, 11.00, '2017-01-08 13:37:45', 'credit', 2, null);
insert into sale_transaction values
(0138, 10.50, '2017-01-08 13:48:45', 'credit', 2, 18);
insert into sale_transaction values
(0139, 3.25, '2017-01-08 14:25:45', 'credit', 2, null);
insert into sale_transaction values
(0140, 6.00, '2017-01-08 14:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0141, 5.00, '2017-01-08 14:52:45', 'cash', 2, null);
insert into sale_transaction values
(0142, 3.25, '2017-01-08 15:15:45', 'cash', 2, null);
insert into sale_transaction values
(0143, 10.00, '2017-01-08 15:33:45', 'cash', 2, null);
insert into sale_transaction values
(0144, 12.00, '2017-01-08 16:11:45', 'cash', 2, 9);

insert into sale_transaction values
(0145, 8.25, '2017-01-09 10:08:45', 'cash', 3, null);
insert into sale_transaction values
(0146, 3.25, '2017-01-09 10:37:45', 'cash', 3, 11);
insert into sale_transaction values
(0147, 11.00, '2017-01-09 11:13:45', 'credit', 3, null);
insert into sale_transaction values
(0148, 3.50, '2017-01-09 11:42:45', 'credit', 3, null);
insert into sale_transaction values
(0149, 14.25, '2017-01-09 12:05:45', 'debit', 3, 12);
insert into sale_transaction values
(0150, 3.25, '2017-01-09 12:43:45', 'credit', 3, 2);
insert into sale_transaction values
(0151, 4.50, '2017-01-09 12:53:45', 'credit', 3, null);
insert into sale_transaction values
(0152, 3.50, '2017-01-09 13:01:45', 'cash', 3, null);
insert into sale_transaction values
(0153, 11.00, '2017-01-09 13:11:45', 'credit', 3, 1);
insert into sale_transaction values
(0154, 2.00, '2017-01-09 13:13:45', 'credit', 3, null);
insert into sale_transaction values
(0155, 3.00, '2017-01-09 13:23:45', 'debit', 3, 3);
insert into sale_transaction values
(0156, 11.50, '2017-01-09 13:48:45', 'credit', 3, null);
insert into sale_transaction values
(0157, 12.00, '2017-01-09 14:07:45', 'credit', 3, null);
insert into sale_transaction values
(0158, 4.00, '2017-01-09 14:19:45', 'credit', 3, 14);
insert into sale_transaction values
(0159, 3.50, '2017-01-09 14:50:45', 'credit', 3, 9);
insert into sale_transaction values
(0160, 6.00, '2017-01-09 15:26:45', 'credit', 3, null);
insert into sale_transaction values
(0161, 6.00, '2017-01-09 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0162, 3.25, '2017-01-09 16:18:45', 'credit', 3, null);

insert into sale_transaction values
(0163, 5.00, '2017-01-10 10:02:45', 'credit', 4, null);
insert into sale_transaction values
(0164, 12.75, '2017-01-10 10:43:45', 'credit', 4, 2);
insert into sale_transaction values
(0165, 3.25, '2017-01-10 11:12:45', 'debit', 4, null);
insert into sale_transaction values
(0166, 5.00, '2017-01-10 11:50:45', 'credit', 4, 20);
insert into sale_transaction values
(0167, 3.50, '2017-01-10 12:21:45', 'cash', 4, 18);
insert into sale_transaction values
(0168, 10.50, '2017-01-10 12:33:45', 'credit', 4, null);
insert into sale_transaction values
(0169, 3.00, '2017-01-10 12:50:45', 'credit', 4, null);
insert into sale_transaction values
(0170, 8.25, '2017-01-10 13:11:45', 'debit', 4, 13);
insert into sale_transaction values
(0171, 3.00, '2017-01-10 13:20:45', 'cash', 4, 7);
insert into sale_transaction values
(0172, 3.25, '2017-01-10 13:26:45', 'debit', 4, null);
insert into sale_transaction values
(0173, 5.00, '2017-01-10 13:36:45', 'cash', 4, null);
insert into sale_transaction values
(0174, 11.50, '2017-01-10 13:52:45', 'credit', 4, 3);
insert into sale_transaction values
(0175, 8.25, '2017-01-10 14:12:45', 'cash', 4, 17);
insert into sale_transaction values
(0176, 2.00, '2017-01-10 14:42:45', 'cash', 4, null);
insert into sale_transaction values
(0177, 3.25, '2017-01-10 14:57:45', 'credit', 4, null);
insert into sale_transaction values
(0178, 6.50, '2017-01-10 15:16:45', 'credit', 4, 1);
insert into sale_transaction values
(0179, 5.00, '2017-01-10 15:24:45', 'debit', 4, 11);
insert into sale_transaction values
(0180, 8.00, '2017-01-10 16:29:45', 'credit', 4, null);

insert into sale_transaction values
(0181, 4.50, '2017-01-11 10:07:45', 'credit', 2, null);
insert into sale_transaction values
(0182, 9.50, '2017-01-11 10:28:45', 'credit', 2, 3);
insert into sale_transaction values
(0183, 7.50, '2017-01-11 11:25:45', 'credit', 2, null);
insert into sale_transaction values
(0184, 7.50, '2017-01-11 11:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0185, 6.50, '2017-01-11 12:13:45', 'cash', 2, null);
insert into sale_transaction values
(0186, 9.50, '2017-01-11 12:15:45', 'cash', 2, null);
insert into sale_transaction values
(0187, 4.00, '2017-01-11 12:37:45', 'debit', 2, null);
insert into sale_transaction values
(0188, 3.50, '2017-01-11 13:11:45', 'cash', 2, 9);
insert into sale_transaction values
(0189, 3.00, '2017-01-11 13:28:45', 'credit', 2, null);
insert into sale_transaction values
(0190, 7.50, '2017-01-11 13:37:45', 'cash', 2, 20);
insert into sale_transaction values
(0191, 8.25, '2017-01-11 13:39:45', 'credit', 2, null);
insert into sale_transaction values
(0192, 4.50, '2017-01-11 13:46:45', 'credit', 2, null);
insert into sale_transaction values
(0193, 7.50, '2017-01-11 14:09:45', 'debit', 2, 11);
insert into sale_transaction values
(0194, 5.00, '2017-01-11 14:22:45', 'credit', 2, 16);
insert into sale_transaction values
(0195, 3.00, '2017-01-11 14:45:45', 'credit', 2, null);
insert into sale_transaction values
(0196, 3.50, '2017-01-11 15:26:45', 'cash', 2, 4);
insert into sale_transaction values
(0197, 3.00, '2017-01-11 15:41:45', 'credit', 2, null);
insert into sale_transaction values
(0198, 4.00, '2017-01-11 16:13:45', 'credit', 2, null);

insert into sale_transaction values
(0199, 6.00, '2017-01-12 10:13:45', 'credit', 3, 3);
insert into sale_transaction values
(0200, 8.25, '2017-01-12 10:48:45', 'debit', 3, null);
insert into sale_transaction values
(0201, 4.50, '2017-01-12 11:02:45', 'credit', 3, 18);
insert into sale_transaction values
(0202, 5.50, '2017-01-12 11:20:45', 'cash', 3, null);
insert into sale_transaction values
(0203, 6.00, '2017-01-12 12:02:45', 'credit', 3, 5);
insert into sale_transaction values
(0204, 3.25, '2017-01-12 12:05:45', 'credit', 3, null);
insert into sale_transaction values
(0205, 3.25, '2017-01-12 12:23:45', 'debit', 3, 12);
insert into sale_transaction values
(0206, 2.00, '2017-01-12 13:06:45', 'credit', 3, 13);
insert into sale_transaction values
(0207, 7.50, '2017-01-12 13:14:45', 'credit', 3, null);
insert into sale_transaction values
(0208, 7.50, '2017-01-12 13:37:45', 'debit', 3, 4);
insert into sale_transaction values
(0209, 4.50, '2017-01-12 13:42:45', 'credit', 3, null);
insert into sale_transaction values
(0210, 9.50, '2017-01-12 13:50:45', 'credit', 3, 1);
insert into sale_transaction values
(0211, 3.00, '2017-01-12 14:21:45', 'cash', 3, null);
insert into sale_transaction values
(0212, 3.00, '2017-01-12 14:32:45', 'credit', 3, null);
insert into sale_transaction values
(0213, 6.00, '2017-01-12 14:46:45', 'credit', 3, 6);
insert into sale_transaction values
(0214, 7.50, '2017-01-12 15:20:45', 'credit', 3, null);
insert into sale_transaction values
(0215, 3.50, '2017-01-12 15:36:45', 'credit', 3, null);
insert into sale_transaction values
(0216, 3.00, '2017-01-12 16:24:45', 'credit', 3, 11);

insert into sale_transaction values
(0217, 7.50, '2017-01-13 10:12:45', 'debit', 4, null);
insert into sale_transaction values
(0218, 12.75, '2017-01-13 10:37:45', 'credit', 4, null);
insert into sale_transaction values
(0219, 7.50, '2017-01-13 11:08:45', 'credit', 4, 18);
insert into sale_transaction values
(0220, 5.00, '2017-01-13 11:25:45', 'credit', 4, null);
insert into sale_transaction values
(0221, 3.00, '2017-01-13 12:01:45', 'debit', 4, 7);
insert into sale_transaction values
(0222, 3.50, '2017-01-13 12:13:45', 'cash', 4, null);
insert into sale_transaction values
(0223, 3.00, '2017-01-13 12:27:45', 'cash', 4, 15);
insert into sale_transaction values
(0224, 4.00, '2017-01-13 13:06:45', 'credit', 4, null);
insert into sale_transaction values
(0225, 6.00, '2017-01-13 13:11:45', 'cash', 4, 9);
insert into sale_transaction values
(0226, 12.75, '2017-01-13 13:28:45', 'debit', 4, null);
insert into sale_transaction values
(0227, 3.50, '2017-01-13 13:37:45', 'cash', 4, 8);
insert into sale_transaction values
(0228, 2.00, '2017-01-13 13:39:45', 'credit', 4, null);
insert into sale_transaction values
(0229, 6.00, '2017-01-13 14:12:45', 'credit', 4, null);
insert into sale_transaction values
(0230, 4.00, '2017-01-13 14:20:45', 'credit', 4, 1);
insert into sale_transaction values
(0231, 6.00, '2017-01-13 14:47:45', 'debit', 4, null);
insert into sale_transaction values
(0232, 4.00, '2017-01-13 15:15:45', 'credit', 4, 2);
insert into sale_transaction values
(0233, 3.00, '2017-01-13 15:26:45', 'credit', 4, null);
insert into sale_transaction values
(0234, 3.50, '2017-01-13 16:11:45', 'credit', 4, 3);

insert into sale_transaction values
(0235, 9.00, '2017-01-14 10:13:45', 'credit', 3, 2);
insert into sale_transaction values
(0236, 4.5, '2017-01-14 10:23:45', 'credit', 3, null);
insert into sale_transaction values
(0237, 11.00, '2017-01-14 11:18:45', 'credit', 3, 5);
insert into sale_transaction values
(0238, 8.25, '2017-01-14 11:50:45', 'credit', 3, null);
insert into sale_transaction values
(0239, 6.00, '2017-01-14 12:03:45', 'credit', 3, null);
insert into sale_transaction values
(0240, 3.00, '2017-01-14 12:25:45', 'credit', 3, 12);
insert into sale_transaction values
(0241, 8.00, '2017-01-14 12:50:45', 'credit', 3, 19);
insert into sale_transaction values
(0242, 4.50, '2017-01-14 13:02:45', 'credit', 3, null);
insert into sale_transaction values
(0243, 10.50, '2017-01-14 13:12:45', 'credit', 3, 1);
insert into sale_transaction values
(0244, 4.00, '2017-01-14 13:37:45', 'credit', 3, null);
insert into sale_transaction values
(0245, 6.00, '2017-01-14 13:46:45', 'credit', 3, 3);
insert into sale_transaction values
(0246, 4.00, '2017-01-14 13:50:45', 'credit', 3, null);
insert into sale_transaction values
(0247, 3.00, '2017-01-14 14:23:45', 'credit', 3, 8);
insert into sale_transaction values
(0248, 3.50, '2017-01-14 14:30:45', 'credit', 3, null);
insert into sale_transaction values
(0249, 9.00, '2017-01-14 14:52:45', 'credit', 3, 16);
insert into sale_transaction values
(0250, 12.00, '2017-01-14 15:19:45', 'credit', 3, null);
insert into sale_transaction values
(0251, 3.50, '2017-01-14 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0252, 8.25, '2017-01-14 16:50:45', 'credit', 3, 13);


insert into sale_transaction values
(0253, 6.00, '2017-01-15 10:12:45', 'cash', 2, 20);
insert into sale_transaction values
(0254, 3.00, '2017-01-15 10:36:45', 'debit', 2, null);
insert into sale_transaction values
(0255, 8.00, '2017-01-15 11:16:45', 'cash', 2, null);
insert into sale_transaction values
(0256, 4.50, '2017-01-15 11:42:45', 'credit', 2, 3);
insert into sale_transaction values
(0257, 10.50, '2017-01-15 12:12:45', 'cash', 2, 17);
insert into sale_transaction values
(0258, 3.25, '2017-01-15 12:42:45', 'cash', 2, null);
insert into sale_transaction values
(0259, 6.00, '2017-01-15 12:57:45', 'credit', 2, null);
insert into sale_transaction values
(0260, 5.00, '2017-01-15 13:16:45', 'credit', 2, 1);
insert into sale_transaction values
(0261, 4.00, '2017-01-15 13:24:45', 'credit', 2, 11);
insert into sale_transaction values
(0262, 10.00, '2017-01-15 13:29:45', 'credit', 2, null);
insert into sale_transaction values
(0263, 6.50, '2017-01-15 13:37:45', 'credit', 2, null);
insert into sale_transaction values
(0264, 9.00, '2017-01-15 13:48:45', 'credit', 2, 18);
insert into sale_transaction values
(0265, 12.00, '2017-01-15 14:25:45', 'credit', 2, null);
insert into sale_transaction values
(0266, 11.75, '2017-01-15 14:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0267, 11.00, '2017-01-15 14:52:45', 'cash', 2, null);
insert into sale_transaction values
(0268, 10.50, '2017-01-15 15:15:45', 'cash', 2, null);
insert into sale_transaction values
(0269, 3.25, '2017-01-15 15:33:45', 'cash', 2, null);
insert into sale_transaction values
(0270, 6.00, '2017-01-15 16:11:45', 'cash', 2, 9);

insert into sale_transaction values
(0271, 5.00, '2017-01-16 10:08:45', 'cash', 3, null);
insert into sale_transaction values
(0272, 3.25, '2017-01-16 10:37:45', 'cash', 3, 11);
insert into sale_transaction values
(0273, 10.00, '2017-01-16 11:13:45', 'credit', 3, null);
insert into sale_transaction values
(0274, 12.00, '2017-01-16 11:42:45', 'credit', 3, null);
insert into sale_transaction values
(0275, 8.25, '2017-01-16 12:05:45', 'debit', 3, 12);
insert into sale_transaction values
(0276, 3.25, '2017-01-16 12:43:45', 'credit', 3, 2);
insert into sale_transaction values
(0277, 11.00, '2017-01-16 12:53:45', 'credit', 3, null);
insert into sale_transaction values
(0278, 3.50, '2017-01-16 13:01:45', 'cash', 3, null);
insert into sale_transaction values
(0279, 14.25, '2017-01-16 13:11:45', 'credit', 3, 1);
insert into sale_transaction values
(0280, 3.25, '2017-01-16 13:13:45', 'credit', 3, null);
insert into sale_transaction values
(0281, 4.50, '2017-01-16 13:23:45', 'debit', 3, 3);
insert into sale_transaction values
(0282, 3.50, '2017-01-16 13:48:45', 'credit', 3, null);
insert into sale_transaction values
(0283, 11.00, '2017-01-16 14:07:45', 'credit', 3, null);
insert into sale_transaction values
(0284, 2.00, '2017-01-16 14:19:45', 'credit', 3, 14);
insert into sale_transaction values
(0285, 3.00, '2017-01-16 14:50:45', 'credit', 3, 9);
insert into sale_transaction values
(0286, 11.50, '2017-01-16 15:26:45', 'credit', 3, null);
insert into sale_transaction values
(0287, 12.00, '2017-01-16 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0288, 4.00, '2017-01-16 16:18:45', 'credit', 3, null);

insert into sale_transaction values
(0289, 3.50, '2017-01-17 10:02:45', 'credit', 4, null);
insert into sale_transaction values
(0290, 6.00, '2017-01-17 10:43:45', 'credit', 4, 2);
insert into sale_transaction values
(0291, 6.00, '2017-01-17 11:12:45', 'debit', 4, null);
insert into sale_transaction values
(0292, 3.25, '2017-01-17 11:50:45', 'credit', 4, 20);
insert into sale_transaction values
(0293, 5.00, '2017-01-17 12:21:45', 'cash', 4, 18);
insert into sale_transaction values
(0294, 12.75, '2017-01-17 12:33:45', 'credit', 4, null);
insert into sale_transaction values
(0295, 3.25, '2017-01-17 12:50:45', 'credit', 4, null);
insert into sale_transaction values
(0296, 5.00, '2017-01-17 13:11:45', 'debit', 4, 13);
insert into sale_transaction values
(0297, 3.50, '2017-01-17 13:20:45', 'cash', 4, 7);
insert into sale_transaction values
(0298, 10.50, '2017-01-17 13:26:45', 'debit', 4, null);
insert into sale_transaction values
(0299, 3.00, '2017-01-17 13:36:45', 'cash', 4, null);
insert into sale_transaction values
(0300, 8.25, '2017-01-17 13:52:45', 'credit', 4, 3);
insert into sale_transaction values
(0301, 3.00, '2017-01-17 14:12:45', 'cash', 4, 17);
insert into sale_transaction values
(0302, 3.25, '2017-01-17 14:42:45', 'cash', 4, null);
insert into sale_transaction values
(0303, 5.00, '2017-01-17 14:57:45', 'credit', 4, null);
insert into sale_transaction values
(0304, 11.50, '2017-01-17 15:16:45', 'credit', 4, 1);
insert into sale_transaction values
(0305, 8.25, '2017-01-17 15:24:45', 'debit', 4, 11);
insert into sale_transaction values
(0306, 2.00, '2017-01-17 16:29:45', 'credit', 4, null);

insert into sale_transaction values
(0307, 3.25, '2017-01-18 10:07:45', 'credit', 2, null);
insert into sale_transaction values
(0308, 6.50, '2017-01-18 10:28:45', 'credit', 2, 3);
insert into sale_transaction values
(0309, 5.00, '2017-01-18 11:25:45', 'credit', 2, null);
insert into sale_transaction values
(0310, 8.00, '2017-01-18 11:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0311, 4.50, '2017-01-18 12:13:45', 'cash', 2, null);
insert into sale_transaction values
(0312, 9.50, '2017-01-18 12:15:45', 'cash', 2, null);
insert into sale_transaction values
(0313, 7.50, '2017-01-18 12:37:45', 'debit', 2, null);
insert into sale_transaction values
(0314, 7.50, '2017-01-18 13:11:45', 'cash', 2, 9);
insert into sale_transaction values
(0315, 6.50, '2017-01-18 13:28:45', 'credit', 2, null);
insert into sale_transaction values
(0316, 9.50, '2017-01-18 13:37:45', 'cash', 2, 20);
insert into sale_transaction values
(0317, 4.00, '2017-01-18 13:39:45', 'credit', 2, null);
insert into sale_transaction values
(0318, 3.50, '2017-01-18 13:46:45', 'credit', 2, null);
insert into sale_transaction values
(0319, 3.00, '2017-01-18 14:09:45', 'debit', 2, 11);
insert into sale_transaction values
(0320, 7.50, '2017-01-18 14:22:45', 'credit', 2, 16);
insert into sale_transaction values
(0321, 8.25, '2017-01-18 14:45:45', 'credit', 2, null);
insert into sale_transaction values
(0322, 4.50, '2017-01-18 15:26:45', 'cash', 2, 4);
insert into sale_transaction values
(0323, 7.50, '2017-01-18 15:41:45', 'credit', 2, null);
insert into sale_transaction values
(0324, 5.00, '2017-01-18 16:13:45', 'credit', 2, null);

insert into sale_transaction values
(0325, 3.00, '2017-01-19 10:13:45', 'credit', 3, 3);
insert into sale_transaction values
(0326, 3.50, '2017-01-19 10:48:45', 'debit', 3, null);
insert into sale_transaction values
(0327, 3.00, '2017-01-19 11:02:45', 'credit', 3, 18);
insert into sale_transaction values
(0328, 4.00, '2017-01-19 11:20:45', 'cash', 3, null);
insert into sale_transaction values
(0329, 6.00, '2017-01-19 12:02:45', 'credit', 3, 5);
insert into sale_transaction values
(0330, 8.25, '2017-01-19 12:05:45', 'credit', 3, null);
insert into sale_transaction values
(0331, 4.50, '2017-01-19 12:23:45', 'debit', 3, 12);
insert into sale_transaction values
(0332, 5.50, '2017-01-19 13:06:45', 'credit', 3, 13);
insert into sale_transaction values
(0333, 6.00, '2017-01-19 13:14:45', 'credit', 3, null);
insert into sale_transaction values
(0334, 3.25, '2017-01-19 13:37:45', 'debit', 3, 4);
insert into sale_transaction values
(0335, 3.25, '2017-01-19 13:42:45', 'credit', 3, null);
insert into sale_transaction values
(0336, 2.00, '2017-01-19 13:50:45', 'credit', 3, 1);
insert into sale_transaction values
(0337, 7.50, '2017-01-19 14:21:45', 'cash', 3, null);
insert into sale_transaction values
(0338, 7.50, '2017-01-19 14:32:45', 'credit', 3, null);
insert into sale_transaction values
(0339, 4.50, '2017-01-19 14:46:45', 'credit', 3, 6);
insert into sale_transaction values
(0340, 9.50, '2017-01-19 15:20:45', 'credit', 3, null);
insert into sale_transaction values
(0341, 3.00, '2017-01-19 15:36:45', 'credit', 3, null);
insert into sale_transaction values
(0342, 3.00, '2017-01-19 16:24:45', 'credit', 3, 11);

insert into sale_transaction values
(0343, 6.00, '2017-01-20 10:12:45', 'debit', 4, null);
insert into sale_transaction values
(0344, 7.50, '2017-01-20 10:37:45', 'credit', 4, null);
insert into sale_transaction values
(0345, 3.50, '2017-01-20 11:08:45', 'credit', 4, 18);
insert into sale_transaction values
(0346, 3.00, '2017-01-20 11:25:45', 'credit', 4, null);
insert into sale_transaction values
(0347, 7.50, '2017-01-20 12:01:45', 'debit', 4, 7);
insert into sale_transaction values
(0348, 12.75, '2017-01-20 12:13:45', 'cash', 4, null);
insert into sale_transaction values
(0349, 7.50, '2017-01-20 12:27:45', 'cash', 4, 15);
insert into sale_transaction values
(0350, 5.00, '2017-01-20 13:06:45', 'credit', 4, null);
insert into sale_transaction values
(0351, 3.00, '2017-01-20 13:11:45', 'cash', 4, 9);
insert into sale_transaction values
(0352, 3.50, '2017-01-20 13:28:45', 'debit', 4, null);
insert into sale_transaction values
(0353, 3.00, '2017-01-20 13:37:45', 'cash', 4, 8);
insert into sale_transaction values
(0354, 4.00, '2017-01-20 13:39:45', 'credit', 4, null);
insert into sale_transaction values
(0355, 6.00, '2017-01-20 14:12:45', 'credit', 4, null);
insert into sale_transaction values
(0356, 12.75, '2017-01-20 14:20:45', 'credit', 4, 1);
insert into sale_transaction values
(0357, 3.50, '2017-01-20 14:47:45', 'debit', 4, null);
insert into sale_transaction values
(0358, 2.00, '2017-01-20 15:15:45', 'credit', 4, 2);
insert into sale_transaction values
(0359, 6.00, '2017-01-20 15:26:45', 'credit', 4, null);
insert into sale_transaction values
(0360, 4.00, '2017-01-20 16:11:45', 'credit', 4, 3);

insert into sale_transaction values
(0361, 6.00, '2017-01-21 10:13:45', 'credit', 3, 2);
insert into sale_transaction values
(0362, 4.00, '2017-01-21 10:23:45', 'credit', 3, null);
insert into sale_transaction values
(0363, 3.00, '2017-01-21 11:18:45', 'credit', 3, 5);
insert into sale_transaction values
(0364, 3.50, '2017-01-21 11:50:45', 'credit', 3, null);
insert into sale_transaction values
(0365, 9.00, '2017-01-21 12:03:45', 'credit', 3, null);
insert into sale_transaction values
(0366, 4.50, '2017-01-21 12:25:45', 'credit', 3, 12);
insert into sale_transaction values
(0367, 11.00, '2017-01-21 12:50:45', 'credit', 3, 19);
insert into sale_transaction values
(0368, 8.25, '2017-01-21 13:02:45', 'credit', 3, null);
insert into sale_transaction values
(0369, 6.00, '2017-01-21 13:12:45', 'credit', 3, 1);
insert into sale_transaction values
(0370, 3.00, '2017-01-21 13:37:45', 'credit', 3, null);
insert into sale_transaction values
(0371, 8.00, '2017-01-21 13:46:45', 'credit', 3, 3);
insert into sale_transaction values
(0372, 4.50, '2017-01-21 13:50:45', 'credit', 3, null);
insert into sale_transaction values
(0373, 10.50, '2017-01-21 14:23:45', 'credit', 3, 8);
insert into sale_transaction values
(0374, 4.00, '2017-01-21 14:30:45', 'credit', 3, null);
insert into sale_transaction values
(0375, 6.00, '2017-01-21 14:52:45', 'credit', 3, 16);
insert into sale_transaction values
(0376, 4.00, '2017-01-21 15:19:45', 'credit', 3, null);
insert into sale_transaction values
(0377, 3.00, '2017-01-21 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0378, 3.50, '2017-01-21 16:50:45', 'credit', 3, 13);


insert into sale_transaction values
(0379, 9.00, '2017-01-22 10:12:45', 'cash', 2, 20);
insert into sale_transaction values
(0380, 12.00, '2017-01-22 10:36:45', 'debit', 2, null);
insert into sale_transaction values
(0381, 3.50, '2017-01-22 11:16:45', 'cash', 2, null);
insert into sale_transaction values
(0382, 8.25, '2017-01-22 11:42:45', 'credit', 2, 3);
insert into sale_transaction values
(0383, 6.00, '2017-01-22 12:12:45', 'cash', 2, 17);
insert into sale_transaction values
(0384, 3.00, '2017-01-22 12:42:45', 'cash', 2, null);
insert into sale_transaction values
(0385, 8.00, '2017-01-22 12:57:45', 'credit', 2, null);
insert into sale_transaction values
(0386, 4.50, '2017-01-22 13:16:45', 'credit', 2, 1);
insert into sale_transaction values
(0387, 10.50, '2017-01-22 13:24:45', 'credit', 2, 11);
insert into sale_transaction values
(0388, 3.25, '2017-01-22 13:29:45', 'credit', 2, null);
insert into sale_transaction values
(0389, 6.00, '2017-01-22 13:37:45', 'credit', 2, null);
insert into sale_transaction values
(0390, 5.00, '2017-01-22 13:48:45', 'credit', 2, 18);
insert into sale_transaction values
(0391, 4.00, '2017-01-22 14:25:45', 'credit', 2, null);
insert into sale_transaction values
(0392, 10.00, '2017-01-22 14:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0393, 6.50, '2017-01-22 14:52:45', 'cash', 2, null);
insert into sale_transaction values
(0394, 9.00, '2017-01-22 15:15:45', 'cash', 2, null);
insert into sale_transaction values
(0395, 12.00, '2017-01-22 15:33:45', 'cash', 2, null);
insert into sale_transaction values
(0396, 11.75, '2017-01-22 16:11:45', 'cash', 2, 9);

insert into sale_transaction values
(0397, 11.00, '2017-01-23 10:08:45', 'cash', 3, null);
insert into sale_transaction values
(0398, 10.50, '2017-01-23 10:37:45', 'cash', 3, 11);
insert into sale_transaction values
(0399, 3.25, '2017-01-23 11:13:45', 'credit', 3, null);
insert into sale_transaction values
(0400, 6.00, '2017-01-23 11:42:45', 'credit', 3, null);
insert into sale_transaction values
(0401, 5.00, '2017-01-23 12:05:45', 'debit', 3, 12);
insert into sale_transaction values
(0402, 3.25, '2017-01-23 12:43:45', 'credit', 3, 2);
insert into sale_transaction values
(0403, 10.00, '2017-01-23 12:53:45', 'credit', 3, null);
insert into sale_transaction values
(0404, 12.00, '2017-01-23 13:01:45', 'cash', 3, null);
insert into sale_transaction values
(0405, 8.25, '2017-01-23 13:11:45', 'credit', 3, 1);
insert into sale_transaction values
(0406, 3.25, '2017-01-23 13:13:45', 'credit', 3, null);
insert into sale_transaction values
(0407, 11.00, '2017-01-23 13:23:45', 'debit', 3, 3);
insert into sale_transaction values
(0408, 3.50, '2017-01-23 13:48:45', 'credit', 3, null);
insert into sale_transaction values
(0409, 14.25, '2017-01-23 14:07:45', 'credit', 3, null);
insert into sale_transaction values
(0410, 3.25, '2017-01-23 14:19:45', 'credit', 3, 14);
insert into sale_transaction values
(0411, 4.50, '2017-01-23 14:50:45', 'credit', 3, 9);
insert into sale_transaction values
(0412, 3.50, '2017-01-23 15:26:45', 'credit', 3, null);
insert into sale_transaction values
(0413, 11.00, '2017-01-23 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0414, 2.00, '2017-01-23 16:18:45', 'credit', 3, null);

insert into sale_transaction values
(0415, 3.00, '2017-01-24 10:02:45', 'credit', 4, null);
insert into sale_transaction values
(0416, 11.50, '2017-01-24 10:43:45', 'credit', 4, 2);
insert into sale_transaction values
(0417, 12.00, '2017-01-24 11:12:45', 'debit', 4, null);
insert into sale_transaction values
(0418, 4.00, '2017-01-24 11:50:45', 'credit', 4, 20);
insert into sale_transaction values
(0419, 3.50, '2017-01-24 12:21:45', 'cash', 4, 18);
insert into sale_transaction values
(0420, 6.00, '2017-01-24 12:33:45', 'credit', 4, null);
insert into sale_transaction values
(0421, 6.00, '2017-01-24 12:50:45', 'credit', 4, null);
insert into sale_transaction values
(0422, 3.25, '2017-01-24 13:11:45', 'debit', 4, 13);
insert into sale_transaction values
(0423, 5.00, '2017-01-24 13:20:45', 'cash', 4, 7);
insert into sale_transaction values
(0424, 12.75, '2017-01-24 13:26:45', 'debit', 4, null);
insert into sale_transaction values
(0425, 3.25, '2017-01-24 13:36:45', 'cash', 4, null);
insert into sale_transaction values
(0426, 5.00, '2017-01-24 13:52:45', 'credit', 4, 3);
insert into sale_transaction values
(0427, 3.50, '2017-01-24 14:12:45', 'cash', 4, 17);
insert into sale_transaction values
(0428, 10.50, '2017-01-24 14:42:45', 'cash', 4, null);
insert into sale_transaction values
(0429, 3.00, '2017-01-24 14:57:45', 'credit', 4, null);
insert into sale_transaction values
(0430, 8.25, '2017-01-24 15:16:45', 'credit', 4, 1);
insert into sale_transaction values
(0431, 3.00, '2017-01-24 15:24:45', 'debit', 4, 11);
insert into sale_transaction values
(0432, 3.25, '2017-01-24 16:29:45', 'credit', 4, null);

insert into sale_transaction values
(0433, 5.00, '2017-01-25 10:07:45', 'credit', 2, null);
insert into sale_transaction values
(0434, 11.50, '2017-01-25 10:28:45', 'credit', 2, 3);
insert into sale_transaction values
(0435, 8.25, '2017-01-25 11:25:45', 'credit', 2, null);
insert into sale_transaction values
(0436, 2.00, '2017-01-25 11:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0437, 3.25, '2017-01-25 12:13:45', 'cash', 2, null);
insert into sale_transaction values
(0438, 6.50, '2017-01-25 12:15:45', 'cash', 2, null);
insert into sale_transaction values
(0439, 5.00, '2017-01-25 12:37:45', 'debit', 2, null);
insert into sale_transaction values
(0440, 8.00, '2017-01-25 13:11:45', 'cash', 2, 9);
insert into sale_transaction values
(0441, 4.50, '2017-01-25 13:28:45', 'credit', 2, null);
insert into sale_transaction values
(0442, 9.50, '2017-01-25 13:37:45', 'cash', 2, 20);
insert into sale_transaction values
(0443, 7.50, '2017-01-25 13:39:45', 'credit', 2, null);
insert into sale_transaction values
(0444, 7.50, '2017-01-25 13:46:45', 'credit', 2, null);
insert into sale_transaction values
(0445, 6.50, '2017-01-25 14:09:45', 'debit', 2, 11);
insert into sale_transaction values
(0446, 9.50, '2017-01-25 14:22:45', 'credit', 2, 16);
insert into sale_transaction values
(0447, 4.00, '2017-01-25 14:45:45', 'credit', 2, null);
insert into sale_transaction values
(0448, 3.50, '2017-01-25 15:26:45', 'cash', 2, 4);
insert into sale_transaction values
(0449, 3.00, '2017-01-25 15:41:45', 'credit', 2, null);
insert into sale_transaction values
(0450, 7.50, '2017-01-25 16:13:45', 'credit', 2, null);

insert into sale_transaction values
(0451, 8.25, '2017-01-26 10:13:45', 'credit', 3, 3);
insert into sale_transaction values
(0452, 4.50, '2017-01-26 10:48:45', 'debit', 3, null);
insert into sale_transaction values
(0453, 7.50, '2017-01-26 11:02:45', 'credit', 3, 18);
insert into sale_transaction values
(0454, 5.00, '2017-01-26 11:20:45', 'cash', 3, null);
insert into sale_transaction values
(0455, 3.00, '2017-01-26 12:02:45', 'credit', 3, 5);
insert into sale_transaction values
(0456, 3.50, '2017-01-26 12:05:45', 'credit', 3, null);
insert into sale_transaction values
(0457, 3.00, '2017-01-26 12:23:45', 'debit', 3, 12);
insert into sale_transaction values
(0458, 4.00, '2017-01-26 13:06:45', 'credit', 3, 13);
insert into sale_transaction values
(0459, 6.00, '2017-01-26 13:14:45', 'credit', 3, null);
insert into sale_transaction values
(0460, 8.25, '2017-01-26 13:37:45', 'debit', 3, 4);
insert into sale_transaction values
(0461, 4.50, '2017-01-26 13:42:45', 'credit', 3, null);
insert into sale_transaction values
(0462, 5.50, '2017-01-26 13:50:45', 'credit', 3, 1);
insert into sale_transaction values
(0463, 6.00, '2017-01-26 14:21:45', 'cash', 3, null);
insert into sale_transaction values
(0464, 3.25, '2017-01-26 14:32:45', 'credit', 3, null);
insert into sale_transaction values
(0465, 3.25, '2017-01-26 14:46:45', 'credit', 3, 6);
insert into sale_transaction values
(0466, 2.00, '2017-01-26 15:20:45', 'credit', 3, null);
insert into sale_transaction values
(0467, 7.50, '2017-01-26 15:36:45', 'credit', 3, null);
insert into sale_transaction values
(0468, 7.50, '2017-01-26 16:24:45', 'credit', 3, 11);

insert into sale_transaction values
(0469, 4.50, '2017-01-27 10:12:45', 'debit', 4, null);
insert into sale_transaction values
(0470, 9.50, '2017-01-27 10:37:45', 'credit', 4, null);
insert into sale_transaction values
(0471, 3.00, '2017-01-27 11:08:45', 'credit', 4, 18);
insert into sale_transaction values
(0472, 3.00, '2017-01-27 11:25:45', 'credit', 4, null);
insert into sale_transaction values
(0473, 6.00, '2017-01-27 12:01:45', 'debit', 4, 7);
insert into sale_transaction values
(0474, 7.50, '2017-01-27 12:13:45', 'cash', 4, null);
insert into sale_transaction values
(0475, 3.50, '2017-01-27 12:27:45', 'cash', 4, 15);
insert into sale_transaction values
(0476, 3.00, '2017-01-27 13:06:45', 'credit', 4, null);
insert into sale_transaction values
(0477, 7.50, '2017-01-27 13:11:45', 'cash', 4, 9);
insert into sale_transaction values
(0478, 12.75, '2017-01-27 13:28:45', 'debit', 4, null);
insert into sale_transaction values
(0479, 7.50, '2017-01-27 13:37:45', 'cash', 4, 8);
insert into sale_transaction values
(0480, 5.00, '2017-01-27 13:39:45', 'credit', 4, null);
insert into sale_transaction values
(0481, 3.00, '2017-01-27 14:12:45', 'credit', 4, null);
insert into sale_transaction values
(0482, 3.50, '2017-01-27 14:20:45', 'credit', 4, 1);
insert into sale_transaction values
(0483, 3.00, '2017-01-27 14:47:45', 'debit', 4, null);
insert into sale_transaction values
(0484, 4.00, '2017-01-27 15:15:45', 'credit', 4, 2);
insert into sale_transaction values
(0485, 6.00, '2017-01-27 15:26:45', 'credit', 4, null);
insert into sale_transaction values
(0486, 12.75, '2017-01-27 16:11:45', 'credit', 4, 3);

insert into sale_transaction values
(0487, 3.50, '2017-01-28 10:13:45', 'credit', 3, 2);
insert into sale_transaction values
(0488, 2.00, '2017-01-28 10:23:45', 'credit', 3, null);
insert into sale_transaction values
(0489, 6.00, '2017-01-28 11:18:45', 'credit', 3, 5);
insert into sale_transaction values
(0490, 4.00, '2017-01-28 11:50:45', 'credit', 3, null);
insert into sale_transaction values
(0491, 6.00, '2017-01-28 12:03:45', 'credit', 3, null);
insert into sale_transaction values
(0492, 4.00, '2017-01-28 12:25:45', 'credit', 3, 12);
insert into sale_transaction values
(0493, 3.00, '2017-01-28 12:50:45', 'credit', 3, 19);
insert into sale_transaction values
(0494, 3.50, '2017-01-28 13:02:45', 'credit', 3, null);
insert into sale_transaction values
(0495, 9.00, '2017-01-28 13:12:45', 'credit', 3, 1);
insert into sale_transaction values
(0496, 4.50, '2017-01-28 13:37:45', 'credit', 3, null);
insert into sale_transaction values
(0497, 11.00, '2017-01-28 13:46:45', 'credit', 3, 3);
insert into sale_transaction values
(0498, 8.25, '2017-01-28 13:50:45', 'credit', 3, null);
insert into sale_transaction values
(0499, 6.00, '2017-01-28 14:23:45', 'credit', 3, 8);
insert into sale_transaction values
(0500, 3.00, '2017-01-28 14:30:45', 'credit', 3, null);
insert into sale_transaction values
(0501, 8.00, '2017-01-28 14:52:45', 'credit', 3, 16);
insert into sale_transaction values
(0502, 4.50, '2017-01-28 15:19:45', 'credit', 3, null);
insert into sale_transaction values
(0503, 10.50, '2017-01-28 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0504, 4.00, '2017-01-28 16:50:45', 'credit', 3, 13);


insert into sale_transaction values
(0505, 6.00, '2017-01-29 10:12:45', 'cash', 2, 20);
insert into sale_transaction values
(0506, 4.00, '2017-01-29 10:36:45', 'debit', 2, null);
insert into sale_transaction values
(0507, 3.00, '2017-01-29 11:16:45', 'cash', 2, null);
insert into sale_transaction values
(0508, 3.50, '2017-01-29 11:42:45', 'credit', 2, 3);
insert into sale_transaction values
(0509, 9.00, '2017-01-29 12:12:45', 'cash', 2, 17);
insert into sale_transaction values
(0510, 12.00, '2017-01-29 12:42:45', 'cash', 2, null);
insert into sale_transaction values
(0511, 3.50, '2017-01-29 12:57:45', 'credit', 2, null);
insert into sale_transaction values
(0512, 8.25, '2017-01-29 13:16:45', 'credit', 2, 1);
insert into sale_transaction values
(0513, 6.00, '2017-01-29 13:24:45', 'credit', 2, 11);
insert into sale_transaction values
(0514, 3.00, '2017-01-29 13:29:45', 'credit', 2, null);
insert into sale_transaction values
(0515, 8.00, '2017-01-29 13:37:45', 'credit', 2, null);
insert into sale_transaction values
(0516, 4.50, '2017-01-29 13:48:45', 'credit', 2, 18);
insert into sale_transaction values
(0517, 10.50, '2017-01-29 14:25:45', 'credit', 2, null);
insert into sale_transaction values
(0518, 3.25, '2017-01-29 14:51:45', 'debit', 2, 7);
insert into sale_transaction values
(0519, 6.00, '2017-01-29 14:52:45', 'cash', 2, null);
insert into sale_transaction values
(0520, 5.00, '2017-01-29 15:15:45', 'cash', 2, null);
insert into sale_transaction values
(0521, 4.00, '2017-01-29 15:33:45', 'cash', 2, null);
insert into sale_transaction values
(0522, 10.00, '2017-01-29 16:11:45', 'cash', 2, 9);

insert into sale_transaction values
(0523, 6.50, '2017-01-30 10:08:45', 'cash', 3, null);
insert into sale_transaction values
(0524, 9.00, '2017-01-30 10:37:45', 'cash', 3, 11);
insert into sale_transaction values
(0525, 12.00, '2017-01-30 11:13:45', 'credit', 3, null);
insert into sale_transaction values
(0526, 11.75, '2017-01-30 11:42:45', 'credit', 3, null);
insert into sale_transaction values
(0527, 11.00, '2017-01-30 12:05:45', 'debit', 3, 12);
insert into sale_transaction values
(0528, 10.50, '2017-01-30 12:43:45', 'credit', 3, 2);
insert into sale_transaction values
(0529, 3.25, '2017-01-30 12:53:45', 'credit', 3, null);
insert into sale_transaction values
(0530, 6.00, '2017-01-30 13:01:45', 'cash', 3, null);
insert into sale_transaction values
(0531, 5.00, '2017-01-30 13:11:45', 'credit', 3, 1);
insert into sale_transaction values
(0532, 3.25, '2017-01-30 13:13:45', 'credit', 3, null);
insert into sale_transaction values
(0533, 10.00, '2017-01-30 13:23:45', 'debit', 3, 3);
insert into sale_transaction values
(0534, 12.00, '2017-01-30 13:48:45', 'credit', 3, null);
insert into sale_transaction values
(0535, 8.25, '2017-01-30 14:07:45', 'credit', 3, null);
insert into sale_transaction values
(0536, 3.25, '2017-01-30 14:19:45', 'credit', 3, 14);
insert into sale_transaction values
(0537, 11.00, '2017-01-30 14:50:45', 'credit', 3, 9);
insert into sale_transaction values
(0538, 3.50, '2017-01-30 15:26:45', 'credit', 3, null);
insert into sale_transaction values
(0539, 14.25, '2017-01-30 15:50:45', 'credit', 3, null);
insert into sale_transaction values
(0540, 3.25, '2017-01-30 16:18:45', 'credit', 3, null);

insert into sale_transaction values
(0541, 4.50, '2017-01-31 10:02:45', 'credit', 4, null);
insert into sale_transaction values
(0542, 3.50, '2017-01-31 10:43:45', 'credit', 4, 2);
insert into sale_transaction values
(0543, 11.00, '2017-01-31 11:12:45', 'debit', 4, null);
insert into sale_transaction values
(0544, 2.00, '2017-01-31 11:50:45', 'credit', 4, 20);
insert into sale_transaction values
(0545, 3.00, '2017-01-31 12:21:45', 'cash', 4, 18);
insert into sale_transaction values
(0546, 11.50, '2017-01-31 12:33:45', 'credit', 4, null);
insert into sale_transaction values
(0547, 12.00, '2017-01-31 12:50:45', 'credit', 4, null);
insert into sale_transaction values
(0548, 4.00, '2017-01-31 13:11:45', 'debit', 4, 13);
insert into sale_transaction values
(0549, 3.50, '2017-01-31 13:20:45', 'cash', 4, 7);
insert into sale_transaction values
(0550, 6.00, '2017-01-31 13:26:45', 'debit', 4, null);
insert into sale_transaction values
(0551, 6.00, '2017-01-31 13:36:45', 'cash', 4, null);
insert into sale_transaction values
(0552, 3.25, '2017-01-31 13:52:45', 'credit', 4, 3);
insert into sale_transaction values
(0553, 5.00, '2017-01-31 14:12:45', 'cash', 4, 17);
insert into sale_transaction values
(0554, 12.75, '2017-01-31 14:42:45', 'cash', 4, null);
insert into sale_transaction values
(0555, 3.25, '2017-01-31 14:57:45', 'credit', 4, null);
insert into sale_transaction values
(0556, 5.00, '2017-01-31 15:16:45', 'credit', 4, 1);
insert into sale_transaction values
(0557, 3.50, '2017-01-31 15:24:45', 'debit', 4, 11);
insert into sale_transaction values
(0558, 10.50, '2017-01-31 16:29:45', 'credit', 4, null);



-- Insert transaction items

insert into transaction_items values
(0001, 1, 2);
insert into transaction_items values
(0002, 20, 1);
insert into transaction_items values
(0002, 7, 1);
insert into transaction_items values
(0003, 2, 1);
insert into transaction_items values
(0003, 5, 1);
insert into transaction_items values
(0004, 8, 2);
insert into transaction_items values
(0005, 8, 1);
insert into transaction_items values
(0005, 22, 1);
insert into transaction_items values
(0006, 9, 1);
insert into transaction_items values
(0006, 23, 1);
insert into transaction_items values
(0007, 11, 1);
insert into transaction_items values
(0007, 24, 1);
insert into transaction_items values
(0008, 8, 1);
insert into transaction_items values
(0008, 20, 1);
insert into transaction_items values
(0009, 4, 1);
insert into transaction_items values
(0010, 11, 2);
insert into transaction_items values
(0011, 21, 1);
insert into transaction_items values
(0012, 3, 1);
insert into transaction_items values
(0013, 7, 1);
insert into transaction_items values
(0013, 20, 1);
insert into transaction_items values
(0014, 22, 1);
insert into transaction_items values
(0014, 8, 1);
insert into transaction_items values
(0015, 23, 1);
insert into transaction_items values
(0016, 4, 1);
insert into transaction_items values
(0017, 5, 1);
insert into transaction_items values
(0017, 22, 1);
insert into transaction_items values
(0018, 6, 1);
insert into transaction_items values
(0019, 20, 1);
insert into transaction_items values
(0019, 23, 1);
insert into transaction_items values
(0020, 3, 1);
insert into transaction_items values
(0021, 8, 1);
insert into transaction_items values
(0022, 5, 1);
insert into transaction_items values
(0023, 2, 1);
insert into transaction_items values
(0023, 24, 1);
insert into transaction_items values
(0024, 1, 1);
insert into transaction_items values
(0025, 2, 1);
insert into transaction_items values
(0026, 6, 1);
insert into transaction_items values
(0026,24, 1);
insert into transaction_items values
(0027, 8, 1);
insert into transaction_items values
(0027, 22, 1);
insert into transaction_items values
(0028, 7, 1);
insert into transaction_items values
(0029, 9, 1);
insert into transaction_items values
(0030, 20, 1);
insert into transaction_items values
(0031, 20, 1);
insert into transaction_items values
(0032, 3, 1);
insert into transaction_items values
(0033, 21, 1);
insert into transaction_items values
(0034, 8, 1);
insert into transaction_items values
(0034, 23, 1);
insert into transaction_items values
(0035, 4, 1);
insert into transaction_items values
(0036, 21, 1);
insert into transaction_items values
(0037, 5, 1);
insert into transaction_items values
(0038, 22, 1);
insert into transaction_items values
(0038, 11, 1);
insert into transaction_items values
(0039, 10, 1);
insert into transaction_items values
(0040, 23, 1);
insert into transaction_items values
(0041, 2, 1);
insert into transaction_items values
(0042, 4, 1);
insert into transaction_items values
(0043, 21, 1);
insert into transaction_items values
(0044, 22, 1);
insert into transaction_items values
(0044, 7, 1);
insert into transaction_items values
(0045, 23, 1);
insert into transaction_items values
(0046, 1, 1);
insert into transaction_items values
(0047, 3, 1);
insert into transaction_items values
(0048, 9, 1);
insert into transaction_items values
(0048, 2, 1);
insert into transaction_items values
(0049, 21, 1);
insert into transaction_items values
(0050, 24, 1);
insert into transaction_items values
(0051, 8, 1);
insert into transaction_items values
(0052, 20, 1);
insert into transaction_items values
(0052, 5, 1);
insert into transaction_items values
(0053, 22, 1);
insert into transaction_items values
(0054, 22, 1);
insert into transaction_items values
(0055, 1, 1);
insert into transaction_items values
(0055, 8, 1);
insert into transaction_items values
(0056, 20, 1);
insert into transaction_items values
(0056, 5, 1);
insert into transaction_items values
(0057, 7, 1);
insert into transaction_items values
(0058, 9, 1);
insert into transaction_items values
(0059, 2, 1);
insert into transaction_items values
(0060, 22, 1);
insert into transaction_items values
(0061, 23, 1);
insert into transaction_items values
(0062, 8, 1);
insert into transaction_items values
(0063, 22, 1);
insert into transaction_items values
(0064, 21, 1);
insert into transaction_items values
(0065, 2, 1);
insert into transaction_items values
(0066, 5, 1);
insert into transaction_items values
(0067, 11, 1);
insert into transaction_items values
(0068, 7, 1);
insert into transaction_items values
(0069, 20, 1);
insert into transaction_items values
(0070, 23, 1);
insert into transaction_items values
(0071, 8, 1);
insert into transaction_items values
(0072, 9, 1);
insert into transaction_items values
(0072, 1, 1);
insert into transaction_items values
(0073, 20, 1);
insert into transaction_items values
(0074, 3, 1);
insert into transaction_items values
(0075, 4, 1);
insert into transaction_items values
(0076, 1, 1);
insert into transaction_items values
(0077, 22, 1);
insert into transaction_items values
(0078, 22, 1);
insert into transaction_items values
(0079, 8, 1);
insert into transaction_items values
(0080, 6, 1);
insert into transaction_items values
(0080, 20, 1);
insert into transaction_items values
(0081, 2, 1);
insert into transaction_items values
(0082, 2, 1);
insert into transaction_items values
(0083, 20, 1);
insert into transaction_items values
(0084, 5, 1);
insert into transaction_items values
(0084, 7, 1);
insert into transaction_items values
(0085, 9, 1);
insert into transaction_items values
(0086, 2, 1);
insert into transaction_items values
(0087, 22, 1);
insert into transaction_items values
(0088, 23, 1);
insert into transaction_items values
(0088, 8, 1);
insert into transaction_items values
(0089, 22, 1);
insert into transaction_items values
(0090, 21, 1);
insert into transaction_items values
(0091, 2, 1);
insert into transaction_items values
(0092, 5, 1);
insert into transaction_items values
(0093, 11, 1);
insert into transaction_items values
(0094, 7, 1);
insert into transaction_items values
(0095, 20, 1);
insert into transaction_items values
(0096, 23, 1);
insert into transaction_items values
(0096, 8, 1);
insert into transaction_items values
(0097, 9, 1);
insert into transaction_items values
(0098, 1, 1);
insert into transaction_items values
(0099, 20, 1);
insert into transaction_items values
(0100, 1, 2);
insert into transaction_items values
(0101, 20, 1);
insert into transaction_items values
(0102, 7, 1);
insert into transaction_items values
(0103, 2, 1);
insert into transaction_items values
(0104, 5, 1);
insert into transaction_items values
(0105, 8, 2);
insert into transaction_items values
(0106, 8, 1);
insert into transaction_items values
(0107, 22, 1);
insert into transaction_items values
(0107, 9, 1);
insert into transaction_items values
(0108, 23, 1);
insert into transaction_items values
(0109, 20, 1);
insert into transaction_items values
(0110, 11, 1);
insert into transaction_items values
(0111, 24, 1);
insert into transaction_items values
(0112, 8, 1);
insert into transaction_items values
(0113, 8, 1);
insert into transaction_items values
(0113, 20, 1);
insert into transaction_items values
(0114, 1, 2);
insert into transaction_items values
(0115, 20, 1);
insert into transaction_items values
(0116, 7, 1);
insert into transaction_items values
(0117, 2, 1);
insert into transaction_items values
(0118, 5, 1);
insert into transaction_items values
(0119, 8, 2);
insert into transaction_items values
(0120, 8, 1);
insert into transaction_items values
(0120, 22, 1);
insert into transaction_items values
(0121, 9, 1);
insert into transaction_items values
(0122, 23, 1);
insert into transaction_items values
(0123, 20, 1);
insert into transaction_items values
(0124, 11, 1);
insert into transaction_items values
(0125, 24, 1);
insert into transaction_items values
(0126, 8, 1);
insert into transaction_items values
(0127, 8, 1);
insert into transaction_items values
(0127, 20, 1);
insert into transaction_items values
(0128, 4, 1);
insert into transaction_items values
(0129, 11, 2);
insert into transaction_items values
(0130, 21, 1);

insert into transaction_items values
(0131, 1, 2);
insert into transaction_items values
(0132, 20, 1);
insert into transaction_items values
(0132, 7, 1);
insert into transaction_items values
(0133, 2, 1);
insert into transaction_items values
(0133, 5, 1);
insert into transaction_items values
(0134, 8, 2);
insert into transaction_items values
(0135, 8, 1);
insert into transaction_items values
(0135, 22, 1);
insert into transaction_items values
(0136, 9, 1);
insert into transaction_items values
(0136, 23, 1);
insert into transaction_items values
(0137, 11, 1);
insert into transaction_items values
(0137, 24, 1);
insert into transaction_items values
(0138, 8, 1);
insert into transaction_items values
(0138, 20, 1);
insert into transaction_items values
(0139, 4, 1);
insert into transaction_items values
(0140, 11, 2);
insert into transaction_items values
(0141, 21, 1);
insert into transaction_items values
(0142, 3, 1);
insert into transaction_items values
(0143, 7, 1);
insert into transaction_items values
(0143, 20, 1);
insert into transaction_items values
(0144, 22, 1);
insert into transaction_items values
(0144, 8, 1);
insert into transaction_items values
(0145, 23, 1);
insert into transaction_items values
(0146, 4, 1);
insert into transaction_items values
(0147, 5, 1);
insert into transaction_items values
(0147, 22, 1);
insert into transaction_items values
(0148, 6, 1);
insert into transaction_items values
(0149, 20, 1);
insert into transaction_items values
(0149, 23, 1);
insert into transaction_items values
(0150, 3, 1);
insert into transaction_items values
(0151, 8, 1);
insert into transaction_items values
(0152, 5, 1);
insert into transaction_items values
(0153, 2, 1);
insert into transaction_items values
(0153, 24, 1);
insert into transaction_items values
(0154, 1, 1);
insert into transaction_items values
(0155, 2, 1);
insert into transaction_items values
(0156, 6, 1);
insert into transaction_items values
(0156,24, 1);
insert into transaction_items values
(0157, 8, 1);
insert into transaction_items values
(0157, 22, 1);
insert into transaction_items values
(0158, 7, 1);
insert into transaction_items values
(0159, 9, 1);
insert into transaction_items values
(0160, 20, 1);
insert into transaction_items values
(0161, 20, 1);
insert into transaction_items values
(0162, 3, 1);
insert into transaction_items values
(0163, 21, 1);
insert into transaction_items values
(0164, 8, 1);
insert into transaction_items values
(0164, 23, 1);
insert into transaction_items values
(0165, 4, 1);
insert into transaction_items values
(0166, 21, 1);
insert into transaction_items values
(0167, 5, 1);
insert into transaction_items values
(0168, 22, 1);
insert into transaction_items values
(0168, 11, 1);
insert into transaction_items values
(0169, 10, 1);
insert into transaction_items values
(0170, 23, 1);
insert into transaction_items values
(0171, 2, 1);
insert into transaction_items values
(0172, 4, 1);
insert into transaction_items values
(0173, 21, 1);
insert into transaction_items values
(0174, 22, 1);
insert into transaction_items values
(0174, 7, 1);
insert into transaction_items values
(0175, 23, 1);
insert into transaction_items values
(0176, 1, 1);
insert into transaction_items values
(0177, 3, 1);
insert into transaction_items values
(0178, 9, 1);
insert into transaction_items values
(0178, 2, 1);
insert into transaction_items values
(0179, 21, 1);
insert into transaction_items values
(0180, 24, 1);
insert into transaction_items values
(0181, 8, 1);
insert into transaction_items values
(0182, 20, 1);
insert into transaction_items values
(0182, 5, 1);
insert into transaction_items values
(0183, 22, 1);
insert into transaction_items values
(0184, 22, 1);
insert into transaction_items values
(0185, 1, 1);
insert into transaction_items values
(0185, 8, 1);
insert into transaction_items values
(0186, 20, 1);
insert into transaction_items values
(0186, 5, 1);
insert into transaction_items values
(0187, 7, 1);
insert into transaction_items values
(0188, 9, 1);
insert into transaction_items values
(0189, 2, 1);
insert into transaction_items values
(0190, 22, 1);
insert into transaction_items values
(0191, 23, 1);
insert into transaction_items values
(0192, 8, 1);
insert into transaction_items values
(0193, 22, 1);
insert into transaction_items values
(0194, 21, 1);
insert into transaction_items values
(0195, 2, 1);
insert into transaction_items values
(0196, 5, 1);
insert into transaction_items values
(0197, 11, 1);
insert into transaction_items values
(0198, 7, 1);
insert into transaction_items values
(0199, 20, 1);
insert into transaction_items values
(0200, 23, 1);
insert into transaction_items values
(0201, 8, 1);
insert into transaction_items values
(0202, 9, 1);
insert into transaction_items values
(0202, 1, 1);
insert into transaction_items values
(0203, 20, 1);
insert into transaction_items values
(0204, 3, 1);
insert into transaction_items values
(0205, 4, 1);
insert into transaction_items values
(0206, 1, 1);
insert into transaction_items values
(0207, 22, 1);
insert into transaction_items values
(0208, 22, 1);
insert into transaction_items values
(0209, 8, 1);
insert into transaction_items values
(0210, 6, 1);
insert into transaction_items values
(0210, 20, 1);
insert into transaction_items values
(0211, 2, 1);
insert into transaction_items values
(0212, 2, 1);
insert into transaction_items values
(0213, 20, 1);
insert into transaction_items values
(0214, 5, 1);
insert into transaction_items values
(0214, 7, 1);
insert into transaction_items values
(0215, 9, 1);
insert into transaction_items values
(0216, 2, 1);
insert into transaction_items values
(0217, 22, 1);
insert into transaction_items values
(0218, 23, 1);
insert into transaction_items values
(0218, 8, 1);
insert into transaction_items values
(0219, 22, 1);
insert into transaction_items values
(0220, 21, 1);
insert into transaction_items values
(0221, 2, 1);
insert into transaction_items values
(0222, 5, 1);
insert into transaction_items values
(0223, 11, 1);
insert into transaction_items values
(0224, 7, 1);
insert into transaction_items values
(0225, 20, 1);
insert into transaction_items values
(0226, 23, 1);
insert into transaction_items values
(0226, 8, 1);
insert into transaction_items values
(0227, 9, 1);
insert into transaction_items values
(0228, 1, 1);
insert into transaction_items values
(0229, 20, 1);
insert into transaction_items values
(0230, 1, 2);
insert into transaction_items values
(0231, 20, 1);
insert into transaction_items values
(0232, 7, 1);
insert into transaction_items values
(0233, 2, 1);
insert into transaction_items values
(0234, 5, 1);
insert into transaction_items values
(0235, 8, 2);
insert into transaction_items values
(0236, 8, 1);
insert into transaction_items values
(0237, 22, 1);
insert into transaction_items values
(0237, 9, 1);
insert into transaction_items values
(0238, 23, 1);
insert into transaction_items values
(0239, 20, 1);
insert into transaction_items values
(0240, 11, 1);
insert into transaction_items values
(0241, 24, 1);
insert into transaction_items values
(0242, 8, 1);
insert into transaction_items values
(0243, 8, 1);
insert into transaction_items values
(0243, 20, 1);
insert into transaction_items values
(0244, 1, 2);
insert into transaction_items values
(0245, 20, 1);
insert into transaction_items values
(0246, 7, 1);
insert into transaction_items values
(0247, 2, 1);
insert into transaction_items values
(0248, 5, 1);
insert into transaction_items values
(0249, 8, 2);
insert into transaction_items values
(0250, 8, 1);
insert into transaction_items values
(0250, 22, 1);
insert into transaction_items values
(0251, 9, 1);
insert into transaction_items values
(0252, 23, 1);
insert into transaction_items values
(0253, 20, 1);
insert into transaction_items values
(0254, 11, 1);
insert into transaction_items values
(0255, 24, 1);
insert into transaction_items values
(0256, 8, 1);
insert into transaction_items values
(0257, 8, 1);
insert into transaction_items values
(0257, 20, 1);
insert into transaction_items values
(0258, 4, 1);
insert into transaction_items values
(0259, 11, 2);
insert into transaction_items values
(0260, 21, 1);

insert into transaction_items values
(0261, 1, 2);
insert into transaction_items values
(0262, 20, 1);
insert into transaction_items values
(0262, 7, 1);
insert into transaction_items values
(0263, 2, 1);
insert into transaction_items values
(0263, 5, 1);
insert into transaction_items values
(0264, 8, 2);
insert into transaction_items values
(0265, 8, 1);
insert into transaction_items values
(0265, 22, 1);
insert into transaction_items values
(0266, 9, 1);
insert into transaction_items values
(0266, 23, 1);
insert into transaction_items values
(0267, 11, 1);
insert into transaction_items values
(0267, 24, 1);
insert into transaction_items values
(0268, 8, 1);
insert into transaction_items values
(0268, 20, 1);
insert into transaction_items values
(0269, 4, 1);
insert into transaction_items values
(0270, 11, 2);
insert into transaction_items values
(0271, 21, 1);
insert into transaction_items values
(0272, 3, 1);
insert into transaction_items values
(0273, 7, 1);
insert into transaction_items values
(0273, 20, 1);
insert into transaction_items values
(0274, 22, 1);
insert into transaction_items values
(0274, 8, 1);
insert into transaction_items values
(0275, 23, 1);
insert into transaction_items values
(0276, 4, 1);
insert into transaction_items values
(0277, 5, 1);
insert into transaction_items values
(0277, 22, 1);
insert into transaction_items values
(0278, 6, 1);
insert into transaction_items values
(0279, 20, 1);
insert into transaction_items values
(0279, 23, 1);
insert into transaction_items values
(0280, 3, 1);
insert into transaction_items values
(0281, 8, 1);
insert into transaction_items values
(0282, 5, 1);
insert into transaction_items values
(0283, 2, 1);
insert into transaction_items values
(0283, 24, 1);
insert into transaction_items values
(0284, 1, 1);
insert into transaction_items values
(0285, 2, 1);
insert into transaction_items values
(0286, 6, 1);
insert into transaction_items values
(0286,24, 1);
insert into transaction_items values
(0287, 8, 1);
insert into transaction_items values
(0287, 22, 1);
insert into transaction_items values
(0288, 7, 1);
insert into transaction_items values
(0289, 9, 1);
insert into transaction_items values
(0290, 20, 1);
insert into transaction_items values
(0291, 20, 1);
insert into transaction_items values
(0292, 3, 1);
insert into transaction_items values
(0293, 21, 1);
insert into transaction_items values
(0294, 8, 1);
insert into transaction_items values
(0294, 23, 1);
insert into transaction_items values
(0295, 4, 1);
insert into transaction_items values
(0296, 21, 1);
insert into transaction_items values
(0297, 5, 1);
insert into transaction_items values
(0298, 22, 1);
insert into transaction_items values
(0298, 11, 1);
insert into transaction_items values
(0299, 10, 1);
insert into transaction_items values
(0300, 23, 1);
insert into transaction_items values
(0301, 2, 1);
insert into transaction_items values
(0302, 4, 1);
insert into transaction_items values
(0303, 21, 1);
insert into transaction_items values
(0304, 22, 1);
insert into transaction_items values
(0304, 7, 1);
insert into transaction_items values
(0305, 23, 1);
insert into transaction_items values
(0306, 1, 1);
insert into transaction_items values
(0307, 3, 1);
insert into transaction_items values
(0308, 9, 1);
insert into transaction_items values
(0308, 2, 1);
insert into transaction_items values
(0309, 21, 1);
insert into transaction_items values
(0310, 24, 1);
insert into transaction_items values
(0311, 8, 1);
insert into transaction_items values
(0312, 20, 1);
insert into transaction_items values
(0312, 5, 1);
insert into transaction_items values
(0313, 22, 1);
insert into transaction_items values
(0314, 22, 1);
insert into transaction_items values
(0315, 1, 1);
insert into transaction_items values
(0315, 8, 1);
insert into transaction_items values
(0316, 20, 1);
insert into transaction_items values
(0316, 5, 1);
insert into transaction_items values
(0317, 7, 1);
insert into transaction_items values
(0318, 9, 1);
insert into transaction_items values
(0319, 2, 1);
insert into transaction_items values
(0320, 22, 1);
insert into transaction_items values
(0321, 23, 1);
insert into transaction_items values
(0322, 8, 1);
insert into transaction_items values
(0323, 22, 1);
insert into transaction_items values
(0324, 21, 1);
insert into transaction_items values
(0325, 2, 1);
insert into transaction_items values
(0326, 5, 1);
insert into transaction_items values
(0327, 11, 1);
insert into transaction_items values
(0328, 7, 1);
insert into transaction_items values
(0329, 20, 1);
insert into transaction_items values
(0330, 23, 1);
insert into transaction_items values
(0331, 8, 1);
insert into transaction_items values
(0332, 9, 1);
insert into transaction_items values
(0332, 1, 1);
insert into transaction_items values
(0333, 20, 1);
insert into transaction_items values
(0334, 3, 1);
insert into transaction_items values
(0335, 4, 1);
insert into transaction_items values
(0336, 1, 1);
insert into transaction_items values
(0337, 22, 1);
insert into transaction_items values
(0338, 22, 1);
insert into transaction_items values
(0339, 8, 1);
insert into transaction_items values
(0340, 6, 1);
insert into transaction_items values
(0340, 20, 1);
insert into transaction_items values
(0341, 2, 1);
insert into transaction_items values
(0342, 2, 1);
insert into transaction_items values
(0343, 20, 1);
insert into transaction_items values
(0344, 5, 1);
insert into transaction_items values
(0344, 7, 1);
insert into transaction_items values
(0345, 9, 1);
insert into transaction_items values
(0346, 2, 1);
insert into transaction_items values
(0347, 22, 1);
insert into transaction_items values
(0348, 23, 1);
insert into transaction_items values
(0348, 8, 1);
insert into transaction_items values
(0349, 22, 1);
insert into transaction_items values
(0350, 21, 1);
insert into transaction_items values
(0351, 2, 1);
insert into transaction_items values
(0352, 5, 1);
insert into transaction_items values
(0353, 11, 1);
insert into transaction_items values
(0354, 7, 1);
insert into transaction_items values
(0355, 20, 1);
insert into transaction_items values
(0356, 23, 1);
insert into transaction_items values
(0356, 8, 1);
insert into transaction_items values
(0357, 9, 1);
insert into transaction_items values
(0358, 1, 1);
insert into transaction_items values
(0359, 20, 1);
insert into transaction_items values
(0360, 1, 2);
insert into transaction_items values
(0361, 20, 1);
insert into transaction_items values
(0362, 7, 1);
insert into transaction_items values
(0363, 2, 1);
insert into transaction_items values
(0364, 5, 1);
insert into transaction_items values
(0365, 8, 2);
insert into transaction_items values
(0366, 8, 1);
insert into transaction_items values
(0367, 22, 1);
insert into transaction_items values
(0367, 9, 1);
insert into transaction_items values
(0368, 23, 1);
insert into transaction_items values
(0369, 20, 1);
insert into transaction_items values
(0370, 11, 1);
insert into transaction_items values
(0371, 24, 1);
insert into transaction_items values
(0372, 8, 1);
insert into transaction_items values
(0373, 8, 1);
insert into transaction_items values
(0373, 20, 1);
insert into transaction_items values
(0374, 1, 2);
insert into transaction_items values
(0375, 20, 1);
insert into transaction_items values
(0376, 7, 1);
insert into transaction_items values
(0377, 2, 1);
insert into transaction_items values
(0378, 5, 1);
insert into transaction_items values
(0379, 8, 2);
insert into transaction_items values
(0380, 8, 1);
insert into transaction_items values
(0380, 22, 1);
insert into transaction_items values
(0381, 9, 1);
insert into transaction_items values
(0382, 23, 1);
insert into transaction_items values
(0383, 20, 1);
insert into transaction_items values
(0384, 11, 1);
insert into transaction_items values
(0385, 24, 1);
insert into transaction_items values
(0386, 8, 1);
insert into transaction_items values
(0387, 8, 1);
insert into transaction_items values
(0387, 20, 1);
insert into transaction_items values
(0388, 4, 1);
insert into transaction_items values
(0389, 11, 2);
insert into transaction_items values
(0390, 21, 1);

insert into transaction_items values
(0391, 1, 2);
insert into transaction_items values
(0392, 20, 1);
insert into transaction_items values
(0392, 7, 1);
insert into transaction_items values
(0393, 2, 1);
insert into transaction_items values
(0393, 5, 1);
insert into transaction_items values
(0394, 8, 2);
insert into transaction_items values
(0395, 8, 1);
insert into transaction_items values
(0395, 22, 1);
insert into transaction_items values
(0396, 9, 1);
insert into transaction_items values
(0396, 23, 1);
insert into transaction_items values
(0397, 11, 1);
insert into transaction_items values
(0397, 24, 1);
insert into transaction_items values
(0398, 8, 1);
insert into transaction_items values
(0398, 20, 1);
insert into transaction_items values
(0399, 4, 1);
insert into transaction_items values
(0400, 11, 2);
insert into transaction_items values
(0401, 21, 1);
insert into transaction_items values
(0402, 3, 1);
insert into transaction_items values
(0403, 7, 1);
insert into transaction_items values
(0403, 20, 1);
insert into transaction_items values
(0404, 22, 1);
insert into transaction_items values
(0404, 8, 1);
insert into transaction_items values
(0405, 23, 1);
insert into transaction_items values
(0406, 4, 1);
insert into transaction_items values
(0407, 5, 1);
insert into transaction_items values
(0407, 22, 1);
insert into transaction_items values
(0408, 6, 1);
insert into transaction_items values
(0409, 20, 1);
insert into transaction_items values
(0409, 23, 1);
insert into transaction_items values
(0410, 3, 1);
insert into transaction_items values
(0411, 8, 1);
insert into transaction_items values
(0412, 5, 1);
insert into transaction_items values
(0413, 2, 1);
insert into transaction_items values
(0413, 24, 1);
insert into transaction_items values
(0414, 1, 1);
insert into transaction_items values
(0415, 2, 1);
insert into transaction_items values
(0416, 6, 1);
insert into transaction_items values
(0416,24, 1);
insert into transaction_items values
(0417, 8, 1);
insert into transaction_items values
(0417, 22, 1);
insert into transaction_items values
(0418, 7, 1);
insert into transaction_items values
(0419, 9, 1);
insert into transaction_items values
(0420, 20, 1);
insert into transaction_items values
(0421, 20, 1);
insert into transaction_items values
(0422, 3, 1);
insert into transaction_items values
(0423, 21, 1);
insert into transaction_items values
(0424, 8, 1);
insert into transaction_items values
(0424, 23, 1);
insert into transaction_items values
(0425, 4, 1);
insert into transaction_items values
(0426, 21, 1);
insert into transaction_items values
(0427, 5, 1);
insert into transaction_items values
(0428, 22, 1);
insert into transaction_items values
(0428, 11, 1);
insert into transaction_items values
(0429, 10, 1);
insert into transaction_items values
(0430, 23, 1);
insert into transaction_items values
(0431, 2, 1);
insert into transaction_items values
(0432, 4, 1);
insert into transaction_items values
(0433, 21, 1);
insert into transaction_items values
(0434, 22, 1);
insert into transaction_items values
(0434, 7, 1);
insert into transaction_items values
(0435, 23, 1);
insert into transaction_items values
(0436, 1, 1);
insert into transaction_items values
(0437, 3, 1);
insert into transaction_items values
(0438, 9, 1);
insert into transaction_items values
(0438, 2, 1);
insert into transaction_items values
(0439, 21, 1);
insert into transaction_items values
(0440, 24, 1);
insert into transaction_items values
(0441, 8, 1);
insert into transaction_items values
(0442, 20, 1);
insert into transaction_items values
(0442, 5, 1);
insert into transaction_items values
(0443, 22, 1);
insert into transaction_items values
(0444, 22, 1);
--insert into transaction_items values
-- (0445, 1, 1);
insert into transaction_items values
(0445, 8, 1);
insert into transaction_items values
(0446, 20, 1);
insert into transaction_items values
(0446, 5, 1);
insert into transaction_items values
(0447, 7, 1);
insert into transaction_items values
(0448, 9, 1);
insert into transaction_items values
(0449, 2, 1);
insert into transaction_items values
(0450, 22, 1);
insert into transaction_items values
(0451, 23, 1);
insert into transaction_items values
(0452, 8, 1);
insert into transaction_items values
(0453, 22, 1);
insert into transaction_items values
(0454, 21, 1);
insert into transaction_items values
(0455, 2, 1);
insert into transaction_items values
(0456, 5, 1);
insert into transaction_items values
(0457, 11, 1);
insert into transaction_items values
(0458, 7, 1);
insert into transaction_items values
(0459, 20, 1);
insert into transaction_items values
(0460, 23, 1);
insert into transaction_items values
(0461, 8, 1);
insert into transaction_items values
(0462, 9, 1);
insert into transaction_items values
(0462, 1, 1);
insert into transaction_items values
(0463, 20, 1);
insert into transaction_items values
(0464, 3, 1);
insert into transaction_items values
(0465, 4, 1);
insert into transaction_items values
(0466, 1, 1);
insert into transaction_items values
(0467, 22, 1);
insert into transaction_items values
(0468, 22, 1);
insert into transaction_items values
(0469, 8, 1);
insert into transaction_items values
(0470, 6, 1);
insert into transaction_items values
(0470, 20, 1);
insert into transaction_items values
(0471, 2, 1);
insert into transaction_items values
(0472, 2, 1);
insert into transaction_items values
(0473, 20, 1);
insert into transaction_items values
(0474, 5, 1);
insert into transaction_items values
(0474, 7, 1);
insert into transaction_items values
(0475, 9, 1);
insert into transaction_items values
(0476, 2, 1);
insert into transaction_items values
(0477, 22, 1);
insert into transaction_items values
(0478, 23, 1);
insert into transaction_items values
(0478, 8, 1);
insert into transaction_items values
(0479, 22, 1);
insert into transaction_items values
(0480, 21, 1);
insert into transaction_items values
(0481, 2, 1);
insert into transaction_items values
(0482, 5, 1);
insert into transaction_items values
(0483, 11, 1);
insert into transaction_items values
(0484, 7, 1);
insert into transaction_items values
(0485, 20, 1);
insert into transaction_items values
(0486, 23, 1);
insert into transaction_items values
(0486, 8, 1);
insert into transaction_items values
(0487, 9, 1);
insert into transaction_items values
(0488, 1, 1);
insert into transaction_items values
(0489, 20, 1);
insert into transaction_items values
(0490, 1, 2);
insert into transaction_items values
(0491, 20, 1);
insert into transaction_items values
(0492, 7, 1);
insert into transaction_items values
(0493, 2, 1);
insert into transaction_items values
(0494, 5, 1);
insert into transaction_items values
(0495, 8, 2);
insert into transaction_items values
(0496, 8, 1);
insert into transaction_items values
(0497, 22, 1);
insert into transaction_items values
(0497, 9, 1);
insert into transaction_items values
(0498, 23, 1);
insert into transaction_items values
(0499, 20, 1);
insert into transaction_items values
(0500, 11, 1);
insert into transaction_items values
(0501, 24, 1);
insert into transaction_items values
(0502, 8, 1);
insert into transaction_items values
(0503, 8, 1);
insert into transaction_items values
(0503, 20, 1);
insert into transaction_items values
(0504, 1, 2);
insert into transaction_items values
(0505, 20, 1);
insert into transaction_items values
(0506, 7, 1);
insert into transaction_items values
(0507, 2, 1);
insert into transaction_items values
(0508, 5, 1);
insert into transaction_items values
(0509, 8, 2);
insert into transaction_items values
(0510, 8, 1);
insert into transaction_items values
(0510, 22, 1);
insert into transaction_items values
(0511, 9, 1);
insert into transaction_items values
(0512, 23, 1);
insert into transaction_items values
(0513, 20, 1);
insert into transaction_items values
(0514, 11, 1);
insert into transaction_items values
(0515, 24, 1);
insert into transaction_items values
(0516, 8, 1);
insert into transaction_items values
(0517, 8, 1);
insert into transaction_items values
(0517, 20, 1);
insert into transaction_items values
(0518, 4, 1);
insert into transaction_items values
(0519, 11, 2);
insert into transaction_items values
(0520, 21, 1);

insert into transaction_items values
(0521, 1, 2);
insert into transaction_items values
(0522, 20, 1);
insert into transaction_items values
(0522, 7, 1);
insert into transaction_items values
(0523, 2, 1);
insert into transaction_items values
(0523, 5, 1);
insert into transaction_items values
(0524, 8, 2);
insert into transaction_items values
(0525, 8, 1);
insert into transaction_items values
(0525, 22, 1);
insert into transaction_items values
(0526, 9, 1);
insert into transaction_items values
(0526, 23, 1);
insert into transaction_items values
(0527, 11, 1);
insert into transaction_items values
(0527, 24, 1);
insert into transaction_items values
(0528, 8, 1);
insert into transaction_items values
(0528, 20, 1);
insert into transaction_items values
(0529, 4, 1);
insert into transaction_items values
(0530, 11, 2);
insert into transaction_items values
(0531, 21, 1);
insert into transaction_items values
(0532, 3, 1);
insert into transaction_items values
(0533, 7, 1);
insert into transaction_items values
(0533, 20, 1);
insert into transaction_items values
(0534, 22, 1);
insert into transaction_items values
(0534, 8, 1);
insert into transaction_items values
(0535, 23, 1);
insert into transaction_items values
(0536, 4, 1);
insert into transaction_items values
(0537, 5, 1);
insert into transaction_items values
(0537, 22, 1);
insert into transaction_items values
(0538, 6, 1);
--insert into transaction_items values
-- (0539, 20, 1);
--insert into transaction_items values
--(0539, 23, 1);
insert into transaction_items values
(0540, 3, 1);
insert into transaction_items values
(0541, 8, 1);
insert into transaction_items values
(0542, 5, 1);
insert into transaction_items values
(0543, 2, 1);
insert into transaction_items values
(0543, 24, 1);
insert into transaction_items values
(0544, 1, 1);
insert into transaction_items values
(0545, 2, 1);
insert into transaction_items values
(0546, 6, 1);
insert into transaction_items values
(0546,24, 1);
insert into transaction_items values
(0547, 8, 1);
insert into transaction_items values
(0547, 22, 1);
insert into transaction_items values
(0548, 7, 1);
insert into transaction_items values
(0549, 9, 1);
insert into transaction_items values
(0550, 20, 1);
insert into transaction_items values
(0551, 20, 1);
insert into transaction_items values
(0552, 3, 1);
insert into transaction_items values
(0553, 21, 1);
insert into transaction_items values
(0554, 8, 1);
insert into transaction_items values
(0554, 23, 1);
insert into transaction_items values
(0555, 4, 1);
insert into transaction_items values
(0556, 21, 1);
insert into transaction_items values
(0557, 5, 1);
insert into transaction_items values
(0558, 22, 1);
insert into transaction_items values
(0558, 11, 1);




SET FOREIGN_KEY_CHECKS=1;


create view sale_transaction_date as 
select tid, date_format(ttime, '%m/%d/%Y') as date
from sale_transaction;








