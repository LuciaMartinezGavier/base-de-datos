# Diagramas de Entidad-Relación
### Notación

| Representación | Elemento |
| -------------- | -------- |
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

![](https://imgur.com/Mz3gO1o.png)
  
![](https://imgur.com/CFpLhVU.png)


**Notación de intervalos**
![Diagrama](https://lh4.googleusercontent.com/k1b2kpIM1QHO3AQl4jkySxnLei06ZmfPxTrrSPITSBQ-QeCW2hGk4ndyj6a31DS3eKZnrzHa6tHJHif-kG8Jx95Wjx2eyWieOBH8pyMxpmv3ZBA-R2HhPSSHFov6lK3BhMT5bqJurihAfc8cr3Bl)

![Diagrama](https://lh3.googleusercontent.com/RoQtnPzqaqFxDJkMMCZ3d4TJ5xA-9gveJ9Xb-qh3xWr9AQMPfJ147oEmw6OnwnqbBUabeDYacR7m7500raenT_i2xAAwXglVtX7e-7-BSr0WO09t0NTBqsyAixJsBgpT2rRFd0SV0J3uvz0fkY6q)


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
+ Atributos *derivados*: Se puede derivar de los valores de otros atributos o entidades relacionados. El valor de un atributo derivado no se almacena, sino que se calcula cuando sea necesario.

Un atributo toma un valor **nulo** cuando una entidad no tiene un valor para un atributo.

### Claves
Los valores de los atributos de una entidad deben ser tales que permitan *identificar unívocamente* la entidad.
Una *clave* permite identificar un conjunto de atributos lo suficiente para distinguir las entidades entre sí.
Las claves también ayudan a a identificar unívocamente a las relaciones

**Superclave**: Es un conjunto de uno o más atributos que, tomados colectivamente, permiten identificar de forma única una entidad en el conjunto de entidades. Pueden contener atributos innecesarios.

**Claves candidatas**: Son las superclaves cuyos subconjuntos no son superclave. Superclaves mínimas. Puede ser que haya claves candidatas con diferentes cardinalidades.
<!--Ejemplo: Casa: Número, Calle, Ciudad #3, o Casa: Código Postal #1-->

**Clave primaria**: Es la clave candidata elegida para identificar las entidades dentro de un conjunto de entidades.

También hay superclaves, claves candidatas y claves primaras para relaciones. Y se forman por las claves primarias de las entidades que la forman. La composición de la clave primaria para un conjunto de relaciones depende de al estructura de los atributos asociados al conjunto de relaciones R.

**Clave foránea**: Las tablas se relacionan con otras tablas mediante una relación de clave primaria o de clave foránea. Las relaciones de claves primarias y foráneas se utilizan en las bases de datos relacionales para definir relaciones de muchos a uno entre tablas.

Una clave foránea es una columna o un conjunto de columnas en una tabla cuyos valores corresponden a los valores de la clave primaria de otra tabla. Para poder añadir una fila con un valor de clave foránea específico, debe existir una fila en la tabla relacionada con el mismo valor de clave primaria.

## Restricciones
### Correspondencia de cardinalidades
Expresa el número de entidades a las que otra entidad puede estar asociada vía un conjunto de relaciones.
+ Uno a uno
+ Uno a varios
+ Varios a uno
+ Varios a varios

### Restricciones de integridad
Una restricción de integridad proporcionan un medio de asegurar que las modificaciones hechas a la base de datos por los usuarios autorizados no provoquen la pérdida de la consistencia de los datos.

### Restricciones de participación
Dado un conjunto de entidades E en un conjunto de relaciones R se dice...
+ Participación **total**: Si cada entidad en E participa al menos en una relación en R
+ Participación **parcial**: Si sólo algunas entidades en E participan en relaciones en R.

## Especialización y generalización
### Especialización
<!--Parecido al concepto de herencia. -->
Un conjunto de entidades puede incluir subgrupos de entidades que se diferencian de alguna forma de las otras entidades del conjunto.

El proceso de designación de subgrupos dentro de un conjunto de entidades se denomina **especialización**.

Se puede aplicar repetidamente la especialización para refinar el esquema de diseño; y un conjunto de entidades se puede especializar por más de una característica distintiva.

En términos de un diagrama E-R, la especialización se representa mediante un componente *triangular* etiquetado ES. La relación ES se puede llamar también relación **superclase-subclase**.

**Ejemplo:**
![](https://imgur.com/u4PHGED.png)

### Generalización
Consiste en varios conjuntos de entidades que se sintetizan en un conjunto de entidades de nivel más alto basado en características comunes.
La **generalización** es una relación contenedora que existe entre el conjunto de entidades de *nivel más alto* y uno o más conjuntos de entidades de *nivel más bajo*.

Los conjuntos de entidades de nivel más alto y nivel más bajo también se pueden llamar **superclase** y **subclase** respectivamente.

Para propósitos prácticos,  la generalización es una *inversión de la especialización*.

La generalización se usa para *resaltar las similitudes* entre los conjuntos de entidades de nivel más bajo y para *ocultar las diferencias*; y para *economizar* la representación para que los atributos compartidos no estén repetidos.

#### Restricciones de diseño sobre las generalizaciones.
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
 +  **Generalización o especialización total**: Cada entidad de nivel más alto debe pertenecer a un conjunto de entidades de nivel más bajo. Se puede especificar en un diagrama E-R con una línea doble para conectar el rectángulo que representa el conjunto de entidades de nivel más alto con un triángulo.
 
 + **Generalización o especialización parcial**: Algunas entidades de nivel más alto pueden no pertenecer a algún conjunto de entidades de nivel más bajo. (Predeterminada).


## Decisiones de diseño al construir un diagrama de entidad-relación.
(modelado Entidad-relación)
+ **La calidad de un esquema de BD es muy importante**

Para hacer un diseño de un esquema de BD de calidad con modelado ER vamos a considerar:
+ **Errores** de modelado comunes
+ Consideración de **situaciones frecuentes** de decisión de diseño

### Principios de diseño
1. Evitar *redundancia de datos*
2. *Comprensibilidad*: Interpretabilidad para humanos
3. *Completitud* para describir el problema
4. *Solución mínima* (evitar información innecesaria y suposiciones prematuras)
5. *Eficiencia y eficacia* de consultas

### Escenarios comunes de decisión
1. **¿Atributo o relación?**
	+ Si el atributo es la clave primaria de otra entidad, preferimos relación.
	+ Es un error usar *la clave primaria de una entidad como atributos de otra entidad* en lugar de usar una relación: Usar una relación hace la conexión entre las dos entidades explícita, en lugar de implícita vía atributos de la clave primaria de una de las entidades.
2. **¿Relación de grado mayor a 2 o relación binaria?**
	+ Algunas relaciones que parecen no ser binarias podrían ser representadas mejor con varias relaciones binarias. Porque se pueden expresar más *restricciones de integridad*. \*
3. **¿Entidad débil o atributo compuesto?**
	+ Pensarlo como entidad débil si la complejidad puede ir creciendo.
	+ Si los objetos están relacionados con entidades de una entidad fuerte que no es de *identificación*, entonces es necesario modelar dichos objetos como entidades débiles.
4. **¿Entidad o atributo?**
	+ Una entidad modela mejor una situación en la que se puede querer almacenar información extra. 
	+ Si almacena un solo valor, conviene un atributo.
	+ Las entidades son apropiadas cuando la generalidad puede ser de utilidad.
5. **¿Entidad o relación?**
+ Si hay redundancia elegir la relación.
+ Cuando la relación es uno-varios o varios-uno y si hay atributos (no de clave primaria) en la entidad del lado uno, entonces los atributos de la entidad del lado uno no no son de clave primaria dan lugar a *redundancia de información* si se usa la alternativa entidad. Por  lo tanto, conviene relación.
+ Lo mismo pasa con la relación de varios-varios.

### Eliminación de atributos redundantes
Atributos redundantes implican costos de almacenamiento extra y propagación de modificaciones innecesarias.

Si un atributo se repite para dos entidades entonces se debería eliminar en alguna. Para representar la misma información se debe utilizar la menor cantidad de espacio.

## Reducción de un esquema de entidad-relación a tablas
### Representación tabular de los conjuntos de **entidades fuertes**
Entidades fuertes: Conjuntos de entidades que tienen una **clave primaria**.

| \ | atributo_descriptivo_a1 | ... | atributo_descriptivo_aN | 
| --- | ---| --- | --- |
| Entidad1 |  | ... |  |
| Entidad2 | | ... | | 

Alguno de los atributos descriptivo es una clave primaria.

### Representación tabular de los conjuntos de entidades débiles
Conjunto de entidades que no tiene suficientes atributos para formar una clave primaria.
Sea A el conjunto de entidades débiles con  los atributos a1, ..., aN.

Y B el **conjunto de entidades fuertes del que A depende**, cuya **clave primaria** está
formada por los atributos b1, ..., bN

|    /     |  a1 | ... |  aN |  b1 | ... |  bN |
| -------- | --- | --- | --- | --- | --- | --- |
| Entidad1 |     | ... |     |     | ... |     |
| Entidad2 |     | ... |     |     | ... |     |

### Representación tabular de los conjuntos de relaciones
R: conjunto de relaciones
a1, ..., aN: **claves primarias** de cada uno de los conjuntos de **entidades** que **participan en R**
b1, ..., bN: **atributos descriptivos** de R (si los hay)

|     /     |  a1 | ... |  aN |  b1 | ... |  bN |
| --------- | --- | --- | --- | --- | --- | --- |
| Relación1 |     | ... |     |     | ... |     |
| Relación2 |     | ... |     |     | ... |     |

Un conjunto de relaciones uniendo **un conjunto de entidades débiles** con el correspondiente **conjunto de entidades fuertes** no necesita estar presente en una representación tabular de un diagrama E-R.

Para un conjunto de relaciones *AB*, que relacionan *A* y *B*, de varios a uno o de uno a uno se puede combinar las tablas  *AB* y *A* en una sola tabla (combinando las columnas de ambos). Y en el caso de uno a uno, también pueden juntarse *AB* y *B*.

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

Ejemplo: (cuil es clave primaria de persona)

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

***
Práctico: [[BasesDeDatos/base-de-datos/teórico/practico1]]
