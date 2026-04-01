# Ejemplos prácticos de Git

Esta carpeta contiene **demostraciones reproducibles** y **guías** para escenarios habituales en equipos de desarrollo. Cada ejemplo vive en su propio subdirectorio e incluye:

Los ejemplos están numerados en orden de **progresión recomendada** para quienes están aprendiendo Git.

| # | Carpeta | Tema |
|---|---------|------|
| 01 | [`01-stash/`](01-stash/README.md) | Guardar trabajo temporal con `git stash` para cambiar de contexto |
| 02 | [`02-diff-avanzado/`](02-diff-avanzado/README.md) | Comparar ramas, commits y cambios a nivel de palabra con `git diff` avanzado |
| 03 | [`03-log-avanzado/`](03-log-avanzado/README.md) | Filtrar, buscar y formatear el historial con `git log` avanzado |
| 04 | [`04-merge-conflictos/`](04-merge-conflictos/README.md) | Crear, detectar y resolver conflictos de merge |
| 05 | [`05-blame/`](05-blame/README.md) | Identificar quién modificó cada línea de un archivo con `git blame` |
| 06 | [`06-reset/`](06-reset/README.md) | Diferencias entre `git reset --soft`, `--mixed` y `--hard` |
| 07 | [`07-revert/`](07-revert/README.md) | Deshacer un commit de forma segura con `git revert` sin reescribir historial |
| 08 | [`08-reflog/`](08-reflog/README.md) | Recuperar commits perdidos con `git reflog` |
| 09 | [`09-cherry-pick/`](09-cherry-pick/README.md) | Traer commits concretos de otra rama sin fusionar toda la rama |
| 10 | [`10-rebase-interactivo/`](10-rebase-interactivo/README.md) | Reordenar, fusionar o reescribir commits con `git rebase -i` |
| 11 | [`11-bisect/`](11-bisect/README.md) | Encontrar el commit que introdujo un error con `git bisect` |
| 12 | [`12-tag/`](12-tag/README.md) | Crear y gestionar etiquetas ligeras y anotadas con `git tag` |
| 13 | [`13-worktree/`](13-worktree/README.md) | Trabajar en múltiples ramas simultáneamente con `git worktree` |
| 14 | [`14-hooks-pre-commit/`](14-hooks-pre-commit/README.md) | Automatizar comprobaciones antes de cada commit (demo con marcadores de conflicto) |
| 15 | [`15-gitattributes/`](15-gitattributes/README.md) | Configurar fin de línea, archivos binarios y estrategias de merge con `.gitattributes` |
| 16 | [`16-github-actions/`](16-github-actions/README.md) | Ejemplo básico de CI con GitHub Actions |
| 17 | [`17-flujo-completo/`](17-flujo-completo/README.md) | Tutorial end-to-end: rama, commits, conflicto, merge y tag en un flujo real |

En la raíz del repositorio, la carpeta [`hooks/`](../hooks/README.md) reúne **plantillas** adicionales: formato de código, **Conventional Commits**, bloqueo de commits a `main`, **ejecución de pruebas antes de push** y **auto-inserción de ticket en mensajes de commit**.

## Cómo usar estos materiales

1. Sigue el orden numérico si estás aprendiendo Git desde cero.
2. Lee el `README.md` del ejemplo (contexto, objetivos y pasos).
3. Ejecuta el script de demostración desde esa carpeta (crea un repositorio temporal y no toca tu proyecto actual).
4. Revisa la sección **«Cómo documentar para otros desarrolladores»** en cada guía: sirve como plantilla mental para tus propios README o runbooks.

## Requisitos comunes

- Git instalado (`git --version`).
- Terminal (bash o zsh). Los scripts usan comandos portables entre macOS y Linux salvo donde se indique lo contrario.
