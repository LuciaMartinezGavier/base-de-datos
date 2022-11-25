# Índices

## Conceptos básicos

+ **Clave de búsqueda**: Son los atributos o conjunto de atributos usados para buscar en un archivo. Si hay varios índices en un archivo, existirán varias claves de búsqueda.
+ **Mecanismos de indexado:** Usados para acceder más rápido a los datos deseados.
+ **Archivo de índice:** Consiste de registros llamados *entradas del índice* de la forma `<clave de búsqueda, puntero>`.
+ Los archivos de índice son típicamente mucho más chicos que el archivo original.

## Criterios de evaluación de técnicas de indexación

+ **Tipos de acceso:** Los tipos de acceso que se soportan eficientemente. Por ejemplo la búsqueda de registros con un valor concreto en un atributo, o buscar los registros cuyos atributos contengan valores en un rango espeficado.
+ **Tiempos de acceso:** El tiempo que se tarda en  buscar un determinado elemento de datos, o conjunto de elementos. usando la técnica en cuestión.
+ **Tiempo de inserción:** El tiempo empleado en insertar un nuevo elemento de datos. Incluye el tiempo utilizado en buscar el lugar apropiado y el tiempo en actualizar la estructura del índice.
+ **Tiempo de borrado:** El tiempo empleado en borrar un elemento de datos. Incluye el tiempo en buscar el elemento, y el tiempo en actualizar la estructura del índice.
+ **Espacio adicional requerido:** El espacio adicional ocupado por la estructura del índice. Como normalmente la cantidad necesaria de espacio adicional suele ser moderada. es razonable sacrificar el espacio para alcanzar un rendimiento mejor.

## Tipos de índices

### Índices ordenados

Estos índices están basados en una disposición ordenada de los valores
Un archivo puede tener varios índices según diferentes claves de búsqueda.

#### Índice primario

Si el archivo que contiene los registros está ordenado secuencialmente, el índice cuya clave de búsqueda especifica el orden secuencial del archivo es el **índice primario** (o **clustering índices**).
La clave de búsqueda de un índice primario es normalmente la clave primaria, aunque no es así necesariamente.

##### Índices densos y dispersos

+ **Índice denso:** Aparece un registro índice **por cada valor de la clave de búsqueda** en el archivo. El resto de registros con el mismo valor de la clave de búsqueda se almacenan consecutivamente después del primer registro
+ **Índice disperso:** Sólo se crea un **registro índice para algunos de los valores**. Para localizar un registro de busca la entrada del índice con el valor más grande que sea menor o igual que el valor que se está buscando. Se empieza por el registro apuntado por esa entrada del índice y se continúa con los punteros del archivo hasta encontrar el registro deseado.

| índice denso | Índice disperso |
| --- | --- |
| ![Indice denso](https://imgur.com/20UxSuY.png) | ![Indice disperso](https://imgur.com/f1W43D3.png) |
| Requieren más espacio para entradas de índices | Requieren menos espacio y menos sobrecarga de mantenimiento para inserciones y borrados en la tabla |
| Más rápidos para localizar registros | Más lentos para localizar registros |

##### Índice multinivel

Incluso si se usan índices disperso, el propio índice podría ser demasiado grande para un procesamiento eficiente.

Los índices con dos o más niveles se llaman **índices multinivel**. La búsqueda de registros usando estos índices necesita menos operaciones de E/S que las que se emplean en la búsqueda de registros con  la búsqueda binaria.

Se trata al índice primario mantenido en disco como archivo secuencial y se construye un índice disperso en el mismo.

+ **Índice externo:** índice disperso del índice primario.
+ **Índice interno:** archivo del índice primario.

![indice multinivel](https://imgur.com/GQeNpoM.png)

#### Índice secundario

Son los índices cuyas claves de búsqueda especifican un orden diferente del orden secuencial del archivo.
También se conoces como **non clustering indices**.

Los índices secundarios deben ser densos. Si un índice secundario almacena sólo algunos de los valores de la clave de búsqueda, los registros con los valores de la clave de búsqueda intermedios pueden estar en cualquier lugar del archivo y, en general, no se pueden encontrar sin explorar el archivo completo.

Además, un índice secundario debe contener punteros a todos los registros. Porque el resto de registros con el mismo valor de la clave de búsqueda podrían estar en cualquier otro lugar del archivo.

Para evitar tantos índices, cada registro del índice apunta a un *bucket* que contiene punteros a todos los registros actuales con el valor particular de clave de búsqueda.

![indice secundario con un nivel de indirección](https://imgur.com/l08q7oP.png)

El escaneo secuencial usando índices secundarios es muy costoso, cada acceso a registro de tabla puede requerir recoger un nuevo bloque de disco.

#### Actualización del índice

##### Inserción

Primero se realiza una búsqueda usando el valor de la clave de búsqueda del registro a insertar

###### Inserción con Índices densos

1. Si el **valor de la clave de búsqueda no aparece en el índice**, el sistema inserta en éste un registro índice con el valor de la calce de búsqueda en la posición adecuada.
2. En caso contrario:
    1. Si el **registro índice almacena punteros a todos lo registros con el mismo valor de la clave de búsqueda**, el sistema añade un puntero al nuevo registro en el registro índice
    2. En caso contrario, el registro índice almacena un punto solo hacia el primer registro con el valor de la clave de búsqueda. El sistema sitúa el registro insertado después de los otros con los mismo valores de la clave de búsqueda.

###### Inserción con Índices dispersos

Se asume que el índice almacena una entrada por cada bloque.

1. Si el sistema **crea un bloque nuevo**, inserta el primer valor de la clave de búsqueda (en el orden de la clave de búsqueda).
2. Si el nuevo registro tiene el **menor valor de la clave de búsqueda en su bloque**, el sistema actualiza la entrada del índice que apunta al bloque; sino, no realiza ningún cambio sobre el índice.

##### Borrado

Primero se busca el índice a borrar.

###### Borrado con Índices densos

1. Si el registro borrado era el **único registro con ese valor de la clave de búsqueda** el sistema borra el registro índice correspondiente.
2. En caso contrario,
    1. Si el **registro índice almacena punteros a todos los registros con el mismo valor de la clave de búsqueda**, el sistema borra del registro índice.
    2. En caso contrario, si el registro borrado era el primer registro con el valor de la clave de búsqueda, el sistema actualiza el registro índice para apuntar al siguiente.

###### Borrado con Índices dispersos

1. Si el índice no contiene un registro índice con el valor de la clave de búsqueda del registro borrado, no se hace nada.
2. En caso contrario,
    1. Si el registro borrado era el **único registro con la clave de búsqueda**, el sistema reemplaza el registro índice correspondiente con un registro índice para el siguiente valor de la clave de búsqueda. Si el siguiente valor de la clave de búsqueda ua tiene una entrada en el índice, se borra.
    2. En caso contrario, si el registro índice apunta al registro a borrar, el sistema actualiza el registro índice para que apunte al siguiente registro con el mismo valor de la clave de búsqueda.

##### Índices multinivel

Algoritmos de inserción y borrado para índices de varios niveles son una extensión simple del esquema ya descrito.

#### Índices con varias claves

Una clave de búsqueda conteniendo más de un atributo se llama **clave de búsqueda compuesta**.

La estructura del índice es la misma como la de cualquier otro índice; la única diferencia es que la clave de búsqueda del índice contiene una **lista de atributos**.

El orden de los valores de la clave de búsqueda es el **orden lexicográfico**.

##### Acceso a múltiples claves de búsqueda

Se pueden usar múltiples índices para ciertos tipos de consultas

```sql
SELECT id
FROM instructor
WHERE dept_name = 'Finance'
AND salary = 80000
```

Posibles estrategias con índices con una sola clave:

+ Usar índice en dept_name para encontrar instructores con nombre de departamento 'Finance'; testear salary = 80000.
+ Usar índice en salary para encontrar instructores con salary de 80000; testea dept_name = 'Finance'
+ Usar índice en dept_name para encontrar punteros a todos los registros pertenecientes al departamento de finanzas. Similarmente usar índice en salario para hallar punteros a registros con salario de 80000. Tomar la intersección de ambos conjuntos de punteros obtenidos.

Si tenemos un índice en la clave de búsqueda (dept_name, salary) puede ser usado para recoger solo registros que satisfacen ambas condiciones.

Se puede manejar eficientemente
`WHERE dept_name = 'Finance' AND salary < 80000` pero no se puede manejar eficientemente `WHERE dept_name < 'Finance' AND salary = 80000` porque puede recolectar varios registros que satisfacen la primera condición, pero no la segunda.

### Índices asociativos

Estos índices están basados en una distribución uniforme de los valores a través de una serie de *buckets*. El valor asignado a cada bucket está determinado por una función *hash*.

### Índices de árbol B⁺

Ataca el inconveniente que tiene la organización de un archivo secuencial respecto al rendimiento que se degrada según crece el archivo, tanto para buscar en el índice como para buscar secuencialmente a través de los datos.

Un árbol B⁺ toma la forma de un **árbol equilibrado** donde los caminos de la raíz a cada hoja del árbol son de la mismo longitud.

Es estructura implica una degradación del rendimiento al insertar y al borrar, ademas hay algo de espacio desperdiciado puesto que los nodos podrían estar a lo sumo medio llenos (si tienen el mínimo número de hijos).
Pero se evita el coste de reorganizar el archivo.

#### Estructura de árbol B⁺

Un **nodo típico** de un árbol B⁺ puede contener hasta $n-1$ claves de búsqueda $K_1, K_2, ... , K_{n-1}$ y $n$ punteros $P_1, P_2, ..., P_n$.
Los valores de la clave de  búsqueda de un nodo se mantienen ordenados; así, si $i < j$, entonces $K_i < K_j$ .

|     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
| $P_1$ | $K_1$ | $P_2$ | ... | $P_{n-1}$ | $K_{n-1}$ | $P_n$ |

![arbol B+](https://imgur.com/P8BbuhJ.png)

Los $P_i$ son:

+ Para **nodos no hoja**: punteros a hijos
+ Para **nodos hoja**: punteros a registros o *buckets* de registros (cajones).

$P_n$ apunta al próximo nodo hoja en el orden de clave de búsqueda

#### Propiedades

+ Todos los caminos desde la raíz a una hoja son de la misma longitud.
+ Cada nodo que no es la raíz o una hoja tiene entre $⌈n/2⌉$ y n hijos.
+ Un nodo hoja tiene entre $⌈(n-1)/2⌉$ y $n -1$ valores.
+ Si la raíz no es una hoja, tiene al menos $2$ hijos. o Si la raíz es una hoja, puede tener entre $0$ y $n -1$ valores.
+ Las claves de búsqueda en un nodo están ordenadas. $K_1 < K_2 < ... < K_{n–1}$
+ Los rangos de valores en cada hoja no se solapan, excepto cuando hay valores de clave de búsqueda duplicados, en cuyo caso un valor puede estar presente en más de una hoja.
+ Si hay K valores de clave de búsqueda en la tabla, la altura del árbol B+ no es mayor a $⌈\log_{⌈n/2⌉}(K)⌉$ : este es el costo de buscar un índice en un árbol B+

#### Consultas con árboles B⁺

Supongamos que se desean encontrar todos lo registros cuyo valor de búsqueda sea V.

```C
struct b_node {
 int n; // pointers in node
 key *K; // n-1 keys
 b_node *P; // n pointers
};

struct b_tree {
 b_node root;
};

key search(value V, b_tree B) {
 b_node cur_node = B->root;
 key K = cur_node; 
 int i = 0;

 while !is_leaf_node(cur_node) {
  // índice del menor valor de la clave mayor o igual que V
  i = closest_gte_index(cur_node, V);

  // si no hay un valor mayor que V
  if (cur_node->K[i] == NULL) {
   // c es el nodo apuntado por P_m (el último puntero)
   cur_node = cur_node->P[C->m];
  } else {
   // C es el nodo apuntado por P_i
   cur_node = cur_node->P[i]
  }
 }

 // Si hay un valor de clave K_i en C->K tal que K_i = V
 key found_key = search_in_array(cur_node->K, V);
 return found_key; // puede ser NULL si V no está en B
}

```

#### Actualizaciones en árboles B⁺

Borrados e inserciones a la tabla pueden ser manejados eficientemente, porque el índice puede ser restructurado en tiempo logarítmico.

+ Puede ser necesario **dividir** un nodo demasiado grande, o **fusionar** si un nodo es demasiado pequeño (menor que $⌈n/2⌉$ punteros).

#### Manejando duplicados

+ Con claves de búsquedas duplicadas (tanto en nodos hoja como internos) no podemos garantizar que $K_1 < K_2 < ... < K_{n–1}$ pero sí $K_1 \le K_2 \le ... \le K_{n–1}$
+ Las claves de búsqueda en el subárbol al cual $P_i$ apunta son $\le K_i$ pero no necesariamente $< K_i$.  Porque el mismo valor de clave de búsqueda **V** puede estar presente en dos nodos hoja distintos $L_i$, $L_{i+1}$, entonces $K_i$ debe ser igual a **V**.

Modificamos el procedimiento de búsqueda:
Se recorre $P_i$ incluso si $V=K_i$, cuando alcancemos un nodo hoja $L$, chequear si $L$ tiene soloo valores de clave de búsqueda menores que $V$. Si es así, sea $C = \text{hermano derecho de C}$ antes de chequear si $C$ contiene a $V$.

#### Indexando strings

Crear índices en un árbol B⁺ para atributos de tipo `string` da lugar a dos problemas:

+ Los strings pueden ser de longitud variable
+ Los strings pueden ser largos, dando lugar a menor cantidad de punteros por nodo y llevando a aumentar la altura del árbol.

La cantidad de punteros de un nodo puede ser aumenatda usando una técnica llamada **compresión de prefijos**.
Esta consiste en no almacenar el valor entero de la clave de búsqueda, sino solo almacenar un **prefijo** de cada valor que es suficiete para distinguir entre los valores de las claves de búqeuda en los subárboles que separa.

***

### Organización de archivo con árbol B⁺

Así como organizamos el archivo de índice usando un árbol B⁺, podemos atacar el problema de la **degradación de un archivo de datos** usando la misma técnica.

Los **nodos hoja** en una organización de archivo de árbol B⁺ almacena registros en lugar de punteros.

Como los registros ocupan más espacio que los punteros, el máximo número de registros que pueden ser almacenados en un nodo hoja es menor que el número de punteros en un nodo no hoja.

![organización de archivo con árbol b+](https://imgur.com/4eTIhCG.png)
