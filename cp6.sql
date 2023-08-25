create table customer(
   customer_id INT PRIMARY KEY,
   customer_name VARCHAR(255),
   customer_tel INT
   );


   create table product(
      product_id INT PRIMARY KEY,
	  product_name VARCHAR(255),
	  category VARCHAR (255),
	  price INT
);

create table orders(
   orderdate DATE,
   quantity INT,
   total_amount INT,
   customer_id INT foreign key references customer (customer_id),
   product_id INT foreign key references product (product_id)
);


INSERT INTO customer VALUES (1,'Diouf', 12),
                            (2,'BA', 13),
							(3,'Diallo', 14),
							(4,'Sene',10),
							(5,'faye',11);


INSERT INTO product VALUES (1,'a','widget',23),
                           (2,'b','gadget',27),
						   (3,'c','doohickey',30),
						   (4,'d','widget',12),
						   (5,'e','widget',12),
						   (6,'f','gadget',23),
						   (7,'g','doohickey',11),
						   (8,'h','doohickey',11),
						   (9,'i','gadget',73),
						   (10,'j','gadget',45);


SELECT * 
FROM customer
SELECT * 
FROM product
SELECT * 
FROM orders

1)�crivez une requ�te SQL pour r�cup�rer les noms des clients qui ont pass� une commande d'au moins un widget et d'au moins un gadget, ainsi que le co�t total des widgets et gadgets command�s par chaque client. Le co�t de chaque article doit �tre calcul� en multipliant la quantit� par le prix du produit.

SELECT customer_name,category,SUM(quantity) AS quantity,SUM(price*quantity) AS amount
FROM orders
JOIN customer ON customer.customer_id=orders.customer_id
JOIN product ON product.product_id=orders.product_id
WHERE category='widget'AND quantity>=1 OR category='gadget' AND quantity>=1
GROUP BY customer_name,category
ORDER BY customer_name


2)�crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande pour au moins un widget, ainsi que le co�t total des widgets command�s par chaque client.

SELECT customer_name,category,SUM(quantity) AS quantity,SUM(price*quantity) AS amount
FROM orders
JOIN customer ON customer.customer_id=orders.customer_id
JOIN product ON product.product_id=orders.product_id
WHERE category='widget' AND quantity>=1
GROUP BY customer_name,category
ORDER BY quantity DESC

3)�crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande pour au moins un gadget, ainsi que le co�t total des gadgets command�s par chaque client.


SELECT customer_name,category,SUM(quantity) AS quantity,SUM(price*quantity) AS amount
FROM orders
JOIN customer ON customer.customer_id=orders.customer_id
JOIN product ON product.product_id=orders.product_id
WHERE category='gadget' AND quantity>=1
GROUP BY customer_name,category
ORDER BY quantity DESC

4)�crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� une commande au moins un doohickey, ainsi que le co�t total des doohickeys command�s par chaque client.

SELECT customer_name,category,quantity,SUM(price*quantity) AS amount
FROM orders
JOIN customer ON customer.customer_id=orders.customer_id
JOIN product ON product.product_id=orders.product_id
WHERE category='doohickey' AND quantity>=1
GROUP BY customer_name,category,quantity
ORDER BY quantity DESC


5)�crivez une requ�te pour r�cup�rer le nombre total de widgets et de gadgets command�s par chaque client, ainsi que le co�t total des commandes.

SELECT customer_id,category,SUM(quantity) AS quantity,SUM(price*quantity) AS total_amount
FROM orders
JOIN product ON product.product_id=orders.product_id
WHERE  category IN ('widget','gadget') AND quantity IS NOT NULL
GROUP BY customer_id,category,quantity,total_amount



6)�crivez une requ�te pour r�cup�rer les noms des produits qui ont �t� command�s par au moins un client, ainsi que la quantit� totale de chaque produit command�.

SELECT product_name,SUM(quantity) AS total_quantity
from product
JOIN orders ON orders.product_id=product.product_id
WHERE quantity>0 and product_name IS NOT NULL
GROUP BY product_name

7)�crivez une requ�te pour r�cup�rer les noms des clients qui ont pass� le plus de commandes, ainsi que le nombre total de commandes pass�es par chaque client.


SELECT  customer_id,COUNT(customer_id) AS numberoforders
FROM orders
GROUP BY customer_id


8)�crivez une requ�te pour r�cup�rer les noms des produits les plus command�s, ainsi que la quantit� totale de chaque produit command�.


SELECT product_name,SUM(quantity) AS quantity_total
FROM orders
JOIN product ON product.product_id=orders.product_id
GROUP BY product_name
ORDER BY quantity_total DESC
