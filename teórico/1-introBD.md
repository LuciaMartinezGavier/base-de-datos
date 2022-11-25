# **Introducción**

## ¿Qué es una base de datos?
---
“Una **base de datos** es una colección de datos organizados relevantes a un 
dominio que son administrados y consultados mediante un sistema de 
administración de base de datos (DBMS).”
***

Una base de datos es una colección de **datos relacionados** que tiene las
siguientes propiedades implícitas:
* Representa algún aspecto del mundo real (en ocasiones se denomina *minimundo* o
*universo de discurso*)
* Es lógicamente coherente con algún tipo de significado inherente. (No es un
surtido aleatorio de datos).
* Una base de datos se diseña, construye y rellena para un propósito específico.

Se usan ampliamente. Permiten navegar, consultar y alterar las informaciones.

### Niveles de abstracción
Nivel **físico**: describe cómo se almacena un registro
Nivel **lógico**: describe los datos almacenados y sus relaciones
Nivel **vista**: lo que ven los programad de aplicación

## Aplicaciones de bases de datos
Se utilizan para guardar información de diversos tipos en áreas como:
Banca, Líneas Aéreas, Universidades. Transacciones de Tarjetas de Crédito,
Telecomunicaciones, Finanzas, Ventas, Producción, Recursos Humanos...

## Esquemas e instancias
**Esquema**: Se usa para describir la estructura de la Base de datos.
**Instancias** Contenido efectivo de la BD en un momento del tiempo.

## Modelos de los datos
***
“Un **modelo de datos** es una colección de herramientas conceptuales para 
describir los datos, las relaciones entre ellos, su semántica y las restricciones de 
consistencia.”
***

Define la estructura lógica de la base de datos.  
Impacta en la forma en que los datos son almacenados y manipulados.   
Existen diferentes modelos de datos:
-   **Modelo Relacional** (**SQL**)
-   **Modelos No relacionales** (**NoSQL**):
-   Modelo de Objetos  (Realm DB)
-   Modelo de Documentos (MongoDB)
-   Modelos de Grafos (Neo4J)

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

* La estructura básica es la **tabla** (relación).
* La tabla define columnas (**atributos**) y tiene filas de datos (**tuplas**).
* Se pueden **relacionar** una o más tablas.
* Las columnas tienen un cierto **tipo de datos** (dominio)
* Usan **SQL** como lenguaje para manipular y consultar datos.

## Modelos de datos no relacionales
Una base de datos no relacional es aquella que **no usa el esquema tabular** de
filas y columnas que se encuentra en la mayoría de los sistemas de base de datos
más tradicionales.
Ej: NoSQL

Usan un modelo de almacenamiento que está **optimizado para los requisitos
específicos del tipo de datos que se almacena**. Por ejemplo, los datos se pueden
almacenar como pares clave/valor simple, como documentos *JSON* o como un grafo
que consta de bordes y vértices.

## Lenguajes consulta
**Consulta**: Expresión que describe una colección de datos deseada.
Lenguajes de consulta: SQL, XQuery, SPARQL.

- **Puros**: álgebra relacional o de tuplas. Se concentran en menos aspectos. Se
puede **verificar** que las consultas hacen lo que se espera.

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
Evitar la repetición de la información. Es mejor un esquema sin redundancia.
Conviene siempre descomponer en esquemas más chicos.

## Diseño de entidad-relación
Modelado conceptual. Un nivel de abstracción más alto que el modelo relacional.
En esto se basa el diseño de la base de datos, compuesta por entidades, atributos
y relaciones.

## Teoría de normalización
Cómo diseñar buenos esquemas de bases de datos relacionales.

La normalización es un método científico de convertir tablas complejas en
estructuras de tablas simples usando ciertas reglas. Es el proceso mediante el
cual se transforman datos complejos a un conjunto de estructuras de datos más
pequeñas, que además de ser más simples y más estables, son más fáciles de
mantener.

## Traducción de diseño de entidad-relación a tablas
¿Cómo se puede representar un esquema E-R mediante tablas?

## Sistemas gestores de bases de datos DBMS 
***
“Un **Database Management System** (DBMS) es un sistema que permite la **gestión**
y **consulta** de base de datos.”
***
**Gestión**: 
-   Definición de esquema.
-   Creación de datos.
-   Creación de relaciones, actualización de datos, seguridad, etc.

**Consulta**:
-   Responder preguntas sobre los datos.
-   Realizar análisis con los datos.

### Arquitectura de un sistema de bases de datos
Los componentes funcionales de un sistema de base de datos se pueden dividir a
grandes rasgos en los componentes:
* [Gestor de almacenamiento](#gestor-de-almacenamiento)
* [Procesamiento de consultas](#procesamiento-de-consultas)
* [Gestor de transacciones](#gestor-de-transacciones)

## Gestor de Almacenamiento
El *gestor de almacenamiento* es un módulo de programa que proporciona la
interfaz entre los datos de bajo nivel en la vase de datos y los programas de
aplicación y consultas emitidas al sistema.
* Responsable de la interacción con el gestor de archivos.
Interfaz para programas de aplicación y consultas: acceso al almacenamiento,
organización en archivos de los datos, indexado. API

- acceso, modificación y retorno
- eficiente mediante índices

## Procesamiento de consultas
1. Parsear la consulta: se traduce a álgebra relacional.
2. Optimizar: encontrar la manera más eficiente.
3. Evaluar: obtener el resultado

## Transacciones
Concepto muy usado en data mining
Operaciones que se corresponden con una función lógica simple. Ejemplo: subir
una nota a guaraní.

Algunas transacciones pueden producir fallas. Por ejemplo se saca plata de una
cuenta pero no se pone en otra porque se corta la luz.
La solución es la **atomicidad**. Todas las operaciones de la transacción son 
reflejadas en la BD o ninguna lo es. Se garantiza que el sistema es
**consistente**.

## Planificaciones
Secuencias que indican el **orden** cronológico en el cual las instrucciones de
transacciones concurrentes son ejecutadas.
Se utilizan locks para bloquear áreas de la BD durante las escrituras.

## Gestor de transacciones
Las transacciones deben cumplir 4 propiedades ACID
1. Atomicity: una operación no puede quedar a medias.
2. Consistency: solo se empieza aquello que se puede acabar.
3. Isolation: una operación no puede afectar a otras.
4. Durability: los cambios persisten.
<!-- Página 33 -->

## Arquitectura de aplicaciones de bases de datos
![](https://imgur.com/EK0e82T.png)

Usuarios de un sistema de da bases de datos se conectan a través de una red:
De pueden diferenciar:
* Máquinas **cliente**: trabajan usuarios remotos de la base de datos
* Máquinas **servidor**: se ejecuta el sistema de bases de datos