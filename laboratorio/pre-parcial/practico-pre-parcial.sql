-- Devuelva la oficina con mayor número de empleados.
SELECT
    c.officeCode,
    c.city,
    c.phone,
    c.addressLine1,
    c.addressLine2,
    c.state,
    c.country,
    c.postalCode,
    c.territory,
    max(employees) AS "Number of employees"
FROM (
    SELECT offices.*, count(employeeNumber) as "employees"
    FROM offices
    INNER JOIN employees 
    ON offices.officeCode = employees.officeCode
    GROUP BY offices.officeCode
) c


-- ¿Cuál es el promedio de órdenes hechas por oficina?, 
WITH orders_per_employee AS (
    SELECT
        employees.officeCode,
        count(employees.employeeNumber) as orders
    FROM employees
    INNER JOIN
    (
        SELECT
            orders.orderNumber,
            orders.customerNumber,
            customers.salesRepEmployeeNumber
        FROM orders
        INNER JOIN customers
        ON orders.customerNumber = customers.customerNumber
    ) orders_customers
    ON orders_customers.salesRepEmployeeNumber = employees.employeeNumber
    GROUP BY employeeNumber
)
SELECT
    officeCode AS "Ofice",
    avg(orders) AS "Average orders",
FROM orders_per_employee
GROUP BY officeCode

-- ¿Qué oficina vendió la mayor cantidad de productos?
WITH customers_orders AS (
    SELECT
        orders_details.*,
        customers.salesRepEmployeeNumber
    FROM customers
    INNER JOIN (
        SELECT
        orderdetails.quantityOrdered,
        orders.orderNumber,
        orders.customerNumber
        FROM orderdetails
        INNER JOIN orders 
        USING(orderNumber)
    ) orders_details
    USING(customerNumber)
)

SELECT
    offices.*,
    sales_per_office.sales AS "Number of products sold"
FROM (
    SELECT
        employees.officeCode,
        sum(customers_orders.quantityOrdered) AS "sales"
    FROM employees
    INNER JOIN customers_orders
    ON customers_orders.salesRepEmployeeNumber = employees.employeeNumber
    GROUP BY officeCode
) sales_per_office
INNER JOIN offices
USING(officeCode)
ORDER BY sales_per_office.sales DESC
LIMIT 1;


-- Devolver el valor promedio, máximo y mínimo de pagos que se hacen por mes.

SELECT
    MONTH(paymentDate) AS "Month",
    avg(amount) AS "Average payment",
    max(amount) AS "Max payment",
    min(amount) AS "Min payment"
FROM payments
GROUP BY MONTH(paymentDate)
  
-- Crear un procedimiento "Update Credit" en donde se modifique el
-- límite de crédito de un cliente con un valor pasado por parámetro.
CREATE PROCEDURE update_credit( IN customer_id int(11),
                                IN newcreditLimit decimal(10,2) )
    UPDATE customer
    SET creditLimit = newcreditLimit
    WHERE customer.customerNumber = @customer_id

-- Cree una vista "Premium Customers" que devuelva el top 10 de clientes
-- que más dinero han gastado en la plataforma. La vista deberá devolver 
-- el nombre del cliente, la ciudad y el total gastado por ese cliente
-- en la plataforma.

CREATE VIEW premium_customer AS (
    SELECT
        customers.customerName, 
        customers.city,
        sum(amount) AS "TotalSpent"
    FROM payments
    INNER JOIN customers
    USING(customerNumber)
    GROUP BY customers.customerNumber
    ORDER BY TotalSpent DESC
    LIMIT 10
);

-- Cree una función "employee of the month" que tome un mes y un año
-- y devuelve el empleado (nombre y apellido) cuyos clientes hayan efectuado
-- la mayor cantidad de órdenes en ese mes.

CREATE FUNCTION employee_of_the_month (month int, year int)
    RETURNS TABLE AS
    RETURN SELECT @p1 AS "Name"
                  @p2 AS "LastName"


-- Crear una nueva tabla "Product Refillment". Deberá tener una
-- relación varios a uno con "products" y los campos: `refillmentID`,
-- `productCode`, `orderDate`, `quantity`.

CREATE TABLE ProductRefillment (
    refillmentID int(11) NOT NULL , -- auto increment
    productCode varchar(15) NOT NULL,
    orderDate date,
    quantity int,
    PRIMARY KEY (refillmentID),
    CONSTRAINT product_refillment_1
        FOREIGN KEY (productCode)
        REFERENCES products (productCode)
)

-- Definir un trigger "Restock Product" que esté pendiente de los cambios 
-- efectuados en `orderdetails` y cada vez que se agregue una nueva orden 
-- revise la cantidad de productos pedidos (`quantityOrdered`) y compare
-- con la cantidad en stock (`quantityInStock`) y si es menor a 10 genere 
-- un pedido en la tabla "Product Refillment" por 10 nuevos productos.

CREATE TRIGGER restock_product 
AFTER INSERT
ON orderdetails FOR EACH ROW
BEGIN   
    DECLARE stock INT;
    UPDATE products
    SET products.quantityInStock = 
        (products.quantityInStock - NEW.quantityOrdered)
    WHERE products.productCode = NEW.productCode;

    SELECT products.quantityInStock
    INTO stock
    FROM products
    WHERE products.productCode = NEW.productCode;

    IF stock < 10 THEN
        INSERT INTO ProductRefillment (productCode, quantity)
        VALUES (NEW.productCode, 10);
    END IF;
END;

-- Crear un rol "Empleado" en la BD que establezca accesos de lectura 
-- a todas las tablas y accesos de creación de vistas.
DROP ROLE IF EXISTS Empledado;
CREATE ROLE Empleado;
GRANT SELECT ON * TO Empleado;
GRANT CREATE VIEW On classicmodels.* TO Empleado;

