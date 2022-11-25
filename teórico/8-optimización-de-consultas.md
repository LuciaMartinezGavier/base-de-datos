# Optimización de consultas

Un **plan de evaluación** define qué algoritmo es usado para cada operación y cómo se coordina la ejecución de las operaciones.

## Pasos en optimización de consultas basada en costo

1. Generar expresiones lógicamente equivalentes usando **reglas de equivalencia**
2. Anotar expresiones resultantes para obtener planes de consulta alternativos
3. Elegir el plan más económico basado en el **costo estimado**.
    + Se basa en información estadística acerca de tablas, estimación estadística para resultados intermedios, fórmulas de costos para algoritmos.
    + Las estadísticas son computadas periódicamente porque tienen a no cambiar radicalmente en un corto tiempo y porque incluso si son algo imprecisas, son útiles si son aplicadas consistentemente a todos los planes.

Los optimizadores hacen uso de la **información estadística** sobre las relaciones, como los tamaños de las relaciones y las profundidades de los índices, para realizar una buena estimación del coste de cada plan. El acceso a los discos suele dominar el coste del procesamiento de las consultas.

Dado que el coste es una estimación, el plan seleccionado no es necesariamente el menos costoso.

## Información almacenada para las estadísticas

Los catálogos de los sistemas gestores de base de datos almacenan la siguiente información estadística sobre las relaciones de las bases de datos

+ $n_r$ el número de tuplas de la relación $r$
+ $b_r$ el número de bloques que contienen tuplas de la relación $r$
+ $t_r$ el tamaño de cada tupla de la relación en $r$ bytes
+ $f_r$ el factor de bloqueo de la relación $r$, es decir el n° de tuplas de la relación $r$ que caben en un bloque.
+ $V(A,r)$ el número de valores distintos que aparecen en la relación $r$ para el atributo A. Este valor es igual que el tamaño de $\Pi_A(r)$. Si $A$ es una clave de la relación $r$, $V(A,r)$ es $n_r$.

Las estadísticas sobre los índices, como las alturas de los árboles B + y el número de páginas hojas de los índices, también se conservan en el catálogo.

En la mayor parte de los sistemas no se actualizan las estadísticas en cada modificación sino durante los períodos de poca carga del sistema.

## Transformación de expresiones de consulta

Se dice que dos expresiones del álgebra relacional son **equivalentes**, si en cada ejemplar legal de la base de datos, las dos expresiones generan el mismo conjunto de tuplas.

Dos expresiones del álgebra de tablas son **equivalentes por igualdad** si las dos tablas son equivalentes en esquema e información.

Dos expresiones del álgebra de tablas son **equivalentes por módulo de ordenamiento de registros** si las dos expresiones generan el mismo multiconjunto de tuplas. Es decir, dos expresiones a lo sumo alteran el orden de las tuplas.
$$r =_o S \iff O(r) = O(s)$$
Hay más nociones de equivalencia que no vemos como por ejemplo no considerar el orden de las columnas o no considerar los duplicados.

### Reglas de equivalencia

Una **regla de equivalencia** dice que las expresiones de dos formas son equivalentes usando uno de los tipo de equivalencia mencionados.

**Nomenclatura:**

+ Usaremos $\theta_{r}^N$ para indicar una lista de N columnas de la tabla r.
+ Usaremos $\theta_{r}^N = \theta_{s}^N$ para indicar la igualación de cada columna de $\theta_{r}^N$ con las columnas de $\theta_{s}^N$. Se omite la tabla y/o cantidad de columnas si no hay ambiguedad.
+ Usaremos $p_r$ para indicar una proposición que solo utilice columnas de r.

***

1. Cascada de $\sigma$: La selección conjuntiva de operaciones puede ser **deconstruida** en una secuencia de selecciones individuales:
$$\sigma_{q_1 \land q_2}(E) = \sigma_{q_1}(\sigma_{q_2}(E)) $$
2. Las operaciones de selección son **conmutativas**
$$\sigma_{q_1}(\sigma_{q_2}(E)) = \sigma_{q_2}(\sigma_{q_1}(E))$$
3. Solo la **última** en una secuencia de operaciones de proyección es **necesitada**, las **otras pueden ser omitidas**.
$$\Pi_{L_4}(\Pi_{L_2} (...(\Pi_{L_n}(E))...)) = \Pi_{L_4}(E)$$
4. La reunión natural es asociativa: %%y conmutativa%%
$$(E_1 \bowtie E_2) \bowtie E_3 = E_1 \bowtie (E_2 \bowtie E_3)$$
5. (Parecida a la definición de reunión selectiva)
$$\Pi_{\theta}(\sigma_{\theta_r^N = \theta_s^N} (r \times s))= (r_{\theta_r^N} \bowtie_{\theta_s^M} s )))$$
Con las $\theta$ columnas de $\bowtie$

6. Cómo expresar una **selección de una reunión selectiva** por medio de una **reunión selectiva**
$$ \sigma_{\theta_r^N = \theta_s^N} (r_{\theta_r^M} \bowtie_{\theta_s^M} s))) = r_{\theta_r^N,\space \theta_r^M} \bowtie_{\theta_s^N,\space \theta_s^M}$$
7. Cómo aplicar **selección antes de reunión selectiva**
$$\sigma_{p_r} (r_{\theta_r}\bowtie_{\theta_s} s) = \sigma_{p_r}(r)_{\theta_r}\bowtie_{\theta_s} s$$
8. (Se deduce de reglas previas) $$\sigma_{p_r \land p_s} (r_{\space\theta_r}\bowtie_{\theta_s} s) = \sigma_{p_r} (r)\space_{\theta_r}\bowtie_{\theta_s}\sigma_{p_s}(s)$$
9. La siguiente regla muestra cómo se comporta la protección cuando se usa junto con la reunión selectiva $$\Pi_{\theta_r^N, \theta_s^O}(r\space_{\theta_r^M} \bowtie_{\theta_s^M} s) = \Pi_{\theta_r^N}(r)\space_{\theta_r^M} \bowtie_{\theta_s^M} \Pi_{\theta_s^O} (s)$$ con $\theta_r^M \subseteq \theta_r^N$ y $\theta_s^M \subseteq \theta_s^N$
10. La concatenación "conmuta" alternando solo el orden de las tuplas $$r ++ s =_O s ++ r$$
11. La concatenación es asociativa
12. Selección distribuye con concatenación, intersección y resta $$\sigma(r\star s) = \sigma_p(r) \star \sigma_p(s)$$ con $\star \in \{++, \cap, \backslash$  }
13. (Más débil que la anterior) $$\sigma(r\star s) = \sigma_p(r) \star s$$ con $\star \in \{\cap, \backslash$  }
14. La proyección distribuye con la concatenación $$\Pi_\theta(r++s) = \Pi_\theta(r) ++ \Pi_\theta(s)$$
15. Eliminación de duplicados distribuye con reunión natural: $$v(r\bowtie s) = v(r) \bowtie v(s)$$
16. Eliminación de duplicados conmuta con selección: $$v(\sigma_P(r) = \sigma_P(V(r)))$$

### Optimización heurística

Aunque el costo de optimización de consultas puede ser reducido, el número de diferentes planes de evaluación para una consulta puede ser muy grande  y encontrar el plan óptimo para ese conjunto requiere mucho esfuerzo computacional.

Los sistemas pueden usar **optimización heurística** para reducir el número de elecciones y transformar el árbol de consulta usando un conjunto de reglas que típicamente (no siempre) mejoran el desempeño de ejecución.

#### Ejemplos

+ **Realizar selección tempranamente** (reduce el número de tuplas)
+ **Realizar proyección tempranamente** (reduce el número de atributos)
+ **Hacer la selección más restrictiva antes de hacer otras selecciones**
+ **Hacer operaciones de reunión más restrictivas**
+ **Ciertas selecciones pueden ser combinadas para tornar las operaciones en una reunión**
  + La operación de reunión es generalmente más eficiente
  + Para esto suele ser conveniente introducir una proyección también
+ **Referirse a operadores físicos**
  + Comenzar juntando el par de tablas cuyo resultado tiene el tamaño estimado menor.
  + Si el plan usa selección $\sigma_{A=C}(r)$ y r tiene un índice en el atributo A, realizar escaneo de ese índice en r.
  + Si un argumento de una reunión tiene un índice en atributos de la reunión para la tabla de la derecha, usar reunión de loop anidado indexada.
  + Si in argumento de la reunión está ordenado en los atributos de la reunión, es preferible usar sort-join a hash-join.
  + Cuando se computa la unión o intersección de 3 o más relaciones, agrupar las más pequeñas primero

### Optimización basada en costo

Un optimizador basado en costo explora el espacio de todos los planes de evaluación de consultas que son equivalentes a la consulta dada y elige el que tiene el menor costo estimado.

Un enfoque muy usado es el **bottom-up**:

+ Para cada subexpresión de un árbol de ejecución de consulta computamos los costos de todas las maneras de computar tal subexpresión.
+ Las posibilidades y costos de una subexpresión E son computados considerando las opciones para las subexpresiones de E, y combinándolas de todas las maneras posibles con implementaciones para el operador raíz de E.

En el enfoque **bottom-up** consideramos solo el mejor plan para cada subexpresión cuando computamos los planes para una subexpresión más grande.

Una variación de la estrategia bottom-up se llama **programación dinámica** donde **mantenemos para cada subexpresión solo el plan de menor costo**: A medida que trabajamos hacia arriba en el árbol consideramos posibles implementaciones de cada nodo, asumiendo el mejor plan para cada subexpresión es usado.

Este enfoque no garantiza que se obtenga el mejor plan global, aunque a menudo lo hace.

### Selección de orden de reunión basado en costo

Cuando tenemos una reunión de dos tablas, necesitamos ordenar los argumentos. Y cuando la reunión involucra más de 2 tablas, el número de árboles crece rápidamente.

**Observación**: los distintos ordenes pueden cambiar también el orden de las columnas. Pero podemos proyectar según los atributos de la expresión original de la consulta para que eso no suceda.

Elegir el orden de reuniones naturales óptimo para una consulta:
$$r_1 \bowtie r_2 \bowtie ... \bowtie r_n$$

Con $n$ tablas hay $${(2 \times (n-1))! \over (n-1)!}$$
diferentes ordenaciones.

No hace falta generar todos los órdenes de reunión porque usando **programación dinámica** el orden de reunión de menor costo para cada subconjunto de $\{r_1, ..., r_i\}$ es computado solo una vez y almacenado para uso futuro.

#### Solución usando programación dinámica

+ Construimos **inductivamente** una **tabla** con una entrada para cada **subconjunto** de una o más de las **tablas de la reunión**. En la cual se almacena.
  + El tamaño estimado de la reunión de esas tablas. Ya vimos como se hace esto usando el factor de selectividad.
  + El menor coste de computar la reunión de esas tablas
  + La expresión que da lugar al menor costo.
+ Complejidad $O(3^n)$

##### Caso base

+ La entrada para una sola tabla $r$ consiste del tamaño de $r$, un costo de $0$ y la expresión que es $r$.
+ La entrada para un par de tablas $\{r_i, r_j\}$ tiene estimación de tamaño que es $$|r_i| \times |r_j| \times fs(r_i, r_j) = 0$$
  + es 0 porque no hay tablas intermedias involucradas
  + tomamos la **menor** de $r_i$, y $r_j$ como el argumento izquierdo de la expresión de la reunión natural, porque dados los algoritmos de $\bowtie$, esto es más eficiente

##### Paso inductivo

+ Consideramos todas las maneras de particionar el conjunto actual de tablas S en dos subconjuntos disjuntos S1 y S2. Para cada subconjunto consideramos la suma de:

 1. Los mejores costos de S1 y S2
 2. Los tamaños para los resultados para S1 y S2

+ Sea cual sea la partición que da el mejor costo, usamos esta suma como el costo de S y la expresión de S es la reunión natural de las mejores expresiones para S1 y S2.
+ Para tomar en cuanta el costo de las reuniones, una modificación posible es sumar el costo de S1, y de S2 al menor costo de juntar los dos resultados usando el mejor algoritmo disponible.

#### Árboles de reunión profunda a la izquierda

En **árboles de reunión profunda a la izquierda**, el lado derecho de cada reunión natural es una tabla, no el resultado de una reunión intermedia.
%%incompleto%%

### Enfoques híbridos

Algunos sistemas gestores de BD combinan heurísticas con optimización parcial basada en costo.

## Manejo de presupuesto de costo

Para evitar que el optimizador de consultas esté demasiado tiempo buscando el plan ótimo, la mayoría de los optimizadores permiten un **presupuesto de costo**.

La búsqueda del plan óptimo es terminado cuando el presupuesto de optimización de costo es excedido y el mejor plan **encotrado** es retornado.

El presupuesto también puede ser **manejado dinámicamente**
Si un plan barato es encontrado para una consulta, entonces el presupuesto de costo puede ser reducido. Si el plan escogido es muy costoso, tiene sentido invertir más tiempo en optimización.
