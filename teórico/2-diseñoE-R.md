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