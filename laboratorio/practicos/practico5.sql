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
SET premium_costumer = 'T'
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id, sum(amount) AS payed
	FROM payment
	GROUP BY customer_id
	ORDER BY sum(amount) DESC
	LIMIT 10
);