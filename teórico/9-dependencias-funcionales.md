# Dependencias Funcionales

## Diseño de Bases de Datos Relacionales

Para tener un **diseño de calidad** se debe:

+ Evitar problemas de **redundancia** de información
+ Evitar problemas de **comprensibilidad**
+ Evitar problemas de **incompletitud**
  + Restricciones de integridad incompletas
  + Relaciones entre atributos no contempladas por esquemas de BD
+ Evitar problemas de **ineficiencia**
  + Chequeo ineficiente de restricciones de integridad
  + Consultas ineficientes por tener un esquema inadecuado de BD

Para evitar tener que diseñar el diagrama Entidad-Relación, tener que decidir entre alternativas de diseño ER, tener que corregir problemas de calidad en diseños se aplica un algoritmo de **normalización**.

Para ello, se debe identificar

+ $K$: Conjunto de todos los atributos (átomicos, es decir, indivisibles) del problema actual
+ $I$: Conjunto de **Restricciones de integridad** (Se define a partir de K)

| | |
| - | - |
| Atributos del problema actual y restricciones de integridad | |
|↓||
| Algoritmo de Normalización | |
|↓||
| Esquema de BD Relacional de Calidad ||

## Esquema Universal

Dado el problema actual, el **esquema universal** consta de todos los atributos atómicos del mismo.

No conviene usar el esquema universal como diseño de una BD relacional porque en general tiene problemas de calidad, como **redundancia de información** y **manejo de valores nulos**.

La **teoría de normalización** estudia cómo descomponer esquemas universales para eliminar los problemas citados.

## Descomposiciones

Sea $R$ un esquema de relación. Un conjunto de esquemas de relación $R_1, ..., R_n$ es una **descomposición** de $R$ sii $$R = R_1 \cup ... \cup R_m$$
Arreglar problemas de diseño introduciendo esquemas para conceptos varios que **dependen de conocimiento del dominio** y que son una **descomposición del esquema universal**.

### Atributos redundantes

Si un atributo $a_1$ determina unívocamente los valores de otros atributos $a_n$ , ..., $a_{n+m}$ se indica de la forma $a_1 → a_n, ..., a_{n+m}$.

Y se puede usar $a_1$ para descomponer el esquema en
$E_1(a_1, ...)$
$E_2(a_1, a_n, ... , a_{n+m})$

Usualmente se puede ir descomponiendo el esquema universal para eliminar mucha de la redundancia de información en el mismo por medio del uso de dependencias funcionales.

Más aún, si tenemos las DF del problema, esto es automatizable (debido a la forma repetitiva de descomponer esquemas).

## Restricciones de integridad

Hay que definir las restricciones de integridad para el  **conjunto de tablas legales**.

Las **tablas legales** son tablas donde las tuplas tienen un cierto significado y cumplen con ciertas propiedades obligatorias.

Las **dependencias funcionales** requieren que para las tablas legales, el valor de un cierto conjunto de atributos determine unívocamente el valor de otro conjunto de atributos.

## Definición de dependencia funcional

Una **dependencia funcional** es un tipo de restricción que constituye una generalización del concepto de *clave*.

Considérese el esquema de una relación $R$ y sean $\alpha \subseteq R$ y $\beta \subseteq R$. La **dependencia funcional** $\alpha → \beta$ se cumple para el esquema R si, en cualquier relación legal $r(R)$, para todos los pares de tuplas $t_1$ y $t_2$ de $r$ tales que $t_1[\alpha] = t_2[\alpha]$, también ocurre que      $t_1[\beta] = t_2[\beta]$. Es decir,

$$ t_1[\alpha] = t_2[\alpha] \implies t_1[\beta] = t_2[\beta]$$

En general, si tengo un esquema con redundancia de información, hay una dependencia funcional con atributos a la derecha que **caracterizan la información redundante** y con atributos a la izquierda que **no determinan todos los atributos del esquema**.

### Dependencia funcional trivial

Se dice que algunas dependencias funcionales son **triviales** porque satisfaces todas las relaciones.
En general, una dependencia funcional de la forma $\alpha → \beta$ es **trivial** si $\beta \subseteq \alpha$.

Una dependencia funcional **trivial** se cumple en todas las tablas de un esquema.

## Derivación de dependencias funcionales

No es necesario dar todas las dependencias funcionales que se cumplen en un problema del mundo real sino un **subconjunto** de ellas lo **menor posible** tal que todas las demás DF se puedan **derivar** de ese subconjunto.

Dado un esquema relacional R una dependencia funcional $f$ con atributos es $R$ **se deduce** de un conjunto de dependencias funcionales $F$ con atributos en $R$ si existe una lista de dependencias funcionales $f_1, ..., f_n$ tales que $f_n = f$ y para todo $1 \le i \le n$:

1. $f_i \in F$ ó
2. $f_i$ se obtiene por aplicar reflexibidad
3. $f_i$ se obtiene por aplicar aumentitividad ó transitividad a pasos anteriores

Usamos $F ⊢ f$    para decir que $f$ se deduce de $F$.

### Axiomas de Armstrong

Conjunto de reglas de inferencia para derivar dependencias funcionales
Se utilizan las letras griegas para los conjuntos de atributos.

+ **Reflexividad:** if $\beta \subseteq \alpha,$ then $\alpha → \beta$
+ **Aumentatividad:** if $\alpha → \beta$, then $\gamma \alpha → \gamma\beta$
+ **Transitividad** if $\alpha → \beta$, and $\beta → \gamma$, then $\alpha → \gamma$

Los axiomas de Armstrong son **correctos** porque no generan dependencias funcionales incorrectas, y son **completos** porque para un conjunto dado $F$ de dependencias funcionales, permiten generar todo $F⁺$.

### Más reglas

Se pueden inferir a partir de los axiomas de Armstrong.

+ **Unión:** if $\alpha → \beta$  and $\alpha → \gamma$ , then $\alpha → \beta \gamma$
+ **Descomposición:** if $\alpha → \beta \gamma$, then $\alpha → \beta$ and $\alpha → \gamma$
+ **Pseudotransitividad:** if $\alpha → \beta$ and $\gamma \beta → \delta$, then $\alpha \gamma → \delta$

### Cierre de conjunto de dependencias funcionales

El cierre de conjunto de dependencias funcionales de $F$, $\textbf{F⁺}$ son todas las dependencias que se deducen de $F$.

En la práctica hay cientos de atributos en un esquema universal y no es viable calcular $F⁺$.

Si tenemos un conjunto $F$ de dependencias funcionales y queremos saber si $\alpha → \beta$ está en $F$. Para ello, calculamos las dependencias de $F⁺$ con lado izquierdo $\alpha$.

Es decir, para responder si $F ⊨ \alpha → \beta$, bastaría contestar:
%%
α → β ∈ {α → φ | F ⊨ α → φ } o mejor contestar:
β ∈ {φ | F ⊨ α → φ } o mejor contestar:
%%
$$\beta \subseteq \{A \in R\space|\space F ⊨ \alpha → A\}$$

Llegamos así a un conjunto conocido como **cierre de un conjunto de atributos** (derecha de la inclusión).

#### Cierre de $\alpha$ bajo F

El **cierre de $\alpha$ bajo $F$** se define como
$$\alpha_F^{+} = \{A \in R\space|\space F ⊢ \alpha → A\}$$
donde $R$ es el **esquema universal** y $F$ un conjunto de dependencias funcionales con atributos en el esquema universal.

#### Superclave

Sea $R$ esquema relacional y $F$ es conjunto de dependencias funcionales, entonces $\alpha$ es **superclave** de $R$ si y solo si $\alpha → R$ está en $F⁺$

#### Clave candidata

$\alpha$ es **clave candidata** de R si y solo si:

1. $\alpha$ es superclave de $R$
2. Para todo $A$ en $\alpha$, $\alpha - {A}$ no es superclave de R
