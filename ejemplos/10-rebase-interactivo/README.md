# Rebase interactivo (`git rebase -i`)

## Propósito

Documentar **cuándo** y **cómo** usar un rebase interactivo para limpiar el historial antes de integrar trabajo (por ejemplo, fusionar varios *work-in-progress* en un solo commit con mensaje claro).

## Para quién es esta guía

Desarrolladores que ya usan `commit` y `merge` y quieren **reescribir commits locales** de forma controlada sin confundir rebase con merge.

## Prerrequisitos

- Git 2.23+ recomendado (`git switch` aparece en otros materiales; aquí usamos solo `rebase`).
- Saber que **reescribir commits cambia los hashes** y no debe hacerse a ciegas en ramas compartidas sin acuerdo de equipo.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

Al terminar deberías poder:

1. Explicar la diferencia entre **merge** (preserva bifurcaciones) y **rebase** (reaplica commits sobre otra base).
2. Abrir un rebase interactivo y reconocer el archivo de instrucciones (`pick`, `squash`, `reword`, `drop`, reordenar líneas).
3. Automatizar o repetir demostraciones con `GIT_SEQUENCE_EDITOR` cuando no quieras abrir Vim en clase o en CI.

## Escenario

Tres commits seguidos en `main` donde los dos últimos son avances pequeños que quieres **unificar** en el primero para dejar un historial más legible antes de abrir un *pull request*.

## Cómo ejecutar la demostración

Desde esta carpeta:

```bash
bash demo-setup.sh
```

El script crea un subdirectorio `_demo-rebase-interactivo/` (ignóralo en tu propio repositorio si añades estos ejemplos al `.gitignore` global o local), inicializa un repo de prueba y ejecuta un **squash** de los dos últimos commits sobre el primero mediante variables de entorno de Git.

## Pasos manuales equivalentes (para practicar tú mismo)

1. Clona o crea un repo de prueba y haz tres commits como en el script.
2. Ejecuta `git rebase -i --root` (si quieres revisar **todos** los commits desde el primero) o `git rebase -i HEAD~3` **solo** cuando exista un cuarto commit atrás (con exactamente tres commits desde el inicio, usa `--root`).
3. En el editor, deja la primera línea como `pick` y cambia las dos siguientes de `pick` a `squash` (o `s`).
4. Guarda y cierra; Git pedirá un mensaje para el commit resultante.
5. Comprueba con `git log --oneline`.

## Qué hace el script (resumen técnico)

- `GIT_SEQUENCE_EDITOR` sustituye al editor humano: modifica el fichero temporal que Git genera para el rebase y marca líneas 2 y 3 como `squash`.
- `GIT_EDITOR=true` evita que se abra otro editor para el mensaje del squash en esta demo rápida (Git puede usar el mensaje por defecto combinado; según versión, puede que quieras ajustar el mensaje a mano en un flujo real).

En producción, **no** silencies el editor del mensaje: revisa siempre el texto del commit fusionado.

## Errores frecuentes

| Síntoma | Causa probable |
|--------|----------------|
| `interactive rebase already in progress` | Quedó un rebase a medias; `git rebase --abort` o termina el rebase. |
| Conflictos durante el rebase | El mismo proceso que en merge: edita, `git add`, `git rebase --continue`. |
| “No quiero reescribir historia remota” | Correcto: en ramas ya publicadas, coordina con el equipo o usa merge. |

## Cómo documentar para otros desarrolladores

Cuando escribas una guía similar para tu equipo, incluye siempre:

1. **Propósito en una frase** — qué problema resuelve el procedimiento.
2. **Audiencia y prerrequisitos** — qué debe saber ya quien lee.
3. **Resultado esperado** — qué verá al final (comando de verificación).
4. **Pasos ordenados** — numerados, con comandos copiables.
5. **Límites y riesgos** — por ejemplo “no rebases en `main` compartido sin política acordada”.
6. **Recuperación ante fallos** — `git rebase --abort`, enlaces a documentación oficial.

### Plantilla mínima (copia y adapta)

```markdown
## Objetivo
## Requisitos
## Pasos
## Verificación
## Si algo sale mal
## Referencias
```

## Ver también

- [Cherry-pick](../09-cherry-pick/README.md) — traer commits específicos de otra rama.
- [Merge con conflictos](../04-merge-conflictos/README.md) — resolver conflictos de fusión.
- [Reset](../06-reset/README.md) — mover HEAD a otro commit.

## Referencias

- Documentación oficial: [git rebase](https://git-scm.com/docs/git-rebase)
- Libro Pro Git: [Reescribir el historial](https://git-scm.com/book/es/v2/Herramientas-de-Git-Reescribir-el-Historial)
