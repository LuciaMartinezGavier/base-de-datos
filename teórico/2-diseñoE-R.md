# Decisiones de diseño al hacer un diagrama de entidad-relación

## Diseño de esquema de BD de calidad
(modelado Entidad-relación)
+ **La calidad de un esquema de BD es muy importante**

Para hacer un diseño de un esquema de BD de calidad con modelado ER vamos a considerar:
+ **Errores** de modelado comunes
+ Consideración de **situaciones frecuentes** de decisión de diseño
+ Comparación entre soluciones alternativas basandono en redundancia de datos, comprensibilidad, completitud, facilidad de consultar la información.

### Eliminacion de atributos redundantes
Atributos redundantes implican costos de almacenamiento extra y propagación de modificaciones innecesarias.

Si un atributo se repite para dos entidades entonces se debería eliminar en alguna. Para representar la misma información se debe utilizar la menor cantidad de espacio.

#### Errores comunes
+ **Usar la clave primaria de una entidad como atributos de otra entidad en lugar de usar una relación**: Usar una relación  que vincula las dos entidades suele ser más adecuado para representar esta situación, porque hace la conexión entre las dos entidades explícita, en lugar de implícita vía atributos de la clave priaria de una de las entidades.
+ **Usar los atributos de clave primaria de entidades relacionadas como atributos de relación**: Mejor usar los atributos de las entidades solo en las entidades y no sumarlas a la relación, que es redundante y poco comprensible
+ **Si con la relación binaria puedo capturar los datos de una relación de grado > 2 y puedo expresar más *restricciones de integridad* que con la relación de grado > 2**, entonces conviene usar la relación binaria.
+ **Si los objetos están relacionados con entidades de una entidad fuerte que no es de identificación**, entonces es necesario modelar dichos objetos como entidades débiles
+ Uso de entidad vs usos de relacion <!--TO DO: Completar-->




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

Si la representación es disjunta y completa (no hau ninguna entidad que sea miembro de dos conjuntos de entidades de menor nivel y si cada conjunto de entidad de nivel más alto tambien pertenece a uno de  los conjuntos de entidades de nivel más bajo):
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
Se transofrman los conjuntos de relaciones y los conjuntos de entidades dentro de la entidad agregada.