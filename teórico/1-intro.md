
# **Introducción**

## ¿Qué es una base de datos?
Una base de datos es una colección de **datos relacionados** que tiene las
siguientes propiedades implícitas:
* Representa algún asécto del mundo real (en ocasiones se denomina *minimundo* o
*universo de discurso*)
* Es lógicamente coherente con algún tipo de significado inherente. (No es un
surtido aleatorio de datos).
* Una base de datos se diseña, construye y rellena para un proósito específico.

Se usan ampliamente. Permiten navegar, consultar y alteral las informaciones.

## Aplicaciones de bases de datos
Se utilizan para guardar información de diversos tipos en áreas como:
Banca, Líneas Aéreas, Universidades. Tensacciones de Tarjetas de Crédito,
Telecomunicaciones, Finanzas, Ventas, Producción, Recursos Humanos...

## Esquemas e instancias
**Esquema**: Se usa para describir la estructura de la Base de datos.
**Instancias** Contenido efectivo de la BD en un momento del tiempo.

## Modelos de los datos
Es una colección de herramientas conceptiales para describir los datos, las
relacioes, la semántica y las restricciones de consistencia.

* Modelo entidad-relación
* Modelo relacional

## Modelo relacional
Se utiliza un grupo de tablas para representar los datos y las relaciones entre
ellos.

|esquema| columnas|
|---    |    ---  |
|filas  |instancia|

El modelo relacional es un ejemplo de un *modelo basado en registros*: la base
de datos se estructura en registros de formato fijo de varios tipos. Cada tabla
contiene registros de un tipo particular. Cada tipo de registro define un número
fijo de campos, o atributos. Las columnas de la tabla corresponden a los
atributos del tipo de registro.


## Modelos de datos no relacionales
Una base de datos no relacional es aquella que no usa el esquema tabular de
filas y columnas que se encuentra en la mayoría de los sistemas de base de datos
más tradicionales.
Ej: NoSQL
Usan un modelo de almacenamiento que está optimizado para los requisitos
específicos del tipo de datos que se almacena. Por ejemplo, los datos se pueden
almacenar como pares clave/valor simple, como documentos JSON o como un grafo
que consta de bordes y vértices.

## Lenguajes consulta
**Consulta**: Expresión que describe una colección de datos deseada.
Lenguajes de consulta: SQL, XQuery, SPARQL.

- **Puros**: álgebra relacional o de tuplas. Se concentran en menos aspectos. Se
puede verificar que las consultas hacen lo que se espera.

El **sistema gestor** de BD procesa consultas. Gestor de almacenamiento,
procesamiento de consultas y gestor de transacciones.

## SQL
Es un lenguaje de consulta:
SQL significa Lenguaje de consulta estructurado (Structured Query Language)
SQL es un lenguaje de bases de datos global: cuenta con sentencias para definir
datos, consultas y actualizaciones. 

```SQL
SELECT name, salary
FROM instructor
WHERE salary > 50000
```

## Álgebra relacional
Se llama álgebra relacional a un conjunto de operaciones simples sobre tablas
relacionales, a partir de las cuales se definen operaciones más complejas
mediante composición. Definen, por tanto, un pequeño lenguaje de manipulación
de datos.

## Diseño de base de datos relacionales
Evitar la repetición de la información. Es mejor un esquema sin reduncdancia.
Conviene siempre descomponer en esquemas más chicos.

## Diseño de entidad-relación
Modelado conceptual. Un nivel de abstracción más alto que el modelo relacional.
En esto se basa el diseño de la base de datos, compuesta por entidades y
relaciones.

**Entidad:** Objeto en organización distinguible de otros objetos. Descrito por
medio de atributos, ej: objeto estudiante descrito por dni, legajo, ... .

**Relación:** asociación entre entidades

## Teoría de normalización
Cómo diseñar buenos esquemas de bases de datos relacionales.

La normalización es un método científico de convertir tablas complejas en
estructuras de tablas simples usando ciertas reglas. Es el proceso mediante el
cual se transforman datos complejos a un conjunto de estructuras de datos más
pequeñas, que además de ser más simples y más estables, son más fáciles de
mantener.

## Traducción de diseño de endidad-relación a tablas

## Sistemas gestores de bases de datos
El **sistema gestor** de BD es/se encarga del:
* Gestor de almacenamiento
* Procesamiento de consultas
* Gestor de transacciones

## Arquitectura

## Gestión del almacenamiento
Interfaz para programas de aplicación y consultas: acceso al almacenamiento, organización en archivos de los datos, indexado

- acceso, modificación y retorno
- eficiente mediante índices

## Procesamiento de consultas
## Transacciónes
## Planificaciones
## Gestión de transacciones
## Arquitectura de aplicaciones de bases de datos