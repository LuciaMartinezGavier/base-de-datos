# Introducción:
## Bases de datos y DBMS

“Una **base de datos** es una colección de datos organizados relevantes a un 
dominio que son administrados y consultados mediante un sistema de 
administración de base de datos (DBMS).”

“Un **Database Management System** (DBMS) es un sistema que permite la gestión
y consulta de base de datos.”

Gestión | Consulta
--- | ---
	Definicion de esquema | responder preguntas sobre los datos
creacion de datos | realizar análisis sobre los datos

### Modelo de datos
“Un **modelo de datos** es una colección de herramientas conceptuales para 
describir los datos, las relaciones entre ellos, su semántica y las restricciones de 
consistencia.”

Define la estructura lógica de la base de datos.  
Impacta en la forma en que los datos son almacenados y manipulados.   
Existen diferentes modelos de datos:
-   **Modelo Relacional** (**SQL**)
-   **Modelos No relacionales** (**NoSQL**):
-   Modelo de Objetos  (Realm DB)
-   Modelo de Documentos (MongoDB)
-   Modelos de Grafos (Neo4J)

### Bases de datos relacionales
Las **bases de datos relacionales** (RDBMS) son una implementación del modelo relacional introducido en los 70s por [Edgar Codd](https://en.wikipedia.org/wiki/Edgar_F._Codd) en A Relational Model of Data for Large Shared Data Banks

* La estructura básica es la **tabla** (relación).
* La tabla define columnas (**atributos**) y tiene filas de datos (**tuplas**).
* Se pueden **relacionar** una o más tablas.
* Las columnas tienen un cierto **tipo de datos** (dominio)
* Usan **SQL** como lenguaje para manipular y consultar datos.

## Diseño de Bases de Datos
### Características de una buena BD
Una base de datos bien diseñada debe:
* Eliminar la redundancia de datos
	* Evitar inconsistencia
	* No malgastar almacenamiento
* Asegurar la integridad de los datos
	* Usar claves primarias correctas: "clave primaria" identifica **unívocamente** una fila de una tabla. Usar 2 o 3 columas que identifican una fila.
	* Evitar inconsistencias
* Facilitar la aplicación de las reglas de negocio

Es un proceso iterativo. Se tiene que ir mejorando en cada iteración.

**Herramientas**
1. [Análisis de Requerimientos](#analisis-de-requerimientos)
2. [Creación de Tablas](#creacion-de-tablas)
3. [Definición de Relaciones entre Tablas](#definicion-de-relaciones-entre-tablas)
4. [Normalización](#normalizacion)
5. Repetir

## Analisis de Requerimientos
Se definen:
* El objetivo de la base de datos.
* Dominio de la aplicación
* Las entidades
* Que consultas/reportes debemos responder

La base de datos se diseña junto con la aplicación

## Creacion de Tablas
Tranformar en tablas los conceptos del dominio
Definir tipos de datos
Especificar **claves primarias**: Usualemte son de tipo numérico y autoincremental

#### Una clave primara debe ser:
* **Única** y **No nula**
* Simple e intuitiva
* **Inmutable**
* Con la menor cantidad de columnas posibles


## Definicion de Relaciones entre Tablas
### Relaciones entre tablas:

#### Uno a muchos
* No se pueden representar con una sola tabla
* Existen una tabla madre (1) y una tabla hija (*)
* En la table hija tenemos como **clave foránea** la clave primaria de la tabla padre

![](https://lh6.googleusercontent.com/lE3YJUViPKOPP3xk-f-89dG_6gNiQs2ePMxCgeYLudHlVNrVH7w6p-F7E75LCruT4_y-9b3DfPQceO5pSvdSzsObJjeiPgAMTE06l4ahNLsxUW70-7OEs668b-0hzcl0Q1F0d5dU2tcroD9C4tG11D4)
#### Muchos a muchos
-   Para soportar relaciones muchos-a-muchos necesitamos introducir una tercer 
tabla: la tabla de asociación.
-   Se modela como dos relaciones uno-a-muchos entre las tablas padres y la tabla de asociación. 

![](https://lh5.googleusercontent.com/18u7WlE6YbIPSw5nqi_NNEG4rzwJVQZotNLAs1QPDREWWmdTLABpQn4pzjdeVNCEarjKBB44OJVnOP9-jHTNwVnxZs0M4kmmRs1njrDrFCjIhHYcMYA3dVn4HC2lwUdQTnfopVuHYPMoBm4NK7mHpEE)

#### Uno a Uno
-   Se suelen utilizar para representar información complementaria
-   Utiles para partir una tabla “grande” en tablas más pequeñas.

![](https://lh3.googleusercontent.com/vRST09o83Edtk21pIws43C4O1Wgo9oPa8QG-XtdHMWChcEr76o9qasK9BM7sCkzHISzYa2wXVIatijvfdS3FQM6MHXlxEWsQUL7oWKHzC1I1ifBIGALe79cFqtPSTp5PHuAGHNiRJeqwNRoO9vDCil4)

## Normalizacion
-   **Primera Forma Normal(1NF)**: El dominio de las columnas debe ser atómico.
	-   Evitar listas de valores en una columna. Usar uno-a-muchos.
	-   Si usan columnas JSON [no son 1NF](https://www.thomascerqueus.fr/json-fields-relational-databases-postgresql/).

-   **Segunda Forma Normal (2NF)**: 1NF + toda columna que no forma parte de la clave primaria depende de todas las columnas de la clave primaria.
	-   Todos las columnas estan definidas por la clave primaria.

-   **Tercera Forma Normal(3NF)**: 2NF + toda columna que no forma parte de la clave primaria depende solamente de la clave primaria.
	-   Evitar columnas derivadas. Más datos para la misma info por  ej: edad y fecha de nacimiento
