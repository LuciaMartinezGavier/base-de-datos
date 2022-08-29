# Decisiones de diseño al hacer un diagrama de entidad-relación
### Diagramas de entidad-relación

| Representación | Elemento |
| -------------- | ---------|
| Rectángulos | Conjuntos de entidades |
| Elipses | Atributos |
| Rombos | Relaciones |
| Líneas | Unen atributos a entidades y entidades a relaciones |
| Elipses dobles | Atributos multivalorados |
| Elipses discontinuas | Atributos derivados |
| Líneas dobles | Indican participación total de una entidad en un conjunto de relaciones |
| Rectángulos dobles | Conjuntos de entidades débiles |
	| Rombo doble | Relación identificadora |
| Atributos subrayados | Claves primarias |

Notación de intervalos?
![](https://imgur.com/CFpLhVU.png)

## Entidades, Relaciones, Atributos y Claves
### Entidad
Objeto en organización distinguible de otros objetos. Descrito por medio de atributos, ejemplo: objeto estudiante descrito por DNI, legajo, ... .
Un conjunto de entidades son varias entidades del mismo tipo.

### Entidades débiles
Son entidades que no tienen suficientes atributos para formar una clave primaria.  
Un conjunto de entidades que tiene una clave primaria se denomina **conjunto de entidades fuertes**.

Un conjunto de entidades débiles debe estar asociado a otro conjunto de entidades, denominado el **conjunto de entidades identificadoras** o **propietarias**.

Se dice que el conjunto de entidades débiles **depende existencialmente** del conjunto de entidades identificadoras; y que el conjunto de entidades identificadoras es **propietaria** del conjunto de entidades débiles que identifica.

La relación que asocia a estos conjuntos de entidades se denomina **relación identificadora**. Esta es de varios (débiles) a uno (identificadora) y la participación del conjunto de entidades débiles es total.

El **discriminante** es el conjunto de atributos que permite distinguir todas aquellas entidades que dependen de una entidad fuerte particular.

El conjunto de entidades identificadoras no debería tener atributos descriptivos, ya que cualquier atributo requerido puede estar asociado con el conjunto de entidades débiles.

### Relaciones
Una relación es una asociación entre entidades.

La asociación entre conjunto de entidades se conoce como *participación*, es decir, los conjuntos de entidades E1, E2, ... , EN **participan** en el conjunto de relaciones R.

Un **ejemplar de relación** representa que existe una asociación entre las entidades denominadas en la empresa del mundo real que se modela.

La función que desempeña una entidad en una relación se llama **papel** de la entidad.

Una relación también puede tener **atributos descriptivos**. Un ejemplar de relación en un conjunto de relaciones determinado debe ser identificado unívocamente a partir de sus entidades participantes, sin usar los atributos descriptivos.

Las relaciones pueden ser **binarias**, es decir, uno que implica dos conjuntos de entidades. Aunque puede ocurrir que impliquen más de dos conjuntos de entidades, y el **grado** es el número de entidades que participan.

### Atributos
Define a una entidad. Cada entidad tiene un *valor* para cada uno de sus atributos y para cada atributo hay un conjunto de valores permitidos, llamados el *dominio*.

#### Clasificación de Atributos
+ Atributos *simples* y *compuestos*: Los atributos simples no están divididos en subpartes. Los compuestos, en cambio, se pueden dividir en subpartes. Ayudan a agrupar los atributos relacionados, un atributo compuesto puede aparecer como una jerarquía.
+ Atributos *monovalorados* y *multivalorados*: Los atributos monovalorados tienen un solo valor para una entidad concreta. Un atributo que tiene un conjunto de valores para una entidad específica es un atributo multivalorado (se pueden especificar un límite superior e inferior).
+ Atributos *derivados*: Se puede derivar de los valores de otros atributos o entidades relacionados.

Un atributo toma un valor **nulo** cuando una entidad no tiene un valor para un atributo.

### Claves
Los valores de los atributos de una entidad deben ser tales que permitan *identificar unívocamente* la entidad.
Una *clave* permite identificar un conjunto de atributos lo suficiente para distinguir las entidades entre sí.
Las claves también ayudan a a identificar unívocamente a las relaciones

**Superclave**: Es un conjunto de uno o más atributos que, tomados colectivamente, permiten identificar de forma única una entidad en el conjunto de entidades. Pueden contener atributos innecesarios.

**Claves candidatas**: Son las superclaves cuyos subconjuntos no son superclave. Superclaves mínimas.

**Clave primaria**: Es la clave candidata elegida para identificar las entidades dentro de un conjunto de entidades.

También hay superclaves, claves candidatas y claves primaras para relaciones. Y se forman por las claves primarias de las entidades que la forman. La composición de la clave primaria para un conjunto de relaciones depende de al estructura de los atributos asociados al conjunto de relaciones R.

**Clave foránea**:

## Restricciones
### Correspondencia de cardinalidades
Expresa el número de entidades a las que otra entidad puede estar asociada vía un conjunto de relaciones.
+ Uno a uno
+ Uno a varios
+ Varios a uno
+ Varios a varios

### Restricciones de participación
Dado un conjunto de entidades E en un conjunto de relaciones R se dice...
+ Participación **total**: Si cada entidad en E participa al menos en una relación en R
+ Participación **parcial**: Si sólo algunas entidades en E participan en relaciones en R


### Especialización y generalización
#### Restricciones de diseño sobre las generalizaciones.

### Decisiones de diseño al construir un diagrama de entidad-relación.
#### Estructura básica de las bases de datos relacionales
#### Esquema de una base de datos relacional

## Diseño de esquema de BD de calidad
(modelado Entidad-relación)
+ **La calidad de un esquema de BD es muy importante**

Para hacer un diseño de un esquema de BD de calidad con modelado ER vamos a considerar:
+ **Errores** de modelado comunes
+ Consideración de **situaciones frecuentes** de decisión de diseño
+ Comparación entre soluciones alternativas basándonos en redundancia de datos, comprensibilidad, completitud, facilidad de consultar la información.

### Eliminación de atributos redundantes
Atributos redundantes implican costos de almacenamiento extra y propagación de modificaciones innecesarias.

Si un atributo se repite para dos entidades entonces se debería eliminar en alguna. Para representar la misma información se debe utilizar la menor cantidad de espacio.

#### Errores comunes
+ **Usar la clave primaria de una entidad como atributos de otra entidad en lugar de usar una relación**: Usar una relación  que vincula las dos entidades suele ser más adecuado para representar esta situación, porque hace la conexión entre las dos entidades explícita, en lugar de implícita vía atributos de la clave priaria de una de las entidades.
+ **Usar los atributos de clave primaria de entidades relacionadas como atributos de relación**: Mejor usar los atributos de las entidades solo en las entidades y no sumarlas a la relación, que es redundante y poco comprensible
+ **Si con la relación binaria puedo capturar los datos de una relación de grado > 2 y puedo expresar más *restricciones de integridad* que con la relación de grado > 2**, entonces conviene usar la relación binaria.
+ **Si los objetos están relacionados con entidades de una entidad fuerte que no es de identificación**, entonces es necesario modelar dichos objetos como entidades débiles
+ Uso de entidad vs usos de relación <!--TO DO: Completar-->


## Reducción de un esquema de entidad-relación a tablas
### Representación tabular de los conjuntos de **entidades fuertes**
Entidades fuertes: Conjuntos de entidades que tienen una **clave primaria**.

| \ | atributo_descriptivo_a1 | ... | atributo_descriptivo_aN | 
| --- | ---| --- | --- |
| Entidad1 |  | ... |  |
| Entidad2 | | ... | | 

Alguno de los atributos descriptivo es una clave primaria.

### Representación tabular de los conjuntos de **entidades débiles**
Conjunto de entidades que no tiene suficientes atributos para formar una clave primaria.
Sea A el conjunto de entidades débiles con  los atributos a1, ..., aN.

Y B el **conjunto de entidades fuertes del que A depende**, cuya **clave primaria** está
formada por los atributos b1, ..., bN

|    /     |  a1 | ... |  aN |  b1 | ... |  bN |
| -------- | --- | --- | --- | --- | --- | --- |
| Entidad1 |     | ... |     |     | ... |     |
| Entidad2 |     | ... |     |     | ... |     |

### Representación tabular de los conjuntos de **relaciones**
R: conjunto de relaciones
a1, ..., aN: **claves primarias** de cada uno de los conjuntos de **entidades** que **participan en R**
b1, ..., bN: **atributos descriptivos** de R (si los hay)

|     /     |  a1 | ... |  aN |  b1 | ... |  bN |
| --------- | --- | --- | --- | --- | --- | --- |
| Relación1 |     | ... |     |     | ... |     |
| Relación2 |     | ... |     |     | ... |     |

Un conjunto de relaciones uniendo **un conjunto de entidades débiles** con el correspondiente **conjunto de entidades fuertes** no necesita estar presente en una representación tabular de un diagrama E-R.

Para un conjunto de relaciones *AB*, que relacionan *A* y *B*, de varios a uno o de uno a uno se puede combinar las tablas  *AB* y *A* en una sola tabla (combinando las columnas de ambos). Y en el caso de uno a uno, tambien pueden juntarse *AB* y *B*.

### Atributos compuestos
Los atributos compuestos se manejan creando un atributo separado para cada uno de los atributos componentes.
Por ejemplo: si *dirección* consta de *ciudad* y *calle*.

|     /     |  a1 | ... |  aN |  ciudad-dirección  |  calle-dirección |
| --------- | --- | --- | --- | --- | --- |
| Entidad1 |     | ... |     |      |     |
| Entidad2 |     | ... |     |      |     |

### Atributos multivalorados
Se crean nuevas tablas con una columna que corresponde a la clave primaria del conjunto de entidades o conjunto de relaciones del que es atributo multivalorado.

### Representación  tabular de la generalización
Dos métodos:

**Crear una tabla para el conjunto de entidades de nivel más alto. Y por las de nivel más bajo crear una tabla que incluya una columna para la clave primaria y columnas para sus atributos.**

Ejemplo: (Cuil es clave primaria de persona)

|Personas |  nombre | apellido |  Cuil |  ciudad-dirección  |  calle-dirección |
| --------- | --- | --- | --- | --- | --- |
| Persona1 |     | |     |      |     |
| Persona2 |     |  |     |      |     |

|Empleado |  Cuil | salario |
| --------- | --- | --- | 
| Empleado1 |     |     |
| Empleado2 |     |     |

| Cliente |  Cuil  | límite-crédito |
| --------- | --- | --- |
| Entidad1 |     |  |   
| Entidad2 |     |  |

Si la representación es disjunta y completa (no hay ninguna entidad que sea miembro de dos conjuntos de entidades de menor nivel y si cada conjunto de entidad de nivel más alto también pertenece a uno de  los conjuntos de entidades de nivel más bajo):
Para cada conjunto de entidades de nivel más bajo se crea una tabla que incluya una columna por cada atributo del conjunto de entidades más una columna por *cada* atributo del conjunto de entidades de nivel más alto.

|  Empleado |  Cuil | salario | nombre | apellido |  ciudad-dirección  |  calle-dirección |
| --------- | ----- | --- | --- |---|---| --- |
| Empleado1 |       |     |
| Empleado2 |       |     |

|  Empleado |  Cuil | limite-crédito | nombre | apellido |  ciudad-dirección  |  calle-dirección |
| --------- | ----- | --- | --- |---|---| --- |
| Empleado1 |       |     |
| Empleado2 |       |     |


### Representación tabular de la agregación
Se transforman los conjuntos de relaciones y los conjuntos de entidades dentro de la entidad agregada.

Práctico: [[BasesDeDatos/base-de-datos/teórico/practico1]]
