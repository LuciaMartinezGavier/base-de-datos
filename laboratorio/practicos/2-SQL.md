# SQL
## Data Definition Language (DDL)

### Create Table
```SQL
CREATE TABLE tablaName (
	col1 type1,
	...,
	colN type N,
	integrity-constraint1,
	...
	integrity-constraintM
);
```

#### Tipos de datos estándar:
-   `char(n)`:  String de tamaño fijo n.
-   `varchar(n)`: String de tamaño variable, con largo maximo n.
-   `int`:  nros. entero (machine-dependent).
-   `numeric(p,d)`:  Nro de punto fijo, con precisión de p digitos y d decimales.
-   `double precision`: Nro. de punto flotante de doble precisión.
-   `json`: Objetos JSON 
-   `date`: fechas sin componente de tiempo.
- `datetime`: fechas con componente de tiempo.

#### Restricciones de Integridad
`PRIMARY KEY(col1, ...,coln)`
-   Define a las columnas coli como claves primarias (PK) de la tabla.
-   Las PKs tienen que ser únicas y no nulas.
-   Las PKs no deberían cambiar nunca

`NOT NULL`
-   Indica que una columna no puede tener valores nulos.

`UNIQUE`
-   Indica que una columna no puede tener valores     
-   repetidos.

-   `FOREING KEY (col1, ...,coln) REFERENCES T [ON DELETE option] [ON UPDATE option]`:
-   Indica que los valores de las columnas col1,...,coln  deben corresponderse con los valores de las claves primarias de la tabla T.
-   Si la restricción es violada, ON DELETE | ON UPDATE establecen como actuar.
-   option: `CASCADE | SET NULL | SET DEFAULT`
- Es una versión más específica de *integridad referencial*.

`CHECK (condition)`:
-   Indica que el predicado condition debe ser verdadero para toda fila en la tabla.
-   Según el estándar, condition puede ser una subquery.
- Ignorado por MySQL

### Actualización de tablas
```SQL
DROP TABLE table_name; -- Elimina una tabla

ALTER TABLE table_name
ASS COLUMN col1 type1;

ALTER TABLE table_name
DROP COLUMN col1;

INSERT INTO table_name (col1, ..., colN)
VALUES (val1, ..., valN)

DELETE FROM table_name WHERE conditioin;

UPDATE table_name SET col1 = val1, ...,
WHERE condition;
```

-   Cuando se agrega una columna, todas las filas existentes son asignadas NULL en la nueva columna.    
-   En un INSERT se pueden insertar múltiples filas.

## Data Manipulation Language (DML)
### SELECT
```SQL
SELECT select_expr
FROM table_expr
[WHERE where_condition]
[ORDER BY order_expr]
```
-   select_expr es un listado de una o más columnas.    
-   table_expr es un listado de una o más tablas.
-   where_condition es un predicado.    
-   order_expr es una lista de expresiones del tipo {col | alias | pos} [ASC|DESC]
- El resultado de una consulta es una tabla.

-   Por defecto SQL permite duplicados en los resultados de una query. Para eliminar duplicados, usar **DISTINCT**
```sql
SELECT DISTINCT name FROM instructor;
```
-   Si queremos seleccionar todas las columnas, usamos el `*`. 
```sql
SELECT * FROM instructor;
```
-   Se puede usar un literal como columna. 
```sql
SELECT ‘UNC’, name FROM instructor; -- Se repite el literal en cada fila.
```

-   Las columnas se pueden renombrar.
```sql
SELECT name AS fullname 
FROM instructor;
```

-   Se pueden crear columnas con expresiones aritméticas `(+,-,*,/).`
```sql
SELECT name AS fullname, 
salary/40 AS usd_salary 
FROM instructor;
```
-   SQL es case-insensitive.

### FROM
**FROM** permite especificar las tablas involucradas en la query.
**FROM T1, T2, … , Tn** realiza el producto cartesiano T1 x T2 x … x Tn.
```sql
SELECT  ∗ FROM instructor, teaches
```
-   Cuidado cuando la cardinalidad de Ti no es trivial.

-   También se pueden renombrar las tablas. 
```sql
SELECT  t.ID, i.ID 
FROM instructor AS i, teaches AS t
```
### WHERE
**WHERE** permite especificar  condiciones que el resultado debe satisfacer.
```sql
SELECT  ∗ 
FROM instructor
WHERE dep_name = ‘Finance’;
```

-   Se pueden combinar predicados usando AND, OR, NOT. 
```sql
SELECT  ∗ 
FROM instructor
WHERE dep_name = ‘Finance’ 
AND salary <= 90000;
```
-   SQL provee el operador **LIKE** para matching sobre strings.
	-   %  matchea cualquier substring.
	-   _ matchea cualquier caracter.

```
SELECT  * 
FROM instructor
WHERE dep_name LIKE ‘%inan%’;
```

También provee el operador **BETWEEN.**

```sql
SELECT  ∗ 
FROM instructor
WHERE dep_name = ‘Finance’ 
AND salary BETWEEN 9000 AND 10000;
```
### ORDER BY
-   **ORDER BY** permite ordenar los resultados.
```sql
SELECT  ∗ 
FROM instructor
WHERE dep_name = ‘Finance’
ORDER BY salary DESC;
```

-   Se puede ordenar por más de una columna.
```sql
SELECT  ∗ 
FROM instructor
WHERE dep_name = ‘Finance’
ORDER BY salary DESC, name ASC;
```
+ Por defecto el orden es ascendente.
+ Se puede usar el número de columna para ordenar

### NULL
-   En una operación aritmética: 
```sql
NULL (+ | - | * | /) X = NULL
```

-   En operaciones booleanas:

```sql
NULL AND TRUE = NULL
NULL AND FALSE = FALSE
NULL AND NULL = NULL
NULL OR TRUE = TRUE
NULL OR FALSE = NULL
NULL OR NULL = NULL
NOT NULL = NULL
```
-   Si el predicado de un WHERE evalúa a FALSE o NULL para una tupla, la misma no forma parte del resultado.    
-   Para testear si un valor es NULL:
    
```
WHERE salary IS null;
WHERE salary IS NOT null;
```
+ Todas las funciones de agregación, excepto **COUNT**, ignoran los valores nulos.

### JOINS
-   Las operaciones de JOIN permiten combinar dos tablas y retornan otra tabla.
-   Son productos cartesianos que requieren que las filas en ambas tablas satisfagan ciertas condiciones.
-   Existen 4 tipos básicos de JOIN:
	-   INNER JOIN
	-   LEFT OUTER JOIN
	-   RIGHT OUTER JOIN
	-   FULL JOIN

**INNER JOIN:** Selecciona todas las filas de las tablas A y B donde la condición del join se satisface.
```sql
SELECT ...
FROM A
INNER JOIN B ON join_condition
```
+  ON join_condition se puede reemplazar con USING(columns)
    
![](https://lh6.googleusercontent.com/-mkI-FrmNEQCJfXknCi3PtsIIc0ZnkoMTOba5PKpg1fSv1fTJjPWcp7but3nkdwWtgcxW4hfOsRXu2FvoN8XGvL_PQ9FQ1Bywg5gWFAPMChvlEzje5VGWnzjNG0r2QrY2DF-dJFWuAdP9r4J98SCVVU)
**LEFT JOIN:** Selecciona todas las filas de las tablas A y aquellas de la tabla B donde la condición del join se satisface.
```SQL
SELECT ... 
FROM A
LEFT JOIN B ON join_condition
```
+ El término OUTER es opcional y no tiene efecto.

![](https://lh6.googleusercontent.com/NR5fnFvIiiTEzr0L4bgT7PeODd41JrpanvzGC-qNOnKumv0OJVw6LFeWq-EviYwVW45UckoXGKZbkebA5ZZZ-8KlxnLMRYJEWJouOBEgfdqNIcL7vZ5TQppuBwAtjfIo5x7z7MC8EY_rknOD5HspYls)

**RIGHT JOIN:** Selecciona todas las filas de las tablas B y aquellas de la tabla A donde la condición del join se satisface.

```sql
SELECT ... 
FROM A
RIGHT JOIN B ON join_condition
...
```
![](https://lh3.googleusercontent.com/9jVCwv03oAPhR_LjhTulrRP-fy_rfXwI6h4Rc3I3FWwdS2VWVThcRJOcxADlYUWt7_jXeGaLPaHivQRMfLthnjDJDcHGNGpK0OlNH9lHf85sx4AXuQbkuXcWf8mPvfWFURENu3uWCyXWvZod-QzFsRg)

**FULL JOIN:** Selecciona todas las filas de las tablas A y B independientemente de si la condición del join se satisface. No es el *producto cartesiano*.

![](https://lh4.googleusercontent.com/W-PbUovrBZD4JgzrbPdx6wv7EIyAQ2hABnw3U3rJPeL9GM9oSoMhOkol_Qh_wSntAciVlHs_gf13uj4RzKdUG-KraDjSUx-5v1H8kS0nM2U_ZFWVVfhwF_oEQ2j0mK3vQVWar_CWc8POOi19Xs1-680)

### Operaciones de Conjuntos
```SQL
SELECT ...
UNION [ALL] 
SELECT ...

SELECT ...
INTERSECT [ALL] 
SELECT ...

SELECT ...
EXCEPT [ALL] 
SELECT ...
```
+ Operan sobre tablas.
+ Eliminan automáticamente los duplicados.
+ Para retener duplicados hay que usar **ALL**. O sea, en la tabla final va a aparecer dos veces.

```sql
(
	SELECT course_id
	FROM section
	WHERE semester = ’Fall’ AND year= 2009
)
UNION
(
	SELECT course_id 
	FROM section
	WHERE semester = ’Spring’ AND year= 2010
)
```
(Se puede reemplazar UNION por INTERSECT o EXCEPT)
Unión e intersección son el mismo concepto que en conjuntos. `A Except B` refiere a todos de la tabla a menos los que aparecen en la B.

