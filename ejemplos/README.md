# Ejemplos prácticos de Git

Esta carpeta contiene **demostraciones reproducibles** y **guías** para escenarios habituales en equipos de desarrollo. Cada ejemplo vive en su propio subdirectorio e incluye:

| Carpeta | Tema |
|---------|------|
| [`rebase-interactivo/`](rebase-interactivo/README.md) | Reordenar, fusionar o reescribir commits con `git rebase -i` |
| [`cherry-pick/`](cherry-pick/README.md) | Traer commits concretos de otra rama sin fusionar toda la rama |
| [`hooks-pre-commit/`](hooks-pre-commit/README.md) | Automatizar comprobaciones antes de cada commit (demo con marcadores de conflicto) |
| [`merge-conflictos/`](merge-conflictos/README.md) | Crear, detectar y resolver conflictos de merge |
| [`stash/`](stash/README.md) | Guardar trabajo temporal con `git stash` para cambiar de contexto |
| [`reset/`](reset/README.md) | Diferencias entre `git reset --soft`, `--mixed` y `--hard` |
| [`bisect/`](bisect/README.md) | Encontrar el commit que introdujo un error con `git bisect` |
| [`reflog/`](reflog/README.md) | Recuperar commits perdidos con `git reflog` |
| [`github-actions/`](github-actions/README.md) | Ejemplo básico de CI con GitHub Actions |

En la raíz del repositorio, la carpeta [`hooks/`](../hooks/README.md) reúne **plantillas** adicionales: formato de código, **Conventional Commits**, bloqueo de commits a `main`, **ejecución de pruebas antes de push** y **auto-inserción de ticket en mensajes de commit**.

## Cómo usar estos materiales

1. Lee el `README.md` del ejemplo (contexto, objetivos y pasos).
2. Ejecuta el script de demostración desde esa carpeta (crea un repositorio temporal y no toca tu proyecto actual).
3. Revisa la sección **«Cómo documentar para otros desarrolladores»** en cada guía: sirve como plantilla mental para tus propios README o runbooks.

## Requisitos comunes

- Git instalado (`git --version`).
- Terminal (bash o zsh). Los scripts usan comandos portables entre macOS y Linux salvo donde se indique lo contrario.
