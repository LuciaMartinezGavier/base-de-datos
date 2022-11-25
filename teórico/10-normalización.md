# Normalización

Queremos **caracterizar** un esquema $R$ que no tiene redundancia de información proveniente de dependencias funcionales por medio de una propiedad.

Un esquema que cumple con dicha propiedad se dice que está en la **forma normal Boyce-Codd** (FNBC).

## Forma normal de Boyce Codd

Un **esquema** $R$ está en **forma normal de Boyce-Codd** con respecto a un conjunto $F$ de dependencias funcionales, si para **todas** las dependencias funcionales en $F⁺$ de la forma $\alpha → \beta$, donde $\alpha \subseteq R$ y $\beta \subseteq R$, **al menos una** de las siguientes propiedades se cumple:

+ $\alpha → \beta$ es trivial (es decir, $\beta \subseteq \alpha$)  
+ $\alpha$ es una superclave de $R$ (es decir, $\alpha → R \in F^+$)

Una **descomposición** $\{R_1, ..., R_n\}$ de $R$ está en **forma normal de Boyce-Codd** respecto de un conjunto de dependencias funcionales $F$ si y solo si cada $R_i$ está en forma normal BC con respecto a $F$.

### Comprobar que un esquema no está en FNBC

*¿Cómo comprobar que un esquema R con respecto a F no esta en forma normal Boyce Codd?*

Una dependencia funcional de $F⁺$ que no cumple la condición de FNBC se llama **violación** o **DF testigo**. Y es una dependencia funcional $\alpha → \beta$ no trivial en $F^+$ tal que $\alpha → R \notin F^+$

Para probar que R no está en FNBC con respecto a F basta con encontrar una DF testigo en F⁺.

### Comprobar que un esquema está en FNBC

Para comprobar si $R$ respecto de $F$ está en FNBC, donde los atributos de $F$ están contenidos en $R$, basta con chequear la condición de FNBC para las dependencias funcionales de $F$.

Por desgracia, lo anterior no funciona cuando una relación está descompuesta.

Sea $R_U$ universal, con dependencias funcionales $F$ y sea $R_i$ que forma parte de la descomposición de $R_U$, para probar que $R_i$ está en FNBC se puede hacer la siguiente comprobación
$$<\forall \alpha : \alpha \subseteq R_i : \alpha^+ \cap (R_i - \alpha) = \phi \lor R_i \subseteq \alpha^+>$$
En cada subconjunto de atributos $\alpha$ de $R_i$ hay que comprobar que $\alpha^+$, el cierre de los atributos de $\alpha$, no incluye ningún atributo de $R_i - \alpha$ o que incluye a todos los atributos de $R_i$.

Si un $\alpha \subseteq R_i$ viola la condición, entonces la siguiente dependencia funcional es testigo:
$$\alpha → \alpha^+ \cap (R_i - \alpha)$$

### Algoritmo de normalización en FNBC

```pseudocode
result := {R};
while (there is a schema Ri in result that is not in BCNF) 
begin
 let a → b DF testigo de Ri and a ∩ b = empty_set;
 result := (result – Ri ) U (Ri – b) U (a, b);
end
```
