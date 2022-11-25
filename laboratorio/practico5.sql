-- Cree una tabla de `directors` con las columnas: Nombre, Apellido,
-- Número de Películas.

CREATE TABLE directors (
  director_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45),
  last_name VARCHAR(45),
  num_of_movies INT,
  PRIMARY KEY  (director_id)
);


-- El top 5 de actrices y actores de la tabla `actors` que tienen
-- la mayor experiencia (i.e. el mayor número de películas filmadas)
-- son también directores de las películas en las que participaron.
-- Basados en esta información, inserten, utilizando una subquery
-- los valores correspondientes en la tabla `directors`.

INSERT INTO sakila.directors(first_name, last_name, num_of_movies)
SELECT actor.first_name, actor.last_name, count(actor_id)
FROM film_actor INNER JOIN actor USING(actor_id)
GROUP BY actor_id
ORDER BY count(actor_id) DESC
LIMIT 5;

-- Agregue una columna `premium_customer` que tendrá un valor 'T' o
-- 'F' de acuerdo a si el cliente es "premium" o no. Por defecto
-- ningún cliente será premium.
ALTER TABLE customer
ADD premium_customer CHAR(1) NOT NULL DEFAULT 'F';

-- Modifique la tabla customer. Marque con 'T' en la columna 
-- `premium_customer` de los 10 clientes con mayor dinero
-- gastado en la plataforma.
UPDATE customer
SET premium_customer = 'T'
WHERE customer_id IN (
  SELECT customer_id FROM (
    SELECT customer_id, sum(amount) AS payed
    FROM payment
    GROUP BY customer_id
    ORDER BY sum(amount) DESC
    LIMIT 10
  ) bests
);

-- Listar, ordenados por cantidad de películas (de mayor a menor), los
-- distintos ratings de las películas existentes (Hint: rating se refiere
-- en este caso a la clasificación según edad: G, PG, R, etc).

SELECT rating, count(title) AS "number of movies"
FROM film
GROUP BY rating
ORDER BY count(title) DESC;

-- ¿Cuáles fueron la primera y última fecha donde hubo pagos?
SELECT min(payment_date) AS "Fist payment date",
       max(payment_date) AS "Last payment date"
FROM payment;

-- Calcule, por cada mes, el promedio de pagos (Hint: vea la manera de
-- extraer el nombre del mes de una fecha).

SELECT MONTH(payment_date) AS "Month",
       avg(amount) AS "Payment average"
FROM payment
GROUP BY MONTH(payment_date);


-- Listar los 10 distritos que tuvieron mayor cantidad de alquileres
-- (con la cantidad total de alquileres).
WITH addrs_of_customers AS (
  SELECT customer_id, district
  FROM address INNER JOIN customer
  USING(address_id)
)
SELECT district, count(rental_id) AS "Total rents"
FROM rental INNER JOIN addrs_of_customers
USING(customer_id)
GROUP BY district 
LIMIT 10;

-- Modifique la table `inventory_id` agregando una columna `stock` que sea
-- un número entero y representa la cantidad de copias de una misma película
-- que tiene determinada tienda. El número por defecto debería ser 5 copias.
ALTER TABLE inventory_id
ADD stock INT DEFAULT '5';


-- Cree un trigger `update_stock` que, cada vez que se agregue un nuevo
-- registro a la tabla rental, haga un update en la tabla `inventory`
-- restando una copia al stock de la película rentada (Hint: revisar que el
-- rental no tiene información directa sobre la tienda, sino sobre el cliente,
-- que está asociado a una tienda en particular).
CREATE TRIGGER update_stock
AFTER INSERT
ON rental FOR EACH ROW
BEGIN
  DECLARE store_id INT;
  SET store_id = (SELECT customer.store_id
                  FROM customer
                  WHERE customer.customer_id = NEW.customer_id
                 );
  UPDATE inventory
  SET inventory.stock = (inventory.stock - 1)
  WHERE inventory.store_id = store_id AND inventory_id = NEW.inventory_id;
END;

-- Cree una tabla `fines` que tenga dos campos: `rental_id` y `amount`. 
-- El primero es una clave foránea a la tabla rental y el segundo es un
-- valor numérico con dos decimales.
CREATE TABLE fines (
  rental_id INT,
  amount SMALLINT,
  CONSTRAINT fk_fines_retal FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);

-- Cree un procedimiento `check_date_and_fine` que revise la tabla `rental`
-- y cree un registro en la tabla `fines` por cada `rental` cuya devolución
-- (return_date) haya tardado más de 3 días (comparación con rental_date).
-- El valor de la multa será el número de días de retraso multiplicado por 1.5.

INSERT INTO fines
SELECT rental_id, DATEDIFF(return_date, rental_date)*1.5 as "amount"
FROM rental
WHERE DATEDIFF(return_date, rental_date) > 3;

-- Crear un rol `employee` que tenga acceso de inserción, 
-- eliminación y actualización a la tabla `rental`.

CREATE ROLE employee;
GRANT INSERT, UPDATE, DELETE ON sakila.rental TO employee;

-- Revocar el acceso de eliminación a `employee` y crear un rol 
-- `administrator` que tenga todos los privilegios sobre la BD `sakila`.
REVOQUE DELETE ON sakila.rental FROM employee;
CREATE ROLE administrator;
GRANT ALL PRIVILEGES ON sakila.* TO administrator;

-- Crear dos roles de empleado. A uno asignarle los 
-- permisos de `employee` y al otro de `administrator`.
-- TODO: preguntar

