use library;

/*
	a) Populate entities with data
*/
INSERT INTO customer (Expiry_date, Member_date, Customer_fn, Customer_ln)
	VALUES
		('2020-4-23', '2019-4-23', "Andy", "Lai");
 
INSERT INTO customer (Expiry_date, Member_date, Customer_fn, Customer_ln)
	VALUES
		('2020-4-23', '2019-4-23', "Bhavesh", "Chowdhury");
        
INSERT INTO customer (Expiry_date, Member_date, Customer_fn, Customer_ln)
	VALUES
		('2020-4-23', '2019-4-23', "David", "Dropping");
        
		INSERT INTO `return` (Customer_Customer_id) VALUES (1);
INSERT INTO `return` (Customer_Customer_id) VALUES (2);
INSERT INTO `return` (Customer_Customer_id) VALUES (3);

INSERT INTO item (Title, Status, Author_fn, Author_ln, Return_Customer_id)
	VALUES
		("To Kill a Mockingbird", "Rented", "Harper", "Lee", 1);
        
INSERT INTO item (Title, Status, Author_fn, Author_ln, Return_Customer_id)
	VALUES
		("Hamlet", "Rented", "William", "Shakespeare", 2);
        
INSERT INTO item (Title, Status, Author_fn, Author_ln, Return_Customer_id)
	VALUES
		("Fahrenheit 451", "Rented", "Ray", "Bradbury", 3);

INSERT INTO item (Title, Status, Author_fn, Author_ln, Return_Customer_id)
	VALUES
		("The Veldt", "Rented", "Ray", "Bradbury", 3);
        
INSERT INTO borrow (Customer_id, Item_id)
	VALUES
		(1, 1);
        
INSERT INTO borrow (Customer_id, Item_id)
	VALUES
		(2, 2);
        
INSERT INTO borrow (Customer_id, Item_id)
	VALUES
		(3, 3);
        
INSERT INTO purchase (Customer_Customer_id, Item_Item_id)
	VALUES
		(1, 1);

INSERT INTO purchase (Customer_Customer_id, Item_Item_id)
	VALUES
		(2, 2);

INSERT INTO purchase (Customer_Customer_id, Item_Item_id)
	VALUES
		(3, 3);
        


INSERT INTO faculty (faculty_fn, faculty_ln, DOB) 
	VALUES ("Yiyuan", "Huang", '1997-4-23');

INSERT INTO faculty (faculty_fn, faculty_ln, DOB) 
	VALUES ("Ali", "Nasralla", '1997-4-24');

INSERT INTO faculty (faculty_fn, faculty_ln, DOB) 
	VALUES ("Abraham", "Lincoln", '1997-4-20');
    
INSERT INTO supplier (Supplier_id) VALUES (1);
INSERT INTO supplier (Supplier_id) VALUES (2);
INSERT INTO supplier (Supplier_id) VALUES (3);

INSERT INTO request (Faculty_Faculty_id, Supplier_Supplier_id)
	VALUES (1, 1);
    
INSERT INTO request (Faculty_Faculty_id, Supplier_Supplier_id)
	VALUES (2, 2);

INSERT INTO request (Faculty_Faculty_id, Supplier_Supplier_id)
	VALUES (3, 3);
    
INSERT INTO stock (Request_rid, Request_Faculty_Faculty_id, Supplier_Supplier_id)
	VALUES (1, 1, 1);
    
INSERT INTO stock (Request_rid, Request_Faculty_Faculty_id, Supplier_Supplier_id)
	VALUES (2, 2, 2);
    
INSERT INTO stock (Request_rid, Request_Faculty_Faculty_id, Supplier_Supplier_id)
	VALUES (3, 3, 3);
    
INSERT INTO `system` (Stock_Stock_id, Purchase_pid, Borrow_bid)
	VALUES (1, 1, 1);
    
INSERT INTO `system` (Stock_Stock_id, Purchase_pid, Borrow_bid)
	VALUES (2, 2, 2);

INSERT INTO `system` (Stock_Stock_id, Purchase_pid, Borrow_bid)
	VALUES (3, 3, 3);

/*
	b) Deletion tests of one tuple in each table
*/

DELETE FROM customer WHERE Customer_id=1 AND customer_fn="Andy" AND customer_ln="Lai";

DELETE FROM item WHERE Item_id=1;

DELETE FROM stock WHERE Stock_id=1;

DELETE FROM supplier WHERE Supplier_id=1;

DELETE FROM FACULTY WHERE Faculty_id=1;

DELETE FROM `system` WHERE System_id=1;

/*
	c) Selection tests for relationships
*/

/* One to Many */
/* 1 */
SELECT i.*,p.pid
FROM Item i
INNER JOIN purchase p
ON i.Item_id=p.item_item_id
WHERE i.`Status`="rented";

/* 2 */
SELECT * FROM Customer c
INNER JOIN borrow b
ON c.Customer_id=b.bid

/* 3 */
SELECT * FROM Item i
INNER JOIN borrow b
ON i.item_id=b.Item_id

/* 4 */
SELECT * FROM Customer c
INNER JOIN purchase p
ON c.Customer_id=p.customer_customer_id

/* 5 */
SELECT * FROM Customer c
INNER JOIN `return` r
ON c.Customer_id=r.customer_customer_id

/* Many to One */
/* 1 */
SSELECT i.*,p.pid
FROM purchase p
INNER JOIN Item i
ON i.Item_id=p.item_item_id
WHERE i.`Status`="rented";

/* 2 */
SELECT * FROM borrow b
INNER JOIN Customer c
ON c.Customer_id=b.bid

/* 3 */
SELECT * FROM borrow b
INNER JOIN Item i
ON i.item_id=b.Item_id

/* 4 */
SELECT * FROM purchase p
INNER JOIN Customer c
ON c.Customer_id=p.customer_customer_id

/* 5 */
SELECT * FROM `return` r
INNER JOIN Customer c
ON c.Customer_id=r.customer_customer_id


/* One to One */

SELECT Customer.Member_date AS CMD FROM Customer customer, `Return` `return` WHERE Customer.Customer_id < 100 AND Customer.Customer_id = `Return`.Customer_Customer_id;

SELECT Customer.Customer_fn AS CFN, Customer.Customer_ln AS CLN FROM `Return` `return`, Customer customer WHERE	`Return`.Customer_Customer_id = 2;

SELECT Request.rid AS rid FROM Reuest request, Supplier supplier WHERE Supplier.Supplier_id = Request.Supplier_Supplier_id AND Request.rid < 10

/* Many to Many */
/* 1 */
select c.Customer_fn,c.Customer_ln,c.Member_date,c.Expiry_date,i.title from Customer c
inner join borrow b
on c.Customer_id=b.Customer_id
inner join item i
on b.item_id=i.item_id
where Expiry_date>now()

/* 2 */
SELECT i.title,i.`status`,c.Customer_fn,c.Customer_ln,c.Member_date,c.Expiry_date from Customer c
INNER JOIN purchase p
ON c.Customer_id=p.Customer_Customer_id
INNER JOIN item i
ON p.item_item_id=i.item_id
WHERE i.`status`='Rented'

/* 3 */
SELECT f.* FROM faculty f 
INNER JOIN request r
ON f.Faculty_id=r.rid
INNER JOIN Supplier s
ON s.Supplier_id=r.Supplier_Supplier_id

/* 4 */
select c.Customer_fn,c.Customer_ln,c.Member_date,c.Expiry_date,i.title from Customer c
inner join borrow b
on c.Customer_id=b.Customer_id
inner join item i
on b.item_id=i.item_id
where i.title='Hamlet'

/* 5 */
SELECT i.title,i.`status`,c.Customer_fn,c.Customer_ln,c.Member_date,c.Expiry_date from Customer c
INNER JOIN purchase p
ON c.Customer_id=p.Customer_Customer_id
INNER JOIN item i
ON p.item_item_id=i.item_id
WHERE c.Customer_fn='Andy'





