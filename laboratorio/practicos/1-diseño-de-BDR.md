contrato# Práctico I
## Diseño de Bases de Datos Relacionales


1. Listar los datos de los clientes suscriptos al plan PREMIUM con una determinada fecha de subscripción.

Cliente
- Nombre
- Apellido
- Correo electrónico
- Contraseña
 |
↓ tiene una subscripcion 1...1
- Subscripción
	- Plan: PREMIUM
	- Fecha de subscripción


2. Listar los datos de las películas donde el actor 'X' fue protagonista
Relación de mucho a muchos

| Pelicula  | 1.. \* ←→ | contrato |   ←→ \*.. 1 |  Actor |
| ------- | ---| ----| ---| ---| 
		| titulo | | rol (actor/director/..) || nombre |
| descipcion  | |  sueldo | | apellido |
| duracion     | | etc |  | fecha de nacimiento |
	| fecha          ||  **IDpelicula** pk | | sexo | 
| generos      ||   **IDActor** pk| |sitio web |

3. Listar los episodios correspondientes a un programa de televisión X y un número de temporada N. Listar ordenados por fecha de lanzamiento

Programa de television
- Título
- Descripcion
- genero
↓ tiene temporadas (1..\*) ↓↓ tiene contratos (1..\*)  (puede ser el mismo que de peli) ↓↓↓ tiene reviews
Temporadas
- Numero de temporada
- año de temporada
↓ tiene episodios
Episodios
- Título
- descripcion
- duracion
- fecha de lanzamiento

4. listar los reviews hechos por un cliente X dentro de un rango de fechas

review
- cliente
- titulo
- descripcion
- fecha
- calificacion

5.  Dada una pelicula X, calcular su "calificacion promedio" listo
6. Listar las películas por dos o más directoras femeninas

![Base de datos](Diagram-practico1.png)