# Orientación a objetos

## Limitaciones del modelo relacional

+ Representaciones forzadas para algunos problemas
+ Escenarios con relaciones complejas
+ Escenarios cambiantes
+ Inferencias

Como solución a esas limitaciones se propone una división entre la interfaz e implementación.

Una base de datos orientada a objetos tiene **variables** (atributos), **mensajes** que se responden con métodos y **herencia**.

## Programación  orientada a objetos vs BD

La diferencia es la **persistencia**.
En orientación a objetos, los objetos desaparecen cuando se termina la ejecución. Queremos que los objetos permanezcan en la base de datos.

Los lenguajes de programación persistentes añaden la persistencia y otras características de las bases de datos a los lenguajes de programación existentes con sistemas de tipos orientados a objetos.

Por otro lado, los lenguajes de consulta relacionales como SQL también necesitan ser extendidos para trabajar con el sistema de tipos enriquecido.

## Especialización y generalización

### Especialización
<!--Parecido al concepto de herencia. -->
Un conjunto de entidades puede incluir subgrupos de entidades que se diferencian de alguna forma de las otras entidades del conjunto.

El proceso de designación de subgrupos dentro de un conjunto de entidades se denomina **especialización**.

Se puede aplicar repetidamente la especialización para refinar el esquema de diseño; y un conjunto de entidades se puede especializar por más de una característica distintiva.

En términos de un diagrama E-R, la especialización se representa mediante un componente *triangular* etiquetado ES. La relación ES se puede llamar también relación **superclase-subclase**.

**Ejemplo:**
![ejemplo](https://imgur.com/u4PHGED.png)

#### Reducción a tablas

1. Una tabla para la entidad de nivel alto
2. Para las entidades de nivel más bajo, una tabla con una columna para cada atributo y una columna para cada atributo de la clave primaria de la entidad de nivel más alto.

Para la especialización disjunta y completa no es necesaria una tabla para la entidad de nivel más alto.

### Generalización

Consiste en varios conjuntos de entidades que se sintetizan en un conjunto de entidades de nivel más alto basado en características comunes.
La **generalización** es una relación contenedora que existe entre el conjunto de entidades de *nivel más alto* y uno o más conjuntos de entidades de *nivel más bajo*.

Los conjuntos de entidades de nivel más alto y nivel más bajo también se pueden llamar **superclase** y **subclase** respectivamente.

Para propósitos prácticos,  la generalización es una *inversión de la especialización*.

La generalización se usa para *resaltar las similitudes* entre los conjuntos de entidades de nivel más bajo y para *ocultar las diferencias*; y para *economizar* la representación para que los atributos compartidos no estén repetidos.

#### Restricciones de diseño sobre las generalizaciones

Un tipo de restricción implica determinar qué entidades pueden ser miembros de un conjunto de entidades de nivel más bajo dado.

##### Relaciones de miembros

+ **Definido por condición**: Se evalúa en función de si una entidad satisface o no una condición explícita o predicado.
+ **Definido por atributo**: Cuando todas las entidades de nivel más bajo se evalúan en función del mismo atributo.
+ **Definido por el usuario**: No están restringidos mediante una condición de miembro. La asignación al grupo se hace de forma individual por el usuario a cargo de la decisión.

##### Relaciones de pertenencia a conjuntos

Se define según si las entidades pueden pertenecer a más de un conjunto de entidades de nivel más bajo en una generalización simple.

+ **Disjunto**: Requiere que una entidad no pertenezca a más de un conjunto de entidades de nivel más bajo.
+ **Solapado**: La misma entidad puede pertenecer a más de un conjunto de entidades de nivel más bajo en una generalización simple.

Le entidad de nivel más bajo solapada es el caso *predeterminado*; la restricción sobre el carácter disjunto se debe colocar explícitamente.
Se puede identificar una restricción sobre el carácter disjunto en un diagrama E-R añadiendo la palabra *disjunto* en el símbolo del triángulo.

##### Restricción de completitud

Especifica si un conjunto de entidades de nivel más alto debe pertenecer o no a al menos a uno de los conjuntos de entidades de nivel más bajo en una generalización/especialización.

+ **Generalización o especialización total**: Cada entidad de nivel más alto debe pertenecer a un conjunto de entidades de nivel más bajo. Se puede especificar en un diagrama E-R con una línea doble para conectar el rectángulo que representa el conjunto de entidades de nivel más alto con un triángulo.

+ **Generalización o especialización parcial**: Algunas entidades de nivel más alto pueden no pertenecer a algún conjunto de entidades de nivel más bajo. (Predeterminada).

## Relaciones anidadas

Un dominio es *atómico* si los elementos del mismo se consideran unidades indivisibles.

El **modelo relacional anidado** es una extensión del modelo relacional en la que los **dominios** pueden ser atómicos o **de relación**. Por tanto, el valor de las tuplas de los atributos puede ser una relación,  y las relaciones pueden guardarse en otras relaciones.

Los objetos complejos, entonces, pueden representarse mediante una única tupla de las relaciones anidadas.

![relaciones anidadas](https://imgur.com/syBHvaV.png)

### Tipos complejos

+ **Tipos colección y tipos de objetos de gran tamaño**
  + Los tipos colección que los atributos sean **conjuntos**,**arrays**, **multiconjuntos**, es decir los atributos multivalorados de los diagramas E-R se representan directamente.
  + Los objetos de gran tamaño (**clob** y **blob**, *binary large object*) se usan normalmente en aplicaciones externas y tiene poco sentido extraerlos completamente en SQL.
+ **Tipos estructurados:**
  + Son tipos que conforman una estructura
  + `create type Libro as (titulo varchar(20), fecha date, autores varchar(20) array[10])`
  + Los tipos estructurados permiten la representación directa de atributos compuestos de los diagramas E-R.
  + Un tipo estructurado puede tener **métodos** definidos sobre él. Los métodos se declaran como parte de la definición de tipos de un tipo estructurado.

## Herencia

La herencia puede hallarse en el nivel de los tipos o en el nivel de las tablas.

### Herencia de tablas

Las subtablas se corresponden con la noción del modelo E-R de la especialización y la generalización.

```sql
CREATE TABLE persona OF Persona

-- Los tipos de las subtablas deben ser subtipos del
-- tipo de la tabla madre.
CREATE TABLE estudiantes OF Estudiante
UNDER persona

CREATE TABLE profesores OF Profesor
UNDER persona

-- también existe la herencia múltiple en tablas
-- como resultado de la declaración, cada tupla presente
-- en la tabla aydantes está también en profesores, estudiantes
-- y persona
CREATE TABLE ayudantes OF Ayudante
UNDER estudiantes, profesores
```

El operador `only` permite buscar tuplas que estén en una tabla madre pero no en sus subtablas.

## Ontologías

Son grafos de representación del conocimiento.
![ontología](https://lh5.googleusercontent.com/X4_DdXeAnwhXnttkE6lLQmjSWo77kaTxNBm_3S_W93R0mtg-IfWH90UmUf5lmHT4ThXVWVDjkQdaUZEcFHMmC-_mWEtlSXpYwFF2Tybq9Hr3kHWRy1q6pV0Fpb6aAUZK2E_sp_B0N9f6OoD7q5yZZoyKP0fc1WU-_DUm0WQsomY1l7XX27uXBPKFZK1YH0Q)

## Lógicas de descripción

Las **lógicas de descripción**, también llamadas lógicas descriptivas (DL por *description logics*) son una familia de lenguajes de representación del conocimiento que pueden ser usados para representar conocimiento terminológico de un dominio de aplicación de una forma estructurada y formalmente bien comprendida.

+ **Descripciones de conceptos**
+ **Semántica:** equivalencia entre fórmulas de lógicas de descripción y expresiones en lógica de predicados de primer orden.
+ **Formalismo descriptivo:** Conceptos, roles, individuos y constructores.
+ **Formalismo terminológico:** descripciones complejas y propiedades
+ **Formalismo asertivo:** Propiedades de individuos.

Con las lógicas de descripción se pueden hacer cuantificaciones y restricciones de dominio.

Formalizar el conocimiento, permite inferir nuevo conocimiento con algoritmos de razonamiento decidible.

## Datos no estructurados

Estos datos son difíciles de catalogar.

Un modelo de datos es un modelo abstracto que organiza elementos de datos y estandariza las relaciones entre ellos y con las entidades del mundo real.

Los datos no estructurados son información que no tiene un modelo de datos predefinido.

El texto y multimedia son dos tipos comunes de contenido no estructurado. Muchos documentos de empresas no son estructurados como mensaje email, fotos, paquetes web y archivos de audio.

### Cómo estructurar datos no estructurados

Representar un documento como tabla.

+ Cada palabra es un atributo (una columna)
+ El valor es la cantidad de veces que ocurre la palabra
+ Se podrían almacenar solo las palabras frecuentes, claves o canónicas

Una imagen

+ Almacenar las palabras clave
+ Se crean "bolsas" de palabras visuales
