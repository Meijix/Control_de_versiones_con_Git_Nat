# Merge con conflictos (`git merge`)

## Propósito

Crear, detectar y resolver **conflictos de merge** paso a paso. Un conflicto ocurre cuando dos ramas modifican la **misma línea** de un archivo y Git no puede decidir automáticamente cuál conservar.

## Para quién es esta guía

Personas que ya usan **ramas** y `git merge`, y necesitan aprender a **identificar y resolver conflictos** cuando la fusión automática falla.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Prerrequisitos

- Saber crear ramas (`git branch`, `git checkout -b`) y fusionarlas (`git merge`).
- Entender que un merge **fast-forward** no genera conflictos; los conflictos aparecen cuando hay cambios divergentes en las mismas líneas.

## Objetivos de aprendizaje

1. Identificar los **marcadores de conflicto** (`<<<<<<<`, `=======`, `>>>>>>>`) en un archivo y entender qué representa cada sección.
2. Resolver un conflicto **manualmente** editando el archivo, eliminando los marcadores y eligiendo (o combinando) los cambios.
3. Usar `git merge --abort` para **cancelar** un merge en curso y volver al estado anterior.

## Escenario

En `main` existe un archivo `app.txt` con tres líneas base. Se crean dos ramas:

- **`feature/header`** modifica la línea 1 con su versión.
- **`feature/footer`** también modifica la línea 1 con una versión diferente.

Se fusiona primero `feature/header` en `main` (sin conflicto). Al intentar fusionar `feature/footer`, Git detecta que la línea 1 fue modificada en ambas ramas y genera un **conflicto** que debe resolverse manualmente.

```
                ┌── feature/header (modifica línea 1)
    main: A ────┤
                └── feature/footer (modifica línea 1)

    Merge de header (OK):       main: A ── H
    Merge de footer (CONFLICTO): ambos cambiaron la línea 1
```

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-merge-conflictos/` con el historial descrito, se provoca el conflicto y se resuelve automáticamente para que veas todo el flujo completo.

## Pasos manuales (para repetir o enseñar)

1. `git checkout main` — asegúrate de estar en la rama principal.
2. `git merge feature/header` — fusión limpia (fast-forward o sin conflicto).
3. `git merge feature/footer` — Git reporta **CONFLICT** en `app.txt`.
4. Abre `app.txt` y localiza los marcadores `<<<<<<<`, `=======`, `>>>>>>>`.
5. Edita el archivo: elige una versión, combina ambas o escribe algo nuevo. Elimina **todos** los marcadores.
6. `git add app.txt` — marca el conflicto como resuelto.
7. `git commit` — Git propone un mensaje de merge; acéptalo o modifícalo.
8. Para cancelar en el paso 4 en vez de resolver: `git merge --abort`.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Merge vs rebase en conflictos | Ambos pueden generar conflictos, pero en **merge** se resuelven una vez; en **rebase** puede haber conflictos en cada commit reaplicado. |
| Conflictos en archivos binarios | Git no puede mostrar marcadores en binarios (imágenes, PDFs). Debes elegir una versión completa con `git checkout --ours archivo` o `git checkout --theirs archivo`. |
| `git mergetool` | Abre una herramienta visual (meld, kdiff3, vimdiff) para resolver conflictos; configúrala con `git config merge.tool <nombre>`. |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Describe el escenario de conflicto** con un diagrama ASCII simple mostrando las ramas divergentes.
- **Incluye un ejemplo de marcadores** para que el lector los reconozca antes de encontrarlos en producción.
- **Documenta la política del equipo**: ¿se prefiere `--ours`, `--theirs`, o revisión manual? ¿Se usa `mergetool`?
- **Indica cómo verificar** que el conflicto se resolvió correctamente: `git diff`, ejecutar tests, revisión de pares.

## Ver también

- [Rebase interactivo](../10-rebase-interactivo/README.md) — reordenar y limpiar commits.
- [Cherry-pick](../09-cherry-pick/README.md) — traer commits específicos de otra rama.
- [Revert](../07-revert/README.md) — deshacer un commit de forma segura.

## Referencias

- [git merge](https://git-scm.com/docs/git-merge)
- Pro Git: [Ramificaciones en Git — Procedimientos básicos de ramificación y fusión](https://git-scm.com/book/es/v2/Ramificaciones-en-Git-Procedimientos-B%C3%A1sicos-para-Ramificar-y-Fusionar)
- Pro Git: [Resolución de conflictos de merge](https://git-scm.com/book/es/v2/Herramientas-de-Git-Resolución-Avanzada-de-Conflictos)
