# Hooks de Git: `pre-commit`

## Propósito

Los **hooks** son scripts que Git ejecuta en eventos concretos (antes del commit, antes del push, etc.). El hook **`pre-commit`** se usa para **validaciones automáticas**: estilo, pruebas rápidas, secretos, marcadores de conflicto, etc.

## Para quién es esta guía

Desarrolladores que quieren **automatizar comprobaciones locales** sin depender solo de CI, y **documentar** cómo instalar el mismo comportamiento en el equipo.

## Prerrequisitos

- Permisos de ejecución en scripts (`chmod +x`).
- Saber que `.git/hooks/` **no se versiona** por defecto; para compartir hooks entre el equipo existen `core.hooksPath`, herramientas como [pre-commit](https://pre-commit.com/) o copiar scripts en el repo e instalarlos con un script o tarea de build.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)). Los comandos `grep`, `chmod` y rutas con `/` funcionan en Git Bash; PowerShell o CMD pueden dar errores.

## Objetivos de aprendizaje

1. Ubicar e instalar un hook `pre-commit` en un repositorio.
2. Entender que el hook debe salir con código **0** (éxito) o **≠ 0** (abortar el commit).
3. Diseñar documentación para que otros sepan **cómo activar** el hook en un clon nuevo.

## Escenario

Un archivo entra al staging con **marcadores de conflicto** (`<<<<<<<`) por un merge mal resuelto. El hook **impide** crear el commit hasta que se corrija, reduciendo errores en el historial.

Archivos en esta carpeta:

| Archivo | Rol |
|---------|-----|
| `pre-commit.sample` | Script de ejemplo (comprueba marcadores en *staged* files). |
| `install-hook.sh` | Copia el sample a `.git/hooks/pre-commit` y marca ejecutable. |
| `demo-setup.sh` | Crea un repo bajo `_demo-hooks-precommit/`, instala el hook y muestra fallo y éxito. |

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Verás un commit rechazado y otro aceptado.

## Instalación manual en cualquier repo

Desde la raíz de un clon:

```bash
bash install-hook.sh
```

O copia `pre-commit.sample` a `.git/hooks/pre-commit` y ejecuta `chmod +x .git/hooks/pre-commit`.

## Compartir hooks con el equipo (opciones)

1. **`git config core.hooksPath .githooks`** — carpeta `.githooks/` **dentro del repo** versionada; todos ejecutan `git config` una vez (documentarlo en el README del proyecto).
2. **Script `bootstrap.sh`** — clona, entra y configura hooks + dependencias.
3. **Herramienta externa** — frameworks que gestionan versiones y entornos virtuales (útil si los checks son pesados).

## Qué documentar para otros desarrolladores

1. **Qué comprobaciones hace** el hook (lista breve).
2. **Cómo instalarlo** en un clone limpio (comando único si es posible).
3. **Cómo saltárselo en emergencia** (con advertencia): `git commit --no-verify` — solo para casos excepcionales y con revisión posterior.
4. **Cómo depurar** si falla: el hook imprime a `stderr`; reproduce con los mismos archivos staged.
5. **Compatibilidad**: macOS/Linux (por ejemplo `grep`, `xargs`).

### Plantilla README para un hook interno

```markdown
## Pre-commit de <proyecto>
### Qué valida
### Instalación
### Desactivar temporalmente (--no-verify)
### Añadir una nueva regla
```

## Errores frecuentes

| Problema | Qué hacer |
|----------|-----------|
| `git grep` en el hook “no ve” el índice | En `git grep`, las opciones como `--cached` deben ir **antes** del patrón; si no, Git devuelve error o no busca en el *staging*. Usa: `git grep --cached -q 'patrón'`. |
| El hook no se ejecuta | Comprueba permisos `+x` y ruta `.git/hooks/pre-commit`. |
| Falla en Windows con bash | Usa Git Bash o documenta hook en PowerShell equivalente. |
| Demasiado lento | Mueve pruebas pesadas a `pre-push` o CI; deja en pre-commit solo chequeos rápidos. |

## Ver también

- [GitHub Actions](../16-github-actions/README.md) — automatización remota con CI/CD.

## Referencias

- [Hooks personalizados](https://git-scm.com/book/es/v2/Personalizando-Git-Enlaces-de-Git)
- Documentación: [githooks](https://git-scm.com/docs/githooks)
