# Procesamiento de consultas

El procesamiento de consultas hace referencia a la serie de actividades implicadas en la extracción de datos de una base de datos.
Incluyen:

+ **Análisis y traducción:** Traducción de consultas expresadas en lenguajes de BBDD de alto nivel en expresiones implementadas en el nivel físico del sistema
+ **Optimización:** Transformaciones de optimización de consultas y la evaluación real de las mismas.
+ **Evaluación** de la consulta

![procesamiento de consultas](https://imgur.com/ODQMJor.png)

+ Un **operador lógico** del álgebra de tablas considera un algoritmo **ineficiente**.
+ Los **operadores físicos**, en cambio, son algoritmos específicos para operadores del álgebra de tablas. En general, tienen a ser más eficientes porque hacen uso de informaciones adicionales, como índices, tamaños de búfer en memoria, ....
+ El **árbol binario de ejecución** consta de:
  + Los nodos **hoja**: son tablas de la base de datos
  + Los nodos **internos**: son operadores del álgebra de tablas

Dada una consulta $C$ del álgebra de tablas, un **plan de evaluación** consiste de un **árbol binario de ejecución** para una expresión equivalente a C y **operadores físicos** para ese árbol de ejecución.

La **evaluación** de un árbol binario de ejecución va a estar en términos de operadores físicos.

La **máquina de ejecución de consultas** toma el plan de evaluación de consulta, ejecuta ese plan y retorna las respuestas de la consulta.

Los diferentes planes de evaluación para una consulta dada pueden tener diferentes costos. Es responsabilidad del sistema gestor de bases de daros construir un plan de evaluación que minimiza el costo de evaluación.

Con el fin de **optimizar** una consulta un optimizador de consultas debe conocer el costo de cada operación.

## Medidas de costo de consulta

+ Número de **transferencias de bloques de disco**.
  + Asumimos que todas las transferencias de bloques tienen el mismo costo
  + No distinguimos entre bloques de lectura y escritura.
  + El tiempo de transferencia de bloques suele ser de `0.1 mseg` asumiendo bloques de `4KiB` y una tasa de transferencia de `40MB/seg`.
+ Número de **accesos al bloque**: llevar la cabeza lectora al bloque deseado.
  + El tiempo de acceso al bloque suele ser de `4mseg`
+ **Tamaño del búfer en memoria principal:**
  + En el mejor caso todos los datos pueden ser leídos de RAM y el disco no necesita ser accedido de nuevo.
  + Asumimos el peor caso, donde el búfer puede sostener aproximadamente 1 bloque por tabla.
+ Ignoramos los costos de **CPU** por simplicidad.

## Evaluación de expresiones

Cómo evaluar una expresión que contiene varias operaciones.

***
**Conceptos:**

+ El resultado de evaluar un operador de un nodo interno del árbol binario de ejecución que no es la raíz del árbol se llama **resultado intermedio**.

***

### Materialización

Los resultados intermedios se guardan en disco en tablas temporales a las cuales tiene acceso el sistema gestor de BD.

![ejemplo](https://imgur.com/p7eQ55h.png)

La **materialización** consiste en:

+ cambiar nodos lógicos por físicos en el árbol binario de ejecución, eligiendo el nodo físico menos costoso.
+ Evaluar un operador físico por vez comenzando en el **nivel más bajo**
+ Usamos **resultados intermedios** en tablas temporales para evaluar los operadores fisicos del siguiente nivel.

#### Operadores físicos
<!-- incompleto -->

##### Proyección

+ Requiere recorrer todos los registros y realizar una proyección en cada uno.
+ Se recorren todos los bloques de la tabla
+ Estimación de costo = $b_r$ transferencias de bloques + 1 acceso a bloque???
  + br denota el número de bloques conteniendo registros de la tabla r

##### Operadores físicos para Selección

+ La tabla está ordenada en A
+ Para $\sigma_{A \ge V} (r)$ usar el índice para encontrar el primer registro $\ge v$ y escanear la tabla secuencialmente desde allí.
  + $Costo = h_i + b$ transferencias de bloques, $h_i$ accesos de bloques
  + b el número de bloques conteniendo registros con $A \ge v$

#### Factor de selectividad

Para **estimar el tamaño de los resultados intermedios** en cantidad de bloques a escribir a disco para los operadores de selección y reunión se usa una función de probabilidad llamada **factor de selectividad** para calcular la cantidad de registros del resultado intermedio.

$fs(P, i)$ denota el factor de selectividad sobre el predicado $P$, dado el input del operador $i$ , para operadores con más de un input pueden agregarse más argumentos $fs(P, r, s, ...)$.

Para calcular el factor de selectividad se asume uniformidad e independencia.

+ **Uniformidad:** Todos los valores de un atributo son igualmente probables
+ **Independencia:** Las condiciones sobre diferentes atributos son independientes.

##### Selección

Cantidad de registros en el resultado intermedio:
$$|r| * fs(P, r)$$

Definimos $fs(P,r)$ para propiedades $P$ y tabla $r$.
Dado $A$ y $A'$ atributos de $r$, $c$ y $c'$ constantes.

**Regla 1:** Asumiendo uniformidad:
$$fs(A=c, r) = {1 \over V(A,r)}$$
donde $V(A,r)$  es el número de los distintos valores que aparecen en $r$ para $A$.

**Regla 2:** Asumiendo uniformidad, y A de tipo numérico $$fs(A \ge c, r) = {\max(A,r) - c \over \max(A,r) - \min(A,r)}$$

**Regla 3:** Asumiendo uniformidad, A de tipo numérico
 $$fs(A<c, r) = {c - min(A)\over \max(A) - \min(A) + 1 }$$

**Regla 4:** Asumiendo uniformidad, A de tipo numérico
$$fs(c \le A < c', r) = {c' - c \over max(A,r) - min(A,r)}$$

**Regla 5:** asumiendo independencia
$$fs(P_1 \land P_2 \land ... \land P_n, r) = fs(P_1, r)\times fs(P_2, r) \times ... \times fs(P_n, r)$$

**Regla 6:**
$$fs(¬ P, r) = 1 - fs(P, r)$$

**Regla 7:** Asumiendo independencia
$fs(P \lor Q, r)$
$= fs(¬(¬P \land ¬Q),r)$
$= 1 - fs(¬P \land ¬Q, r)$
$= 1 - fs(¬P,r) \times fs(¬Q, r)$
$1 - ((1- fs(P,r)) \times (1 - fs(Q,r)))$

##### Reunión

Cantidad de registros en el resultado intermedio:
$$|r| *|s|* fs(P, r, s)$$

#### Procesar y estimar el costo

1. **Decidir el plan de ejecución**
    + Armar el árbol binario de ejecución
    + Calcular el factor de selectividad para selecciones y reuniones
    + Decidir operadores físicos (solo se usan índices si la tabla de la BD lo amerita)
2. **Estimar el costo de ejecutar el plan de evaluación**
    + Calcular el tamaño en bloques de las tablas de la BD
    + Calcular el tamaño de los resultados intermedios en bloques
    + Calcular el costo de los operadores físicos
    + Sumar

$$\text{Costo total} = \sum \text{costo(operaciones)} + \sum \text{costo(materialización)}$$
$$\text{Tiempo} = \text{Costo total} \times \text{velocidad de transferencia}$$

### Encauzamiento

A medida que se van generando los resultados intermedios se van pasando al siguiente operador. Los resultados intermedios no se guardan en disco.

Se pueden combinar varias operaciones del álgebra de tablas en una tubería de operaciones en la cual los resultados de una operación son pasados para la siguiente operación de la tubería.

#### Implementación

Cada operación en la tubería puede implmentarse como un **iterador** que provee las siguientes funciones en su interfaz:

```python
class operador_físico:
 # estado del iterador
 input_procesado = 0

 # Inicializa el iterador
 def abrir(self):
  # Aloja búferes para su entrada y salida
  # Inicializar todas las estructuras de datos necesarias
  # Llama abrir() para todos los argumentos de la operación
 
 # Retorna la próxima tupla de salida de la operación
 def siguiente(self):
  # Ajusta las estructuras de datos para que tuplas siguientes sean obtenidas
  # código específico de la operación siendo realizada en los inputs.
  # llamar siguiente una o más veces en sus argumentos
  self.input_procesado += 1
  if ("no se pueden retornar más tuplas") return NotFound

 # Termina la iteración luego que todas las tuplas que pueden han sido generadas
 def cerrar(self):
  # se llama cerrar() en todos los argumentos del operador
  
```

Un iterador produce la salida de una tupla por vez y varios iteradores pueden estar activos en un tiempo dado, pasando resultados hacia arriba en el árbol de ejecución.

### Materialización vs Encauzamiento

Materialización usa mucho menos memoria y bastante más espacio en disco y encausamiento usa mucho menos espacio en disco, y bastante más memoria.

Encauzamiento elimina el costo de leer y escribir tablas temporales, reduciendo así el costo de evaluación de consultas. Además, puede comenzar generando resultados rápidamente, si el operador raíz de un plan de evaluación de consulta es combinando en una tubería con sus inputs.
