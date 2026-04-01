# Ejemplos prácticos de Git

Esta carpeta contiene **demostraciones reproducibles** y **guías** para escenarios habituales en equipos de desarrollo. Cada ejemplo vive en su propio subdirectorio e incluye:

| Carpeta | Tema |
|---------|------|
| [`rebase-interactivo/`](rebase-interactivo/README.md) | Reordenar, fusionar o reescribir commits con `git rebase -i` |
| [`cherry-pick/`](cherry-pick/README.md) | Traer commits concretos de otra rama sin fusionar toda la rama |
| [`hooks-pre-commit/`](hooks-pre-commit/README.md) | Automatizar comprobaciones antes de cada commit (demo con marcadores de conflicto) |

En la raíz del repositorio, la carpeta [`hooks/`](../hooks/README.md) reúne **plantillas** adicionales: formato de código (`git diff --check` y ejemplos comentados), **Conventional Commits** (hook `commit-msg`) y bloqueo de commits a `main`.

## Cómo usar estos materiales

1. Lee el `README.md` del ejemplo (contexto, objetivos y pasos).
2. Ejecuta el script de demostración desde esa carpeta (crea un repositorio temporal y no toca tu proyecto actual).
3. Revisa la sección **«Cómo documentar para otros desarrolladores»** en cada guía: sirve como plantilla mental para tus propios README o runbooks.

## Requisitos comunes

- Git instalado (`git --version`).
- Terminal (bash o zsh). Los scripts usan comandos portables entre macOS y Linux salvo donde se indique lo contrario.
