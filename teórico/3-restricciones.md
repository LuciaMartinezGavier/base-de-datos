# Restricciones
**CONSTRAINTS**
Pueden ser estructurales o predicados.

## Restricciones sobre dominios
Valores que puede haber en una columna.
```SQL
create domain num_cuenta char(10)
constraint
comprobación_num_cuenta_nulo
check (value not null)
```
## Aserciones
```SQL
create assertion restriccion_suma check
	...
```
Chequea que la base de datos sea consistente siempre que se modifica

### Disparadores
`trigger`
Modelo evento-condición-acción.
1. Evento causa
2. Comprobación del disparador
3. Condición que se debe cumplir para ejecutar el disparador
4. Acciones que ejecuta el disparador.

Código que se ejecuta cuando ocurre un evento y se cumple una condición.
```SQL
create trigger descubierto after update on cuenta
referencing new row as nfila
for each row
when nfila.saldo < 0
bebin atomic
	...
```

### Seguridad 
De lectura, de escritura, de borrado...
Privilegios, autorizaciones, vistas
Cifrado y autenticación.