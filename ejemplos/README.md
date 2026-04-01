# Ejemplos prácticos de Git

Esta carpeta contiene **demostraciones reproducibles** y **guías** para escenarios habituales en equipos de desarrollo. Cada ejemplo vive en su propio subdirectorio e incluye:

| Carpeta | Tema |
|---------|------|
| [`bisect/`](bisect/README.md) | Encontrar el commit que introdujo un error con `git bisect` |
| [`blame/`](blame/README.md) | Identificar quién modificó cada línea de un archivo con `git blame` |
| [`cherry-pick/`](cherry-pick/README.md) | Traer commits concretos de otra rama sin fusionar toda la rama |
| [`diff-avanzado/`](diff-avanzado/README.md) | Comparar ramas, commits y cambios a nivel de palabra con `git diff` avanzado |
| [`flujo-completo/`](flujo-completo/README.md) | Tutorial end-to-end: rama, commits, conflicto, merge y tag en un flujo real |
| [`gitattributes/`](gitattributes/README.md) | Configurar fin de línea, archivos binarios y estrategias de merge con `.gitattributes` |
| [`github-actions/`](github-actions/README.md) | Ejemplo básico de CI con GitHub Actions |
| [`hooks-pre-commit/`](hooks-pre-commit/README.md) | Automatizar comprobaciones antes de cada commit (demo con marcadores de conflicto) |
| [`log-avanzado/`](log-avanzado/README.md) | Filtrar, buscar y formatear el historial con `git log` avanzado |
| [`merge-conflictos/`](merge-conflictos/README.md) | Crear, detectar y resolver conflictos de merge |
| [`rebase-interactivo/`](rebase-interactivo/README.md) | Reordenar, fusionar o reescribir commits con `git rebase -i` |
| [`reflog/`](reflog/README.md) | Recuperar commits perdidos con `git reflog` |
| [`reset/`](reset/README.md) | Diferencias entre `git reset --soft`, `--mixed` y `--hard` |
| [`revert/`](revert/README.md) | Deshacer un commit de forma segura con `git revert` sin reescribir historial |
| [`stash/`](stash/README.md) | Guardar trabajo temporal con `git stash` para cambiar de contexto |
| [`tag/`](tag/README.md) | Crear y gestionar etiquetas ligeras y anotadas con `git tag` |
| [`worktree/`](worktree/README.md) | Trabajar en múltiples ramas simultáneamente con `git worktree` |

En la raíz del repositorio, la carpeta [`hooks/`](../hooks/README.md) reúne **plantillas** adicionales: formato de código, **Conventional Commits**, bloqueo de commits a `main`, **ejecución de pruebas antes de push** y **auto-inserción de ticket en mensajes de commit**.

## Cómo usar estos materiales

1. Lee el `README.md` del ejemplo (contexto, objetivos y pasos).
2. Ejecuta el script de demostración desde esa carpeta (crea un repositorio temporal y no toca tu proyecto actual).
3. Revisa la sección **«Cómo documentar para otros desarrolladores»** en cada guía: sirve como plantilla mental para tus propios README o runbooks.

## Requisitos comunes

- Git instalado (`git --version`).
- Terminal (bash o zsh). Los scripts usan comandos portables entre macOS y Linux salvo donde se indique lo contrario.
