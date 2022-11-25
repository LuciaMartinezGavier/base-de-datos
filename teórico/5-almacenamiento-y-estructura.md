# Almacenamiento y estructura de archivos

La Base de datos es almacenada como una **colección de archivos**.

Los archivos se organizan lógicamente como secuencias de **registros**. A su vez, un registro es una secuencia de campos. Y estos registros se corresponden con los bloques del disco.

Es decir, un archivo de la base de datos también es particionado en unidades de almacenamiento de tamaño fijo (**bloques**).

Los bloques son unidades tanto de alojamiento de almacenamiento como de transferencia de datos.

## Acceso al almacenamiento

El sistema gestor de BD busca minimizar la cantidad de transferencia de bloques entre disco y memoria.

Podemos reducir la cantidad de accesos a disco manteniendo tantos bloques como sea posible en memoria principal.

+ **Búfer:** porción de memoria principal disponible para almacenar copias de bloques de disco.
+ **Gestor de búfer:** subsistema responsable para alojar espacio de búfer en memoria principal. Los programas llaman al gestor de búfer cuando necesitan un bloque del disco.

## Organización de los archivos

### Registros de longitud fija

Un enfoque para organizar archivos es usar un tamaño de registro fijo, donde cada archivo tiene registros de un tipo particular solamente. Y diferentes archivos son usados para tablas diferentes de la base de datos.

Hay dos problemas en este enfoque.

1. Resulta difícil **borrar** un registro de esta estructura. Se debe rellenar el espacio ocupado por el registro que hay que borrar con algún otro registro del archivo (1) o tener algún medio de marcar los registros borrados para que puedan pasarse por alto(2).
2. A menos que el tamaño de los bloques sea un múltiplo del tamaño del tamaño del registro (improbable) algunos registros se saltarán los límites de los bloques. Es decir, parte del registro se guardará en un bloque y parte en otro. Harán falta, por lo tanto, **dos accesos a bloques** para leer o escribir ese tipo de registros.

Para mitigar el primer problema, al comienzo del archivo se asigna cierto número de bytes como **cabecera del archivo**. En principio tendríamos almacenado en ella la dirección del primer registro cuyo contenido se haya borrado y a partir de esta se genera una lista enlazada llamada **lista libre**.

La inserción y el borrado de archivos con registros de longitud fija son sencillas de implementar

(1)
![Borrado de un archivo](https://imgur.com/nU77emG.png)

(2)
![Borrar un archivo con lista libre](https://imgur.com/GfgcJyu.png)

## Organización de los registros en archivos

Hay varias maneras de organizar los registros en archivos.

1. **Organización de archivos en heap:** Se puede colocar cualquier registro en cualquier parte del archivo en que haya espacio suficiente. No hay ordenación de los registros. Generalmente solo hay un archivo por cada relación.
2. **Organización de archivos secuenciales:** Los registros se guardan en orden secuencual, basado en el valor de la clave de búsqueda de cada registro.
3. **Organización asociativa (*hash*) de archivos:** En esta organización se calcula una función de esociación (*hash*) de algún atributo de cada registro. El resultado del hash especifica el bloque del archivo en que se deberá colocar el registro.
    1. En una **organización de archivos en agrupacioes** se pueden guardar en el mismo archivo registros de relaciones direnentes; además, los registros relacionados de las diferentes relaciones se guardan en el mismo bloque, por lo que cada operación de E/S afecta a registros relacionados de todas esas relaciones.

### Organización de archivos secuenciales

Está diseñado para el procesamiento eficiente de los registros de acuerdo con un orden basado en una **clave de búsqueda** (cualquier atributo o conjunto de atributos, no necesita ser la clave primaria o una superclave).

Los registros se vinculan mediante punteros. El puntero de cada deregistro apunta al siguiente registro según el orden indicado por la clave de búsqueda (**linked list**). Y para minimizar el número de accesos a los bloques en el procesamiento de los archivos secuenciales, los registros **se guardan físicamente de acuerdo con el orden indicado por la clave de búsqueda**, o en un orden tan cercano a éste como sea posible.

#### Borrado

Usar cadenas de punteros (**lista libre**).

#### Insesión de registros

1. Localizar el registro del archivo que precede al registro que se va a insertar en el orden de la clave de búsqueda.
2. Si existe algún registro vacío dentro del mismo bloque que ese registro, el registro nuevo se insertará ahí. En caso contrario el nuevo registro se insertará en un *bloque de overflow*. En cualquier caso, hay que ajustar los punteros para vincularo los registros según el orden de la clave de búsqueda.

Hace falta reorganizar el archivo cada cierto tiempo para restaurar el orden secuencial.

**Evaluación:** No es muy eficiente para hacer consultas que necesitan acceder a registross relacinados de dos tablas.

### Agrupamiento de tablas en archivos

Muchos sistemas de bases de datos relacionales guardan **cada relación en un archivo diferente**. Generalmente las tuplas de cada relación pueden representarse como registros de longitud fija.

Una **organización de archivos en agrupaciones** almacena registros relacionados de dos o más relaciones en cada bloque. Esta organización permite leer muchos de los registros que satisfacen la condición de join utilizando un solo proceso de lectura de bloques. Por tanto, se puede procesar esta consulta concreta de manera más eficiente.

Es decir, varias tablas van en un archivo.
También, resulta en **registros de tamaño variable**.

**Evaluación:** Esta organización es buena para consultas involucrando $\bowtie$.
Esta organización produjo el retardo del procesamiento de otros tipos de consulta por ejemplo

```sql
SELECT *
FROM cliente
```

De hecho, hallar todos los registros de *cliente* no resulta posible sin alguna estructura adicional: Para encontrar todas las tuplas de la relación *cliente* hay que vincular los registros de esa relación utilizando punteros.

### Organización de archivo con árbol B⁺

[6-indices](6-indices.md)
