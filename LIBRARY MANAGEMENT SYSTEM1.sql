-- library management system project 2 
-- creating table
 create table branch 
(
branch_id	varchar(20) primary key,
manager_id	varchar(20),
branch_address	varchar(20),
contact_no varchar(20)
); 

create table employees
(
emp_id varchar(20) PRIMARY KEY,	
emp_name	varchar(20),
position	varchar(20),
salary	int,
branch_id varchar(20)
); 

create table books
(
isbn varchar(20) primary key,	
book_title	varchar(60),
category	varchar(20),
rental_price	float,
status	varchar(20),
author	varchar(30),
publisher varchar(20)
); 

create table members
(
member_id varchar(20) primary key,	
member_name	varchar(40),
member_address	varchar(80),
reg_date date
); 

create table issued_status
(
issued_id	varchar(20) primary key,
issued_member_id	varchar(20),
issued_book_name varchar(70),
issued_date date,
issued_book_isbn varchar(70),
issued_emp_id varchar(30)
); 

create table return_status
(
return_id	varchar(20) primary key,
issued_id	varchar(20),
return_book_name	varchar(50),
return_date	date,
return_book_isbn varchar(30)
); 
-- foreign key 
 alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

 alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

 alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id )
references employees(emp_id);

 alter table employees
add constraint fk_branch
foreign key (branch_id )
references branch(branch_id); 

alter table return_status
add constraint fk_issued_status
foreign key (issued_id )
references issued_status(issued_id);

-- show tables 

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status; 

-- project tasks


-- Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

 
 insert into books(isbn, book_title, category, rental_price, status, author, publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B'); 
select * from books 

-- Update an Existing Member's Address

 update members
set member_address = '125 oak st'
where member_id = 'C103' ; 
select * from members 

-- Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

 delete from issued_status
where issued_id = 'IS121' ; 

--  Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

 SELECT * FROM issued_status
WHERE issued_emp_id = 'E101' 

-- List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

 SELECT
    issued_emp_id,
    COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1 

-- Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

  CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status as ist
JOIN books as b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title; 


-- Retrieve All Books in a Specific Category:


 select * from books 
where category = 'Classic'; 


-- Find Total Rental Income by Category:
 
 SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1 


-- List Employees with Their Branch Manager's Name and their branch details:


  SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id 


-- Create a Table of Books with Rental Price Above a Certain Threshold:


CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;



