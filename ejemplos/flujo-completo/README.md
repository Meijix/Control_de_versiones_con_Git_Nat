# Flujo de trabajo completo

## Propósito

Simular un **día de trabajo real** con Git de principio a fin: crear una rama de feature, hacer commits progresivos, sincronizar con cambios de otros compañeros en `main`, resolver un conflicto, fusionar con merge commit y etiquetar una release. El objetivo es conectar todos los comandos individuales en un flujo continuo y coherente.

## Para quién es esta guía

Personas que ya conocen los comandos individuales de Git (`commit`, `branch`, `merge`, `tag`) pero **nunca han ejecutado un flujo completo** de principio a fin. Si ya manejas cada pieza por separado pero no sabes cómo encajan todas en una jornada de trabajo, esta guía es para ti.

## Prerrequisitos

- Saber crear ramas (`git branch`, `git checkout -b`) y alternar entre ellas (`git checkout`, `git switch`).
- Entender qué es un commit y cómo hacer `git add` + `git commit`.
- Haber leído sobre merge (al menos saber que `git merge` une ramas) y conflictos (marcadores `<<<<<<<`, `=======`, `>>>>>>>`).

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Qué simula el script

El script `demo-setup.sh` reproduce los siguientes pasos de un día de desarrollo típico:

1. **Inicialización del proyecto**: se crea un repositorio con un commit base en `main` que contiene un `README.md`.
2. **Creación de la rama de feature**: se crea `feature/login` y se cambia a ella para trabajar de forma aislada.
3. **Primer commit en la feature**: se añade el archivo `login.txt` con la funcionalidad básica.
4. **Segundo commit en la feature**: se mejora `login.txt` con validación de sesión.
5. **Cambio concurrente en main**: mientras trabajábamos en la feature, otro compañero modificó `README.md` en `main` (se simula este cambio).
6. **Sincronización con main**: al traer los cambios de `main` a la feature (merge), se produce un **conflicto** en `README.md` que se resuelve combinando ambos cambios.
7. **Fusión final y etiquetado**: se vuelve a `main`, se fusiona la feature con `--no-ff` (merge commit explícito) y se crea la etiqueta anotada `v1.0.0` marcando la release.

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-flujo-completo/` con todo el historial descrito. El script muestra cada fase con separadores claros para que puedas seguir el flujo paso a paso.

## Pasos del flujo (explicación detallada)

### 1. Commit inicial en main

Se crea el archivo `README.md` del proyecto y se registra el primer commit. Este es el punto de partida estable del repositorio.

```bash
echo "# Mi Proyecto" > README.md
echo "Aplicación de gestión de usuarios." >> README.md
git add README.md
git commit -m "docs: README inicial del proyecto"
```

### 2. Crear la rama de feature

Se crea la rama `feature/login` a partir de `main`. A partir de aquí, todo el trabajo se hace en la rama de feature sin afectar a `main`.

```bash
git checkout -b feature/login
```

### 3. Primer commit en la feature

Se añade `login.txt` con la funcionalidad básica del login.

```bash
echo "formulario de login" > login.txt
git add login.txt
git commit -m "feat(login): añadir formulario básico de login"
```

### 4. Segundo commit en la feature

Se mejora el archivo con la validación de sesión. Son dos commits separados porque cada uno representa una unidad lógica de trabajo.

```bash
echo "validación de sesión activa" >> login.txt
git add login.txt
git commit -m "feat(login): añadir validación de sesión"
```

### 5. Cambio concurrente en main

Mientras trabajábamos en la feature, un compañero hizo un cambio en `main` que modifica el mismo archivo `README.md`. Esto es lo más habitual en equipos: la rama principal avanza mientras tú trabajas en tu rama.

```bash
git checkout main
echo "Versión: 0.9-beta" >> README.md
git add README.md
git commit -m "docs: añadir versión beta al README"
```

### 6. Sincronizar la feature con main (conflicto)

Al volver a `feature/login` e intentar traer los cambios de `main`, Git detecta que ambas ramas tocaron `README.md`. Se produce un conflicto que debemos resolver manualmente, combinando ambos cambios.

```bash
git checkout feature/login
git merge main    # ← CONFLICTO en README.md
# Resolver el conflicto editando README.md
git add README.md
git commit -m "merge: resolver conflicto con main en README"
```

### 7. Fusionar en main y etiquetar la release

Una vez que la feature está actualizada y sin conflictos, se vuelve a `main` y se fusiona con `--no-ff` para crear un merge commit explícito que documente la integración. Finalmente se etiqueta como `v1.0.0`.

```bash
git checkout main
git merge --no-ff feature/login -m "merge: integrar feature/login en main"
git tag -a v1.0.0 -m "Release 1.0.0 — login funcional"
```

## Ver también

- [`merge-conflictos`](../merge-conflictos/) — Profundiza en la detección y resolución de conflictos de merge.
- [`rebase-interactivo`](../rebase-interactivo/) — Limpia el historial de la feature antes de fusionar (alternativa a merge).
- [`tag`](../tag/) — Etiquetas ligeras vs anotadas, convenciones de versionado y gestión de releases.
- [`stash`](../stash/) — Guardar trabajo temporal cuando necesitas cambiar de rama sin commitear.

## Referencias

- [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- Pro Git: [Ramificaciones en Git](https://git-scm.com/book/es/v2/Ramificaciones-en-Git-Procedimientos-B%C3%A1sicos-para-Ramificar-y-Fusionar)
- [git merge --no-ff](https://git-scm.com/docs/git-merge#_fast_forward_merge)
- [git tag](https://git-scm.com/docs/git-tag)
