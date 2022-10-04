# 🗃️ Bases de datos 🗃️

## 👨‍🏫️ Profes
**Laboratorio**
* Ramiro Demasi
* Sergio Canchi
* Juan Cabral
* Christian Cardellino
**Teórico**
+ Laura Alonso Alemany
+ Juan Durán
  
## 📆️ Generalidades
### **Parciales** 
| 💻️ Teórico/práctico: | 💻️ Laboratorio: |
| --- | --- |
| 04/10 | 14/10 | 
| 17/11 | 11/11 | 
| 24/11 recuperatorio | 25/11 recuperatorio | 

\* Los parciales del laboratorio son en la computadora, individuales a "libro abierto".

### Regularización y promoción
Se puede promocionar por separado.

**Teórico/práctico**  
* Regularizar: al menos 4 en ambos parciales
* Promocionar: notas de al menos 6 y promedio de 7 (no lineal)

**Laboratorio**
* Regularizar: Aprobar con 60% ambos parciales (4)
* Promocionar: ambos parciales con nota al menos 6 y promedio al menos 7 (80%)

## 📚️ Programa
Laboratorio: [[BasesDeDatos/base-de-datos/laboratorio/README]]
### **Introducción** [[1-introBD]] 
- [x] ¿Qué es una base de datos?
- [x] Aplicaciones de bases de datos
- [x] Esquemas y ejemplares
- [x] Modelos de los datos
- [x] Modelo relacional
- [x] Modelos de datos no relacionales
- [x] Lenguajes consulta
- [x] SQL
- [x] Álgebra relacional
- [x] Diseño de base de datos relacionales
- [x] Diseño de entidad-relación
- [x] Teoría de normalización
- [x] Traducción de diseño de Entidad-relación a tablas
- [x] Sistemas gestores de bases de datos
- [x] Arquitectura
- [x] Gestión del almacenamiento
- [x] Procesamiento de consultas
- [x] Transacciones
- [x] Planificaciones
- [x] Gestión de transacciones
- [x] Arquitectura de aplicaciones de bases de datos

### **Diseño de Entidad-Relación** [[2-diseñoE-R]]
- [x] Diagramas de entidad-relación
- [x] Entidades, atributos y conjuntos de entidades.
- [x] Superclaves, claves candidatas y claves primarias de conjuntos de entidades
- [x] Relaciones y conjuntos de relaciones
- [x] Clasificación de Atributos
- [x] Correspondencia de cardinalidades
- [x] Restricciones de participación
- [x] Notación de intervalos
- [x] Conjuntos de entidades débiles
- [x] Especialización y generalización
- [x] Restricciones de diseño sobre las generalizaciones.
- [x] Decisiones de diseño al construir un diagrama de entidad-relación.
- [ ] Estructura básica de las bases de datos relacionales
- [ ] Esquema de una base de datos relacional
- [x] Claves primarias
- [x] Claves foráneas
- [x] Reducción de un esquema de entidad-relación a tablas

### **Álgebra de tablas** [[4-algebra-de-tablas]]
- [x] Lenguajes de consulta
- [x] Álgebra relacional
- [x] Limitaciones del álgebra relacional
- [x] Álgebra de tablas
- [x] Listas y sus operaciones
- [x] Tablas y sus esquemas
- [x] Operadores: proyección generalizada, selección, producto cartesiano,
     reunión selectiva, reunión natural, renombramiento, concatenación,
     resta intersección, remoción de duplicados, agregación, agrupación,
     ordenamiento.
- [x] Definiciones locales
- [x] Consultas usando el álgebra de tablas
- [x] Propiedades de los operadores en el álgebra de tablas

### **SQL**
- [ ] Lenguaje de definición de datos: tipos de dominios en SQL, definición de
     esquemas en SQL
- [ ] Restricciones de los dominios en SQL
- [ ] Cláusulas select, from y where
- [ ] La operación de renombramiento
- [ ] Variables tupla
- [ ] Operaciones sobre Cadenas
- [ ] Operaciones sobre conjuntos
- [ ] Funciones de agregación
- [ ] Manejo de valores nulos
- [ ] Subconsultas anidadas
- [ ] Vistas
- [ ] Modificación de la base de datos
- [ ] Reunión de relaciones

### **Integridad y Seguridad** [[3-restricciones]] 
- [ ] Integridad referencial
- [ ] Integridad referencial en SQL
- [ ] Aserciones
- [ ] Aserciones en SQL
- [ ] Disparadores
- [ ] Disparadores en SQL
- [ ] Seguridad y autorización: medidas de seguridad en varios niveles,
     autorizaciones, concesión de privilegios, papeles
- [ ] Autorización en SQL: privilegios en SQL, papeles, el privilegio de conceder
     privilegios

### **Almacenamiento de Datos**
- [ ] Organización de archivos
- [ ] Organización de registros en archivos
- [ ] Almacenamiento del diccionario de datos
- [ ] Buffer de la base de datos 
- [ ] Índices
- [ ] Índices ordenados
- [ ] Índices árboles B+ y sus extensiones
- [ ] Definición de índices en SQL

**Procesamiento de consultas**
- [ ] Pasos en el procesamiento de consultas
- [ ] Cómo medir el costo de una consulta
- [ ] Costo de operadores: selección, ordenamiento, reunión natural, eliminación
     de duplicadoes, proyección, agregación, operaciones de conjuntos.
- [ ] Evaluación de expresiones de consulta
- [ ] Materialización
- [ ] Canalización

**Optimización de consultas**
- [ ] Planes de evaluación
- [ ] Transformación de expresiones relacionales
- [ ] Reglas de equivalencia.
- [ ] Optimización basada en transformación
- [ ] Optimización basada en costo
- [ ] Programación dinámica
- [ ] en optimización
- [ ] Optimización heurística
- [ ] Optimizadores de consulta

**MongoDB**
- [ ] Bases de datos NoSQL
- [ ] Categorías de bases de datos NoSQL
- [ ] Qué es MongoDB
- [ ] Bases de datos, colecciones y documentos
- [ ] Documentos BSON
- [ ] MongoDB Shell: Comandos 
- [ ] Operaciones CRUD en MongoDB
- [ ] Sintaxis típica de una consulta en MongoDB
- [ ] Operaciones InsertOne e InsertMany
- [ ] Operación Find
- [ ] Operadores de comparación
- [ ] Consultas en arreglos
- [ ] Consultas en documentos embebidos
- [ ] Operaciones updateOne y updateMany
- [ ] Operaciones deleteOne y deleteMany
- [ ] Operadores de consulta, de proyección y de actualización

**Asuntos avanzados de MongoDB**
- [ ] Pipeline de agregación $match, $project, $group, $lookup
- [ ] Modelado de distintos tipos de relaciones en MongoDB
- [ ] Creación de índices en MongoDB

**Dependencias Funcionales**
- [ ] Dependencias funcionales: conceptos básicos, cierre de un conjunto de
     dependencias funcionales, cierre de un conjunto de atributos, implicación
     lógica, deducción, teorema de completitud, recubrimiento canónico
- [ ] Descomposición
- [ ] Propiedades deseables de una descomposición: descomposición de reunión sin
     pérdida y preservación de las dependencias

** Se pueden encontrar más recursos en la página del libro Silberchertz.
