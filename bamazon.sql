--Create a MySQL Database called Bamazon.


--  *****************************************


-- bamazon homework database

CREATE database Bamazon;

USE Bamazon;
--  ***** Table departments  ***********
CREATE TABLE departments (
	department_name  VARCHAR(250) UNIQUE NOT NULL,
    department_over_head_costs DECIMAL (10,2) NULL,
    department_total_sales DECIMAL(12,2) NULL,
    PRIMARY KEY (department_name)
);

INSERT INTO departments (department_name,department_over_head_costs,department_total_sales)
VALUES ('Entertaining',.90,500);
INSERT INTO departments (department_name,department_over_head_costs,department_total_sales)
VALUES ('Kitchen',3.60,1300);
INSERT INTO departments (department_name,department_over_head_costs,department_total_sales)
VALUES ('Seasonal',7.90,5500);

-- ********** Table customers  ***********

CREATE TABLE customers (
	customer_id INT UNIQUE AUTO_INCREMENT NOT NULL,
    customer_no VARCHAR(15) UNIQUE NOT NULL,
    customer_last VARCHAR(30) NOT NULL,
    customer_first VARCHAR(30) NOT NULL,
    customer_email VARCHAR(250) NOT NULL,
    customer_phone VARCHAR(25),
    PRIMARY KEY (customer_id)
    );
    
INSERT INTO customers (customer_no,customer_last,customer_first,customer_email,customer_phone)
VALUES ('0345678','Smith','John','johnsmith@hotmail.com','18472223333');

-- ********* Table shipping  **************
CREATE TABLE shipping (
	shipping_method_id INT UNIQUE AUTO_INCREMENT NOT NULL,
    shipping_method VARCHAR(250) NOT NULL
    );

INSERT INTO shipping (shipping_method)
VALUES ('USPS');
INSERT INTO shipping (shipping_method)
VALUES ('UPS');
INSERT INTO shipping (shipping_method)
VALUES ('FedX');

-- ********* Table products **************

CREATE TABLE products (
  product_id INT UNIQUE AUTO_INCREMENT NOT NULL,
  product_no VARCHAR(60) NOT NULL,
  product_name VARCHAR(250) NOT NULL,
  product_department_name VARCHAR(256) NOT NULL,
  product_price DECIMAL(10,2) NULL,
  product_stock_quantity INT NULL,

  PRIMARY KEY (product_id)
);

INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('Y123-45678','Ashland 12oz wine glass','Entertaining',5.95,100);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('Y123-45688','Ashland 14oz wine glass','Entertaining',6.95,120);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('Y124-66678','Newburg 9oz wine glass','Entertaining',3.95,200);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('B723-34567','Cabria Large red baker','Kitchens',19.95,12);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('B723-78332','Cabria Blue mixing bowl','Kitchens',15.95,24);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('B723-44478','Zuz Small t spatula','Kitchens',6.95,20);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('L456-41678','Zuz Small Lidded Basket','Seasonal',15.95,30);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('L456-45688','Zuz Large Lidded Basket','Seasonal',35.95,10);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('L789-45612','Willow Mint candle','Seasonal',5.95,100);
INSERT INTO products (product_no,product_name,product_department_name,product_price,product_stock_quantity)
VALUES ('L789-45655','Willow Lemon candle','Seasonal',5.95,100);


--  *********** Table orders *****************

CREATE TABLE orders (
	order_id  INT UNIQUE AUTO_INCREMENT NOT NULL,
    order_no VARCHAR(50) NOT NULL,
    order_date DATE,
    order_customer_id INT NOT NULL,
    order_shipping_method_id INT NOT NULL,
    order_status VARCHAR(2) NOT NULL,
    order_shipping_status VARCHAR(2) NOT NULL,
    FOREIGN KEY (order_customer_id) REFERENCES customers(customer_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (order_id)
    );
  
INSERT INTO orders (order_no,order_date,order_customer_id,order_shipping_method_id,
  order_status,order_shipping_status)
  VALUES ('345-678','2016-11-11',1,1,'P','T');
  

--  *********** Table order details *****************
CREATE TABLE order_details (
	odetail_id INT UNIQUE AUTO_INCREMENT NOT NULL,
    odetail_order_id INT NOT NULL,
    odetail_line_item_id INT NOT NULL,
    odetail_product_id INT NOT NULL,
    odetail_product_qty INT NOT NULL,
    FOREIGN KEY (odetail_order_id) REFERENCES orders(order_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (odetail_id)
    );
INSERT INTO order_details (odetail_order_id,odetail_line_item_id,
     odetail_product_id,odetail_product_qty)
     VALUES (1,1,1,3);

-- ****** Make indexes for special lookups like on name  ********

CREATE INDEX index_product_name
ON products (product_name);

CREATE INDEX index_customer_last
ON customers (customer_last);

CREATE INDEX index_customer_no
ON customers (customer_no);
  


