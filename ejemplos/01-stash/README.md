# Stash (`git stash`)

## Propósito

Guardar cambios sin commitear para **cambiar de contexto** (por ejemplo, atender un hotfix urgente) y **recuperarlos después**, sin perder trabajo ni ensuciar el historial con commits a medias.

## Para quién es esta guía

Personas que necesitan **cambiar de rama** teniendo trabajo sin commitear y quieren una forma limpia de apartar esos cambios temporalmente sin crear commits innecesarios.

## Prerrequisitos

- Entender qué es una **rama** y un **commit**.
- Saber moverse entre ramas con `git checkout` o `git switch`.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Guardar cambios en progreso con `git stash push` y recuperarlos con `git stash pop`.
2. Consultar la lista de stashes almacenados con `git stash list`.
3. Usar mensajes descriptivos al guardar un stash (`git stash push -m "mensaje"`).

## Escenario

Estás trabajando en la rama `feature/dashboard`: has modificado archivos pero **aún no has hecho commit**. Te llega un aviso de que hay un bug urgente en `main` que necesita un hotfix inmediato. Guardas tu trabajo con `git stash`, cambias a `main`, aplicas el arreglo, vuelves a `feature/dashboard` y recuperas tus cambios con `git stash pop`.

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-stash/` con el escenario descrito: trabajo en progreso guardado con stash, hotfix en `main` y recuperación del stash.

## Pasos manuales (para repetir o enseñar)

1. `git checkout feature/dashboard` — sitúate en la rama de trabajo.
2. Edita archivos sin hacer commit.
3. `git stash push -m "WIP: dashboard en progreso"` — guarda los cambios en el stash.
4. `git status` — verifica que el directorio de trabajo está limpio.
5. `git stash list` — comprueba que el stash aparece en la lista.
6. `git checkout main` — cambia a la rama principal.
7. Realiza el hotfix y haz commit.
8. `git checkout feature/dashboard` — vuelve a tu rama.
9. `git stash pop` — recupera los cambios guardados.
10. `git status` — confirma que los cambios están de vuelta.
11. `git stash list` — verifica que la lista de stashes está vacía.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Stash vs commit | El stash es **temporal** y no forma parte del historial; el commit es **permanente** y queda en el log. Usa stash solo para apartar trabajo brevemente. |
| `--include-untracked` | Por defecto `git stash` solo guarda archivos tracked y modificados. Usa `git stash push --include-untracked` (o `-u`) para incluir archivos nuevos que aún no tienen `git add`. |
| Conflictos al hacer pop | Si la rama cambió desde que hiciste stash, `git stash pop` puede generar conflictos. Resuélvelos como en un merge y luego `git stash drop` manual si el pop falló. |
| `stash apply` vs `stash pop` | `apply` restaura los cambios **sin eliminar** el stash de la lista; `pop` restaura **y elimina** el stash. Usa `apply` si quieres conservar el stash como respaldo. |

## Cómo documentar para otros desarrolladores

Cuando documentes el uso de stash en tu equipo, incluye:

1. **Cuándo usar stash** — cambio de contexto rápido, no como almacenamiento a largo plazo.
2. **Convención de mensajes** — acordar un prefijo como `WIP:` para que `git stash list` sea legible.
3. **Limpieza periódica** — recordar que los stashes se acumulan; `git stash clear` elimina todos.
4. **Alternativa** — si el trabajo en progreso es extenso, considerar un commit temporal (`git commit -m "WIP"`) que luego se puede deshacer con `git reset HEAD~1`.

## Ver también

- [Reset](../06-reset/README.md) — mover HEAD a otro commit.
- [Worktree](../13-worktree/README.md) — trabajar en múltiples ramas simultáneamente.

## Referencias

- [git stash](https://git-scm.com/docs/git-stash)
- Pro Git: [Guardado rápido y limpieza](https://git-scm.com/book/es/v2/Herramientas-de-Git-Guardado-R%C3%A1pido-y-Limpieza)
