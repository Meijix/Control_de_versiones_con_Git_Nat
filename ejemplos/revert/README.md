# Revert (`git revert`)

## Propósito

Deshacer un commit específico de forma segura creando un nuevo commit que revierte los cambios, **sin reescribir el historial**. Ideal para ramas compartidas donde no se debe alterar el historial existente.

## Para quién es esta guía

Personas que necesitan **deshacer cambios** en ramas compartidas de forma segura, sin afectar el trabajo de otros colaboradores ni reescribir commits ya publicados.

## Prerrequisitos

- Saber leer `git log --oneline` y copiar un hash de commit.
- Entender que cada commit representa un conjunto de cambios (diff) que puede aplicarse o revertirse de forma independiente.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Distinguir entre `git revert` (seguro, crea un commit nuevo) y `git reset` (reescribe historial, peligroso en ramas compartidas).
2. Revertir un commit específico sin afectar los commits posteriores.
3. Comprender que `git revert` **crea un nuevo commit** que deshace los cambios del commit original, preservando todo el historial.

## Escenario

Tres commits en `main`:

1. **Commit 1**: funcionalidad base (`app.txt` con una línea).
2. **Commit 2**: introduce un cambio problemático (segunda línea).
3. **Commit 3**: nueva funcionalidad (tercera línea).

Se detecta que el commit 2 es problemático. Se necesita **revertir solo ese commit** manteniendo los cambios del commit 3. `git revert` crea un cuarto commit que deshace únicamente los cambios del commit 2.

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-revert/` con el historial descrito y se ejecuta un `git revert` del commit problemático.

## Pasos manuales

1. Identificar el hash del commit a revertir: `git log --oneline`.
2. Ejecutar `git revert <hash>` — Git abre el editor para el mensaje del nuevo commit (o usa `--no-edit` para aceptar el mensaje por defecto).
3. Verificar con `git log --oneline` que aparece el nuevo commit de reversión.
4. Revisar el contenido del archivo para confirmar que solo se deshicieron los cambios del commit indicado.
5. Para cancelar un revert en curso: `git revert --abort`.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Revert vs reset | `git revert` es seguro para ramas compartidas: no borra ni reescribe commits, solo agrega uno nuevo. `git reset` reescribe el historial y puede causar problemas si otros ya descargaron esos commits. |
| Revertir un merge commit | Los merge commits tienen dos padres; hay que indicar cuál conservar con `-m 1` (generalmente el padre de la rama principal): `git revert -m 1 <hash_del_merge>`. |
| Revert crea un commit nuevo | El commit de reversión tiene su propio hash y aparece en el historial. No "borra" nada; aplica el diff inverso del commit original. |
| Revertir un revert | Si revertiste por error, puedes revertir el commit de reversión para restaurar los cambios originales: `git revert <hash_del_revert>`. |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Indica el commit revertido** con su hash y mensaje, para que el equipo entienda qué se deshizo y por qué.
- **Explica el motivo** en el mensaje del commit de reversión (o en el PR/MR asociado).
- **Documenta cómo restaurar** si el revert fue temporal: "para re-aplicar, revertir el commit de reversión `<hash>`".

### Ejemplo de sección "Verificación"

```text
git log --oneline          # debe mostrar el commit de reversión como el más reciente
cat app.txt                # debe contener solo las líneas esperadas (sin el cambio revertido)
```

## Ver también

- [Reset](../reset/README.md) — mover HEAD con --soft, --mixed o --hard.
- [Reflog](../reflog/README.md) — recuperar commits perdidos.
- [Cherry-pick](../cherry-pick/README.md) — traer commits específicos de otra rama.

## Referencias

- [git revert](https://git-scm.com/docs/git-revert)
- Pro Git: [Deshacer cosas](https://git-scm.com/book/es/v2/Fundamentos-de-Git-Deshacer-Cosas)
