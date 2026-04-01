# Reflog (`git reflog`)

## Propósito

Recuperar **commits perdidos** tras operaciones destructivas como `reset --hard`. El reflog registra cada movimiento de `HEAD` y de las referencias de ramas, actuando como una **red de seguridad local** que permite deshacer casi cualquier error.

## Para quién es esta guía

Personas que han perdido commits accidentalmente (por un `reset --hard`, un `rebase` fallido o un `branch -D` prematuro) y necesitan recuperarlos antes de que Git los elimine de forma definitiva.

## Prerrequisitos

- Entender qué es un **commit** y cómo funciona `git reset` (al menos `--soft` vs `--hard`).
- Saber leer `git log --oneline` y copiar un hash de commit.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Leer e interpretar la salida de `git reflog` para localizar commits que ya no aparecen en `git log`.
2. Recuperar commits perdidos usando `git reset --hard <hash>` o creando una rama nueva con `git branch <nombre> <hash>`.
3. Comprender que las entradas del reflog **expiran** (por defecto a los 90 días) y que el reflog es **exclusivamente local**.

## Escenario

Se crean **tres commits** en `main` (archivo `app.txt` con versiones v1, v2 y v3). Después se ejecuta `git reset --hard HEAD~2` para "perder" los dos últimos commits. Usando `git reflog` se localizan los hashes de los commits eliminados y se recuperan con `git reset --hard`.

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea un subdirectorio `_demo-reflog/` con el repositorio de prueba. El script muestra paso a paso la pérdida y recuperación de commits.

## Pasos manuales (para repetir o enseñar)

1. Crea un repositorio de prueba con al menos tres commits.
2. Ejecuta `git log --oneline` para ver el historial completo.
3. Ejecuta `git reset --hard HEAD~2` — los dos últimos commits "desaparecen" del log.
4. Ejecuta `git log --oneline` — solo queda el primer commit.
5. Ejecuta `git reflog` — verás **todos los movimientos** de HEAD, incluidos los commits perdidos.
6. Copia el hash del commit al que quieres volver.
7. Recupera con `git reset --hard <hash>` o crea una rama: `git branch rescate <hash>`.
8. Ejecuta `git log --oneline` para confirmar que los commits están de vuelta.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Reflog es solo local | El reflog **no se comparte** con `push`/`pull`; cada clon tiene el suyo propio. Si pierdes commits en un repo que nunca fue clonado ni pusheado, solo el reflog local puede salvarlos. |
| Las entradas expiran | Por defecto, las entradas referenciadas expiran a los **90 días** y las no referenciadas a los **30 días** (`gc.reflogExpire`, `gc.reflogExpireUnreachable`). Después de eso, `git gc` puede eliminar los objetos. |
| Reflog vs log | `git log` muestra el historial de commits accesible desde la referencia actual; `git reflog` muestra el historial de **movimientos** de esa referencia (incluidos resets, rebases, checkouts, etc.). |
| Recuperar con reset vs branch | `git reset --hard <hash>` mueve la rama actual al commit recuperado (reescribe HEAD). `git branch <nombre> <hash>` crea una **rama nueva** apuntando al commit perdido sin modificar la rama actual — más seguro si quieres inspeccionar antes. |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Explica que reflog es efímero**: no sustituye a los backups ni a los remotos. Si un commit lleva más de 90 días perdido y se ejecutó `git gc`, no habrá forma de recuperarlo.
- **Documenta el comando de verificación**: `git reflog` seguido de `git show <hash>` para confirmar que el commit contiene lo esperado.
- **Incluye alternativas**: `git fsck --lost-found` puede encontrar objetos huérfanos incluso si el reflog ya expiró (mientras no se haya ejecutado `gc`).

### Ejemplo de sección "Verificación"

```text
git reflog                  # localizar el hash del commit perdido
git show <hash>             # verificar que es el commit correcto
git reset --hard <hash>     # o: git branch rescate <hash>
git log --oneline           # confirmar la recuperación
```

## Referencias

- [git reflog](https://git-scm.com/docs/git-reflog)
- Pro Git: [Mantenimiento y recuperación de datos](https://git-scm.com/book/es/v2/Herramientas-de-Git-Mantenimiento-y-Recuperaci%C3%B3n-de-Datos)
