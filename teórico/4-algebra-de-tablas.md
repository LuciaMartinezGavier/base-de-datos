# Álgebra de tablas

## Introducción

El Álgebra Relacional es un conjunto de operaciones que describen el resultado de realizar una consulta en una base de datos relacional.

El Álgebra Relacional tiene como base la teoría de conjuntos, es decir, no permite múltiples ocurrencias ni orden.

Se redefinen los operadores del Álgebra relacional a través de operaciones sobre listas de tuplas en vez de conjuntos de tuplas.

Se usa la notación de Haskell.

## Tablas y sus esquemas

Una tabla tiene \[nombre\], campos y valores. Los campos son nombres y tipo t.

| campo1 :: t1 | campo2 :: t2 | ... | campoN :: tN |
| ------------ | ------------ | --- | ------------ |
| v11          | v12          | ... | v1N          |
| v21          | v22          | ... | v2N          |
| ...          | ...          | ... | ...          |
| vM1          | vM2          | ... | vMN          |

EL encabezado de la tabla es lo que llamamos _esquema_

### Esquema de tabla

_R ::= nombre (campo1 :: t1, campo2 :: t2, ... , campoN :: tN)_

Una tabla es un esquema y una lista de tuplas que respetan ese esquema.
Cada tupla de tabla tiene como tipo $dom(R) = (\tau_1 \space \times ... x \space \tau_N)$

- $\_ :: \tau$
  - denota un campo cuyo nombre no importa o es anónimo.
- $\text{nombre} :: R$
  - denota una tabla \<nombre\> con esquema R.
- $\tau \in nombre$
  - Denota a una tupla de la tabla nombre, donde $\tau$ representa un registro en la tabla.

### Concatenación de tuplas

Sea $t = (a_{1}, ... , a_{N})$ y $t' = (b_{1}, ... , b_{M})$ dos tuplas de tablas con esquemas $R$ y $S$ respectivamente. Definimos la concatenación de las tuplas $t$ y $t'$ como:

$(t; t') = (a_{1}, ... , a_{N}, b_{1}, ... , b_{M})$

## Operadores

Permiten hacer consultas a una base de datos.

### Proyección generalizada

$$\Pi_{A_1,...,A_n}(T) = map (T, \space \backslash t' → (t’.A_1, \space...,\space t’.A_n))$$
La proyección nos permite **obtener determinadas columnas de una tabla**, opcionalmente realizando algún cálculo sencillo.

Sean $r(R)$ y $f_{i} :: dom(R) → \tau_{i}$ con $i \in [1, N]$ se define la _proyección generalizada como:_
$$\prod_{f_{1}, ... f_{N}}(r) :: (c_{1}:: \tau_{1}, ..., c_{N}) $$
$$\prod*{f*{1}, ... f*{N}}(r) = \textbf{map}(\backslash t → (f*{1}t:: \tau*{1}, ..., f*{N}t)) r$$

Es habitual que queramos extraer una cierta columna de una tabla, con lo que daremos un nombre especial a estas funciones:

#### Proyector

Diremos que una función $f:: dom(R) → \tau_i$ es un _proyector_ si es de la forma $(\backslash t → t.columna)$, donde columna $:: \tau_i$ es una de las columnas de R. Diremos en este caso que $f$ _proyecta a columna b_

### Selección

Aplicar la selección a predicados.
Los predicados básicos se pueden combinar usando conectivos booleanos.
El conjunto de conectivos que consideramos es: $con \in \{ \&\&,  !!, not \}$

**Definición**
El operador de selección se define recursivamente como sigue:

$\sigma_{p}[\space] = [\space]$  
$\sigma_{p}(t:r) = \text{if } p(t) \text{ then } t: (\sigma_{p}r) \text{ else } \sigma_{p}r$

**Ejemplo:**
$$\sigma_{\text{ legajo } = \space p2 (\text{curso})}$$
Se agregan nomás las filas de la tabla_curso_que tengan legajo que cumplen el predicado_legajo = p2_.

### Producto cartesiano

Sean los esquemas:
$r:: (n_{1}:: \tau_{1}, ..., n_{N} :: \tau_N)$ y $s:: (n'_{1}:: \tau'_{1}, ..., n'_{M} :: \tau'_M)$

Entonces, el esquema del producto cartesiano es:

$$r \times s :: (n_{1}::\tau_{1}, ..., n_{N}:: \tau_{N}, n'_{1} :: \tau'_{1}, ..., n'_{M} :: \tau'_{M})$$

- Si hay conflictos de nombres de atributos se usa el nombre de la tabla para desambiguar. Si la tabla no tiene nombre, se usa $\_:T$.

```haskell
-- Producto cartesiano
[] x s = []
(t : r) x s = anexar s t (r x s)

-- Concatenación de tuplas ;
t  = (a1, ..., aN)
t' = (b1, ..., bM)

(t; t') = (a1, ..., aN, b1, ..., bM)

-- Anexar
anexar s t q = (map (\t' -> t; t') s) ++ q

```

### Reunión selectiva

Es la operación de combinar tablas por atributos. Como un inner join con _using_.
Por ejemplo:

$$\Pi_{\text{nombre, apellido, DNI}}(\text{persona}_{\text{DNI}} \bowtie_{\text{DNI}} \text{bibliotecario})$$
Es equivalente a

$$
\Pi_{\text{nombre, apellido, DNI}}
(\sigma_{\text{persona.DNI } = \text{bibliotecario.DNI}}(\text{persona} \times \text{bibliotecario}))
$$

La reunión selectiva se puede definir como:

$$
r_{a_{1},..., a_{i}} \bowtie _{b_{1}, ..., b_{i}} s =
\Pi_{n_{1}, ..., n_{N}, c_{1}, ..., c_{M-i} ( \sigma_{a_{1} = b_{1} \land ... \land a_{i} = b_{i}} \ (r \times s)} )
$$

#### Reunión natural

Se aplica reunión selectiva a todos los atributos con el mismo nombre en las dos tablas.

$$
r \bowtie s = r_{a_{1},..., a_{i}} \bowtie _{a_{1}, ..., a_{i}} s
$$

Donde ${a_{1},...,a_{i}}$ es la intersección entre los atributos de r y de m.

### Concatenación de tablas

Los esquemas de los operandos deben ser **compatibles** (mismo tipo).

```haskell
[] ++ s = s
(t:r) ++ s = t: (r ++ s)
```

### Resta

Los esquemas de las tablas deben ser compatibles (mismo tipo).
El esquema de la resta es el del primer operando.
$r \backslash s :: (n_{1}::\tau_{1}, ..., n_{N} :: \tau_{N})$  
$r \backslash s = \sigma_{(\backslash t → t \notin s)} (r)$

### Intersección

Los esquemas de las tablas deben ser compatibles (mismos tipos).

El esquema de la intersección es el del primer operando
$r \ \cap \ s :: (n_{1}:: \tau_{1}, ..., n_{N}:: \tau_N)$
$r \ \cap \ s = \sigma_{(t → t \in s)}(r)$

### Construcción de consultas complejas

- Usamos el operador **let**.
- Funciona como el **let ... in** de haskell

### Renombre

$$\rho_{\text{tabla'}(\text{atributo1, ..., atributoN})} (tabla)$$

### Remover duplicados

La operación de remoción de duplicados se define recursivamente de la siguiente manera:

```haskell
V [] = []
V (t:v) = if t ∊ r then V(r) else t : V(r)
```

### Ordenamiento

Especificamos ordenamiento como insertion sort.
La función `instert` inserta la tupla _t_ en la tabla _r_ en la posición que le corresponde: a la izquierda las tuplas menores y a la derecha las mayores.

$$\text{insert}_{a_{1}, ... a_{N}} \text{t r} = \sigma_{(a_{1}, ..., a_{N}) < t[a_{1}, ..., a_{N}]} ++ [t] ++ \sigma_{(a_{1}, ..., a_{N}) \ge t[a_{1}, ..., a_{N}](r)} $$

#### Ordenamiento ascendente

$O_{a_{1}, ..., a_{N}}([\ ]) = [\ ]$  
$O_{a_{1}, ..., a_{N}} = \text{insert}_{a_{1}, ..., a_{N}}(x, O_{a_{1}, ..., a_{N}}(R))$

#### Ordenamiento descendente

$O^{>}_{a_{1}, ..., a_{N}}(r) = \text{reverse}(O_{a_{1},...,a_{N}}(r))$

```haskell
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]
```

## Funciones de agregación

Son las siguientes funciones sobre listas:

```haskell
count :: [a] -> Integer        -- para contar la cantidad de elementos en la lista
sum :: Num a => [a] -> Integer -- para sumar los valores (deben ser numéricos)
avg :: Num a => [a] -> Float   -- para promediar los valores (deben ser numéricos)
min :: Ord a => [a] -> a       -- para obtener el mínimo valor en la lista
max :: Ord a => [a] -> a       -- para obtener el máximo valor en la lista
```

Una función de agregación se aplica a una lista de elementos y no a una lista de tuplas.

Definimos la agregación como:  
$\Upsilon_{f_1(a_1), ..., f_m(a_m)} (r) :: (\_:: τ'_1 ,..., \_ ::τ'_m)$  
$\Upsilon_{f_1(a_1), ..., f_m(a_m)} (r) = [ (f_1 (\text{map} (\backslash t → t.a_1 ) r), ..., f_m (\text{map} (\backslash t → t.a_m ) r)]$

Donde $f_i$ es función de agregación, o $f_i$ es de la forma: $(f ∘ v)$, para $f$ función de agregación (o sea, remover duplicados y luego aplicar la función de agregación).

Dada la tabla `instructor(ID, name, dept_name, salary)`, existe la notación: ${ }_\text{dept\_name} \Upsilon_{avg(\text{salary})} (\text{instructor})$ que denota el salario promedio de cada departamento (se agrupa por los valores iguales en dept_name)

## Relación entre SQL y Álgebra de Tablas

Las siguientes expresiones son equivalentes:

```SQL
SELECT A1, ..., An
FROM r1, ..., rn
WHERE P
```

$$\Pi_{A_{1},..., A_{n}}(\sigma_{p}(r_{1} \times ... \times r_{n}))$$
