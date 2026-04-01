# Buenos y malos mensajes de commit

## Por que importa el mensaje de commit

El mensaje de commit es la forma principal de comunicar al equipo (y a tu yo del futuro) **que se cambio y por que**. Un historial con mensajes claros permite:

- Entender la evolucion del proyecto sin leer cada diff.
- Localizar rapidamente cuando y por que se introdujo un cambio.
- Generar changelogs de forma automatica.
- Facilitar revisiones de codigo, bisects y reverts.

Un mal mensaje obliga a quien investiga a abrir el diff, interpretar los cambios y adivinar la intencion. Eso multiplica el esfuerzo de mantenimiento.

## Estructura recomendada

```
tipo(alcance): descripcion breve en imperativo

Cuerpo opcional: explica el "por que" del cambio, contexto relevante
o decisiones de diseno. Separa del titulo con una linea en blanco.
Puede tener varios parrafos.

Footer opcional:
Refs: #123
BREAKING CHANGE: descripcion del cambio que rompe compatibilidad
Co-authored-by: Nombre <correo@ejemplo.com>
```

**Reglas del titulo (primera linea):**

- Maximo ~50 caracteres (72 como limite duro).
- Empieza con un tipo (`feat`, `fix`, `docs`, etc.) seguido de dos puntos.
- Usa el imperativo: "Agregar", "Corregir", "Eliminar" (no "Agregado", "Se corrigio").
- No termina en punto.

**Reglas del cuerpo:**

- Separado del titulo por una linea en blanco.
- Cada linea de maximo 72 caracteres.
- Explica el **por que**, no el **que** (el diff ya muestra el que).

## Ejemplos de buenos mensajes

| Mensaje | Por que es bueno |
|---------|------------------|
| `feat(auth): agregar inicio de sesion con Google OAuth` | Indica tipo, alcance y describe la funcionalidad nueva |
| `fix(api): corregir timeout en endpoint /usuarios` | Tipo claro, alcance especifico, problema identificable |
| `docs: actualizar instrucciones de instalacion en README` | Cambio de documentacion bien descrito |
| `refactor(carrito): extraer logica de descuentos a un servicio` | Explica que se reorganizo y donde |
| `test(pagos): agregar pruebas unitarias para calcular impuestos` | Especifica que se agrego y en que modulo |
| `fix: evitar division por cero al calcular promedios vacios` | Describe el bug que se corrige con precision |
| `chore: actualizar dependencias de desarrollo a ultimas versiones` | Tarea de mantenimiento bien descrita |
| `perf(consultas): agregar indice en tabla de pedidos por fecha` | Tipo, alcance y mejora concreta |

## Ejemplos de malos mensajes

| Mensaje | Que tiene de malo |
|---------|-------------------|
| `cambios` | No dice que se cambio ni por que |
| `fix` | No describe que se corrigio |
| `WIP` | No deberia commitearse trabajo sin terminar con ese mensaje |
| `asdfg` | Sin significado alguno |
| `actualizar archivo` | No dice cual archivo ni que se actualizo |
| `ya funciona` | No describe que funciona ni que se hizo para lograrlo |
| `commit final` | No indica el contenido del cambio |
| `Cambios varios en el proyecto` | Demasiado vago; probablemente el commit es muy grande |
| `Se arreglo el bug que habia` | No dice cual bug; usa pasado en vez de imperativo |
| `Agregado nuevo archivo` | No dice cual archivo ni para que sirve |
| `hjkl1234` | Texto sin sentido, imposible de buscar |
| `.` | Un solo caracter no comunica nada |
| `save` | No es un mensaje de commit, es una accion de editor |
| `mas cambios` | Implica que los commits anteriores tampoco fueron descriptivos |

## Conventional Commits (resumen)

[Conventional Commits](https://www.conventionalcommits.org/) es una convencion que estandariza el formato del mensaje de commit. Su estructura basica es:

```
<tipo>[alcance opcional][!]: <descripcion>
```

**Tipos mas comunes:**

| Tipo | Uso |
|------|-----|
| `feat` | Nueva funcionalidad |
| `fix` | Correccion de un bug |
| `docs` | Solo cambios en documentacion |
| `style` | Formato, punto y coma faltante, etc. (sin cambio de logica) |
| `refactor` | Cambio de codigo que no agrega funcionalidad ni corrige bugs |
| `perf` | Mejora de rendimiento |
| `test` | Agregar o corregir pruebas |
| `chore` | Tareas de mantenimiento (dependencias, configuracion, etc.) |
| `ci` | Cambios en la configuracion de integracion continua |
| `build` | Cambios en el sistema de build o dependencias externas |
| `revert` | Reversion de un commit anterior |

El signo `!` antes de los dos puntos indica un cambio que **rompe compatibilidad** (breaking change):

```
feat(api)!: cambiar formato de respuesta de /usuarios a JSON:API
```

Este repositorio incluye un hook de Git que valida automaticamente que los mensajes sigan esta convencion. Consulta [`hooks/README.md`](hooks/README.md) para ver como instalarlo y configurarlo.

## Referencias

- [Conventional Commits v1.0.0](https://www.conventionalcommits.org/es/v1.0.0/)
- [How to Write a Git Commit Message - Chris Beams](https://cbea.ms/git-commit/)
- [Angular Commit Message Guidelines](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format)
- [Hooks de Git de este repositorio](hooks/README.md)
