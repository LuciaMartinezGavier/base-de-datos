# Recuperación de información

La recuperación de información es el conjunto de actividades orientadas a facilitar la **localización** de determinados datos u objetos, y las interrelaciones que estos tienen a su vez con otros.

El proceso de recuperación se lleva a cabo mediante consultas a la base de datos donde se almacena la información estructurada, mediante un lenguaje de interrogación adecuado.

Es necesario tener en cuenta los elementos clave que permiten hacer la búsqueda, determinando un mayor grado de pertinencia y precisión, como son: los índices, palabras clave, tesauros y los fenómenos que se pueden dar en el proceso como son el ruido y silencio documental.

Uno de los problemas que surgen en la búsqueda de información es si lo que recuperamos es «mucho o poco» es decir, dependiendo del tipo de búsqueda se pueden recuperar multitud de documentos o simplemente un número muy reducido. A este fenómeno se denomina Silencio o Ruido documental.

- **Silencio documental**: Son aquellos documentos almacenados en la base de datos pero que no han sido recuperados, debido a que la estrategia de búsqueda ha sido demasiado específica o que las palabras clave utilizadas no son las adecuadas para definir la búsqueda.
- **Ruido documental**: Son aquellos documentos recuperados por el sistema pero que no son relevantes. Esto suele ocurrir cuando la estrategia de búsqueda se ha definido demasiado genérica.

![figura](https://lh5.googleusercontent.com/KiE8llRIWJKl5pu9fJAKE_SdD4HA5u9XPHo6IyWGM3Zrmw2OBcbXXuiJ21WpUpSKH3kjGV48adLOCFcRPJmHGI5MyT3U4pQjJDvA7kwVvPHiRlwsYMLbWzqRh1gVbq8wRE-r-W4FNBpATw2vA1ojOVqNRgMOPiTWqcGLZGfYWJm76jMmmWD5r88krmXHbFc)

## Métricas

### Precisión

La precisión es la fracción de documentos recuperados que son relevantes para la necesidad de información del usuario.

$$Precisión = {| documentos\_relevantes  \cap documentos\_recuperados |\over documentos\_recuperados} $$

### Exhaustividad

La exhaustividad es la fracción de documentos relevantes para una consulta que fueron recuperados.

$$Exhaustividad = {\{documentos\_relevantes\} \cap \{documentos\_recuperados\} \over \{documentos\_relevantes\}}$$

### Balance de precisión y exhaustividad

 $$F_1 = 2 \times {Presición \times Exhaustividad \over Precisión + Exhaustividad}$$

## Tipos de modelos

Para recuperar efectivamente los documentos relevantes por estrategias de recuperación de información, los documentos son transformados en una representación lógica de los mismos.

Cada estrategia de recuperación incorpora un modelo específico para sus propósitos de representación de los documentos.

![tipos de modelos](https://lh4.googleusercontent.com/tv9k2_FlpMMQDCCU2Z2gu95prtpBO2wAIV8nOLZUJutSHRP_Yyw321r-ExMviraAwccpzjcnbDDkFv0f5lGKIyKM0YqwQY3b7DtxmwA9dL5xSxFsO_GTY7UWFfbtnyBvy9VwMnzG9FTiZ55NQO1mpKEAvLGBymiaSugoDX8ehjwDGVMwBeUyxW7t1J59Sm0)

- **Modelos basados en conjuntos:** "Tiene la palabra X y Y pero no Z" recuperar todos los documentos que cumplen un predicado, basado en conjuntos. Es muy ineficiente porque se necesita una gran cantidad de datos asociados a cada documento (más atributos). En la actualidad hay más poder de cómputo entonces se permite leer todo el documento para encontrar, por ejemplo, la palabra X.
- **Modelos Algebraicos**: En estos modelos los documentos y las consultas se representas como **vectores**, matrices o tuplas. La **semejanza** entre un documento y una consulta se representa por un escalar. Se puede consultar
  - La palabra está en el documento?
  - \#veces que ocurre una palabra?
  - Probabilidad de ocurrencia de una palabra
  - Información mutua: if\*idf
    - Frecuencia de una palabra en el documento dada la frecuencia de una palabra en toda la colección
  - No funcionaba muy bien: Muchos resultados no relevantes, no se consideran aspectos sociales.
  - Google después generó una red de *prestigio*, las páginas generan links entre ellas y con esto se genera un grafo. Luego se usan caminatas aleatorias y se va sumando "prestigio" cada vez que se pasa por un nodo.
- **Semántica latente**
  - Estocaisto (no determinístico): es un algoritmo exacto que usa randomización para aproximar los resultados y disminuir el costo
  - Se aplica descomposición de documentos
