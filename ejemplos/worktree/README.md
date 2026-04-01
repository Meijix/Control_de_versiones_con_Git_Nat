# Worktree (`git worktree`)

## Propósito

Trabajar en **múltiples ramas simultáneamente** sin necesidad de `stash` ni commits temporales, creando **directorios de trabajo adicionales** vinculados al mismo repositorio. Cada worktree tiene su propio working tree y HEAD, pero comparten el mismo almacén de objetos (`.git`).

## Para quién es esta guía

Desarrolladores que cambian de rama con frecuencia (por ejemplo, hotfixes urgentes mientras trabajan en una feature) y quieren **evitar interrupciones** como guardar trabajo parcial con `stash` o crear commits WIP innecesarios.

## Prerrequisitos

- Git 2.5+ (worktree se introdujo en esa versión; Git 2.17+ recomendado por mejoras en `worktree list` y `remove`).
- Entender qué es una rama y cómo funciona `checkout` / `switch`.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)). Los comandos de rutas con `/` y `cd` funcionan en Git Bash; PowerShell o CMD pueden dar errores.

## Objetivos de aprendizaje

1. Crear un worktree adicional con `git worktree add <ruta> <rama>` para trabajar en otra rama sin abandonar la actual.
2. Listar los worktrees activos con `git worktree list` para visualizar dónde está cada rama.
3. Eliminar un worktree con `git worktree remove <ruta>` cuando ya no se necesite, manteniendo el repositorio limpio.

## Escenario

Estás desarrollando en la rama `feature/dashboard` y recibes aviso de un bug crítico en `main` que necesita un hotfix inmediato. En lugar de hacer `stash` de tu trabajo en progreso (arriesgando perder contexto) o crear un commit temporal, creas un **worktree aparte** vinculado a `main`, aplicas el fix ahí, y vuelves a tu feature sin haber tocado nada.

```
    main:               A (README)
                         \
    feature/dashboard:    B (dashboard.txt) ← estás trabajando aquí

    Con worktree:

    ./repo/                  → feature/dashboard (tu trabajo intacto)
    ./repo-hotfix/           → main (directorio separado para el fix)
```

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crean dos directorios: `_demo-worktree/` (repositorio principal en `feature/dashboard`) y `_demo-worktree-hotfix/` (worktree adicional en `main`). El script demuestra el flujo completo: crear worktree, hacer el fix, volver y limpiar.

## Pasos manuales (para repetir o enseñar)

1. Desde tu repositorio, en la rama de tu feature:
   ```bash
   git worktree add ../ruta-del-worktree main
   ```
2. Listar worktrees activos:
   ```bash
   git worktree list
   ```
3. Ir al worktree, hacer cambios y commitear:
   ```bash
   cd ../ruta-del-worktree
   # editar, git add, git commit
   ```
4. Volver al repositorio principal:
   ```bash
   cd ../repo-original
   ```
5. Eliminar el worktree cuando ya no lo necesites:
   ```bash
   git worktree remove ../ruta-del-worktree
   ```
6. Verificar que solo queda el worktree principal:
   ```bash
   git worktree list
   ```

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Worktree vs stash | `stash` guarda cambios temporalmente y los restaura después; worktree mantiene **ambos directorios abiertos al mismo tiempo**, cada uno con su rama. No necesitas recordar hacer `stash pop`. |
| No se puede repetir rama | No puedes tener la **misma rama** checked out en dos worktrees a la vez. Git lo impide para evitar conflictos de estado. |
| Worktree es un enlace, no un clon | El worktree adicional **no es una copia** del repositorio; comparte objetos, refs y configuración con el repo original. Los commits hechos en un worktree son visibles desde el otro. |
| Limpieza con `remove` | Siempre usa `git worktree remove` en lugar de borrar la carpeta a mano. Si borras la carpeta directamente, ejecuta `git worktree prune` para limpiar las referencias huérfanas. |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Documenta la convención de rutas**: dónde crear los worktrees (por ejemplo, siempre como hermanos del repo: `../repo-hotfix`).
- **Aclara qué se comparte y qué no**: objetos y refs sí; `.gitignore` y archivos sin rastrear en el working tree no se replican automáticamente.
- **Incluye el paso de limpieza**: `git worktree remove` o `git worktree prune` para evitar acumulación de directorios huérfanos.

### Ejemplo de sección "Verificación"

```text
git worktree list          # debe mostrar solo el worktree principal
ls ../ruta-del-worktree    # no debe existir tras el remove
```

## Ver también

- [Stash (`git stash`)](../stash/) — alternativa para guardar trabajo temporal sin crear worktrees.
- [Reset (`git reset`)](../reset/) — deshacer cambios en el historial o el staging area.

## Referencias

- [git worktree](https://git-scm.com/docs/git-worktree)
- Pro Git: [Herramientas de Git](https://git-scm.com/book/es/v2/Herramientas-de-Git-Herramientas-de-Reparaci%C3%B3n)
