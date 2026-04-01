# Reset (`git reset`)

## Propósito

Entender los **tres modos** de `git reset` (`--soft`, `--mixed`, `--hard`) y cuándo usar cada uno para deshacer commits de forma controlada sin perder trabajo innecesariamente.

## Para quién es esta guía

Personas que necesitan **deshacer commits de forma segura** y quieren saber qué ocurre con los cambios en cada modo: si permanecen en el *staging area*, en el directorio de trabajo o se eliminan por completo.

## Prerrequisitos

- Entender qué es un **commit** y cómo funciona el **área de staging** (`git add` / `git status`).
- Saber leer `git log --oneline` para identificar commits.
- Conocer la diferencia entre cambios *staged* (listos para commit) y *unstaged* (modificados pero no añadidos).

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Distinguir qué hace cada modo de reset: `--soft` (mueve HEAD, cambios quedan *staged*), `--mixed` (mueve HEAD, cambios quedan *unstaged*) y `--hard` (mueve HEAD, cambios se **eliminan**).
2. Elegir el modo correcto según la situación: reescribir el mensaje de un commit (`--soft`), reorganizar cambios antes de un nuevo commit (`--mixed`) o descartar trabajo por completo (`--hard`).
3. Conocer las herramientas de recuperación (`git reflog`) y las diferencias entre `reset` y `revert` para tomar decisiones informadas.

## Escenario

Tres commits consecutivos en `main` donde `app.txt` evoluciona de la versión 1 a la versión 3. Se demuestra cada modo de reset retrocediendo un commit y observando el estado del repositorio antes y después:

1. **`--soft`**: el commit desaparece del historial, pero los cambios quedan en el *staging area* listos para un nuevo commit.
2. **`--mixed`** (modo por defecto): el commit desaparece y los cambios quedan en el directorio de trabajo como *unstaged*.
3. **`--hard`**: el commit y los cambios desaparecen por completo del directorio de trabajo.

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-reset/` con el historial descrito y se ejecutan los tres modos de reset mostrando `git log`, `git status` y el contenido del archivo en cada paso.

## Pasos manuales (para repetir o enseñar)

1. Crea un repo de prueba con tres commits secuenciales.
2. **`--soft`**:
   - `git reset --soft HEAD~1`
   - `git status` — verás los cambios del tercer commit como *staged*.
   - `git log --oneline` — solo dos commits.
   - `cat app.txt` — el contenido sigue siendo el de la versión 3.
   - Vuelve a hacer commit para restaurar el estado.
3. **`--mixed`**:
   - `git reset HEAD~1` (equivale a `git reset --mixed HEAD~1`)
   - `git status` — verás los cambios como *unstaged* (modificados, no añadidos).
   - `git log --oneline` — solo dos commits.
   - `cat app.txt` — el contenido sigue siendo el de la versión 3.
   - `git add` + commit para restaurar.
4. **`--hard`**:
   - `git reset --hard HEAD~1`
   - `git status` — limpio, sin cambios pendientes.
   - `git log --oneline` — solo dos commits.
   - `cat app.txt` — el contenido de la versión 3 **ha desaparecido**.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| `reset` vs `revert` | `reset` **reescribe** el historial (mueve HEAD hacia atrás); `revert` **crea un nuevo commit** que deshace los cambios sin alterar el historial existente. En ramas compartidas, `revert` es más seguro. |
| `--hard` y pérdida de datos | `--hard` elimina los cambios del directorio de trabajo. Si no hiciste commit ni stash, esos cambios **se pierden**. Úsalo solo cuando estés seguro de que quieres descartar todo. |
| `reflog` como red de seguridad | `git reflog` registra todos los movimientos de HEAD. Si hiciste `reset --hard` por error, puedes recuperar el commit con `git reset --hard <hash_del_reflog>` dentro de los primeros ~90 días. |
| Reset en ramas compartidas | Nunca hagas `reset` en commits que ya fueron publicados con `push`. Reescribir historial compartido causa conflictos para todo el equipo; usa `revert` en su lugar. |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Indica siempre el modo de reset** que estás usando y por qué lo elegiste sobre los otros dos.
- **Documenta el estado esperado** después del reset: qué debería mostrar `git status`, `git log` y el contenido de los archivos afectados.
- **Incluye el plan de recuperación**: `git reflog` + `git reset --hard <hash>` para deshacer un reset accidental.
- **Advierte sobre ramas compartidas**: si el equipo trabaja sobre la misma rama, documenta que `revert` es la alternativa segura.

### Ejemplo de sección "Verificación"

```text
git log --oneline          # debe mostrar N commits (según el reset aplicado)
git status                 # debe mostrar el estado esperado (staged, unstaged o limpio)
cat app.txt                # verificar el contenido del archivo
```

## Ver también

- [Reflog](../08-reflog/README.md) — recuperar commits perdidos tras un reset.
- [Revert](../07-revert/README.md) — deshacer commits sin reescribir historial.
- [Stash](../01-stash/README.md) — guardar cambios temporalmente.

## Referencias

- [git reset](https://git-scm.com/docs/git-reset)
- Pro Git: [Herramientas de Git — Reset desmitificado](https://git-scm.com/book/es/v2/Herramientas-de-Git-Reiniciar-Desmitificado)
- [git reflog](https://git-scm.com/docs/git-reflog)
