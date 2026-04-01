# Control de versiones con Git

[![Licencia: CC BY 4.0](https://img.shields.io/badge/Licencia-CC%20BY%204.0-lightgrey.svg)](LICENSE)
[![Git](https://img.shields.io/badge/Git-2.30%2B-f05032.svg?logo=git&logoColor=white)](https://git-scm.com/)
[![Plataforma](https://img.shields.io/badge/Plataforma-macOS%20%7C%20Linux%20%7C%20Windows%20(Git%20Bash)-blue.svg)](https://gitforwindows.org/)

En este curso se encuentran los recursos relacionados con la asignatura.

## Descripción

Se abordan los conceptos básicos y las buenas prácticas para el control de versiones, así como el uso de Git para la gestión de un repositorio de código fuente.

## Tabla de contenidos

- [Configuración inicial](#configuración-inicial)
- [Comandos del día a día](#comandos-del-día-a-día)
- [Ramas](#ramas)
- [Resolución de conflictos](#resolución-de-conflictos)
- [Flujos de trabajo](#flujos-de-trabajo)
  - [Git Flow](#git-flow)
  - [Trunk-based development](#trunk-based-development)
  - [GitHub Flow](#github-flow)
  - [GitLab Flow](#gitlab-flow)
  - [Flujo con bifurcación](#flujo-con-bifurcación-forking-workflow)
  - [Flujo por rama de funcionalidad](#flujo-por-rama-de-funcionalidad-feature-branch-simplificado)
- [Notas importantes](#notas-importantes-evitar-confusiones)
- [Autor](#autor)

---

## Configuración inicial

- **Identidad (obligatorio antes del primer commit)**  
  `git config --global user.name "Tu Nombre"`  
  `git config --global user.email "tu@correo.com"`

- **Editor por defecto** (opcional)  
  `git config --global core.editor "code --wait"`  
  (ajusta el comando según tu editor.)

- **Rama principal** (Git 2.28+)  
  `git config --global init.defaultBranch main`

- **Ver configuración**  
  `git config --list`  
  `git config user.name`

- **Inicializar o clonar**  
  `git init` — crea un repositorio en la carpeta actual.  
  `git clone <url>` — copia un remoto y prepara `origin`.

- **Autenticación con el remoto**  
  SSH (clave en `~/.ssh`) o HTTPS con credencial almacenada o token personal, según el proveedor (GitHub, GitLab, etc.).

---

## Comandos del día a día

| Acción | Comando habitual |
|--------|------------------|
| Estado del árbol de trabajo | `git status` |
| Ver cambios | `git diff` / `git diff --staged` |
| Añadir al área de preparación | `git add <archivo>` / `git add -A` |
| Confirmar cambios | `git commit -m "mensaje claro"` |
| Historial | `git log --oneline --graph --decorate --all` |
| Sincronizar con remoto | `git fetch` luego `git merge` o `git pull` |
| Enviar commits | `git push` / `git push -u origin <rama>` |
| Deshacer cambios locales no confirmados | `git restore <archivo>` / `git checkout -- <archivo>` (versiones antiguas) |
| Quitar del stage | `git restore --staged <archivo>` |

Buenas prácticas: commits pequeños, mensajes en imperativo y descriptivos; usar `git status` antes de `commit` y `push`.

- Consulta la [hoja de referencia rápida](cheat-sheet.md) para tener los comandos a mano.
- Para ejemplos de buenos y malos mensajes de commit, revisa [`buenas-practicas-commits.md`](buenas-practicas-commits.md).
- Si te encuentras con errores comunes de Git, consulta la [guía de solución de problemas](troubleshooting.md).
- Revisa el [glosario de términos](glosario.md) si algún concepto no te queda claro.
- ¿No sabes qué comando usar? Consulta el [mapa de decisión de comandos](mapa-de-comandos.md).
- Configura [aliases útiles](aliases.md) para agilizar tu trabajo diario.

---

## Ramas

- **Crear y cambiar de rama**  
  `git branch <nombre>`  
  `git switch <nombre>` o `git checkout <nombre>`

- **Crear y cambiar en un paso**  
  `git switch -c <nombre>` o `git checkout -b <nombre>`

- **Listar ramas**  
  `git branch` (local), `git branch -a` (incluye remotas)

- **Eliminar rama local**  
  `git branch -d <nombre>` (seguro) / `-D` (forzado)

- **Rama de seguimiento remoto**  
  `git push -u origin <rama>` — enlaza la rama local con la remota.

- **Actualizar referencias remotas**  
  `git fetch --prune` — limpia ramas remotas eliminadas en el servidor.

---

## Resolución de conflictos

1. **Al hacer merge o rebase** Git marca archivos en conflicto. Abre cada archivo y busca marcadores `<<<<<<<`, `=======`, `>>>>>>>`.
2. **Edita** dejando el código correcto y **elimina** los marcadores.
3. **Marca como resuelto**  
   `git add <archivo>`
4. **Finaliza**  
   - Tras merge: `git commit` (o completa el merge si Git lo pide).  
   - Tras rebase: `git rebase --continue`.

Herramientas útiles: `git mergetool`, comparadores visuales o la vista de conflictos del IDE.

Si el conflicto es demasiado enredado: `git merge --abort` o `git rebase --abort` (solo si aún no has terminado la operación).

---

## Flujos de trabajo

### Git Flow

Modelo con ramas de larga duración y roles fijos:

- **`main` (o `master`)**: solo versiones listas para producción.
- **`develop`**: integración del trabajo en curso hacia la siguiente release.
- **Ramas de soporte**: `feature/*` desde `develop`, `release/*` para preparar versiones, `hotfix/*` desde `main` para parches urgentes.

Ventaja: separación clara entre desarrollo y producción. Coste: más merges y ceremonia; encaja en equipos con releases programadas.

### Trunk-based development

Una **rama principal** (`main`/`trunk`) recibe integraciones **frecuentes** y **pequeñas**; las features van en ramas cortas o directamente con *feature flags*.

- Objetivo: reducir ramas largas y conflictos masivos.
- Requiere **CI sólido**, pruebas automatizadas y revisiones rápidas.

Comparación breve: Git Flow estructura releases y roles de rama; trunk-based prioriza velocidad de integración y simplicidad de ramas, a costa de disciplina en el pipeline y en el tamaño de los cambios.

### GitHub Flow

Pensado para **despliegue continuo** y equipos que publican desde `main` con frecuencia:

- Una rama **`main`** siempre desplegable (o lista para desplegar con un clic).
- Trabajo en **ramas cortas** por tarea (`feature/...`), **pull request** (PR) hacia `main`, revisión y CI, luego merge y despliegue.

No hay `develop` ni ramas `release`/`hotfix` como en Git Flow: la simplicidad gana; los “hotfixes” son otra rama corta igual que el resto.

### GitLab Flow

Añade **entornos** o **tipos de rama** según el flujo del equipo:

- **Rama de producción** (`production`) o tags para lo que está en producción.
- Opcionalmente **`pre-production`** / **`staging`** para validar antes de producción.
- **`main`** (o `master`) como integración; **merge requests** hacia la rama que corresponda al entorno.

Útil cuando no todo lo integrado en `main` va directo a producción y quieres un camino explícito por entornos.

### Flujo con bifurcación (*forking workflow*)

Típico en **proyectos abiertos** o con muchos colaboradores externos:

- Cada persona clona su **fork** en el hosting (copia bajo su usuario).
- Trabaja en ramas propias, abre **pull request** del fork hacia el repositorio **upstream** (el oficial).
- Mantiene el fork actualizado con `git remote add upstream ...` y `git fetch upstream` + merge o rebase desde `upstream/main`.

No confundir: **fork** (copia en el servidor) no es lo mismo que **clonar** (copia local de un remoto que ya eliges).

### Flujo por rama de funcionalidad (*feature branch*, simplificado)

Variante mínima muy extendida:

- `main` estable; cada cambio en una rama `feature/...` o `fix/...`.
- Al terminar: merge (o rebase según norma del equipo) y borrar la rama.

Es la base de GitHub Flow y de muchos equipos sin formalizar Git Flow completo.

---

## Notas importantes (evitar confusiones)

### Áreas de trabajo: working tree, staging e historial

- **Working tree**: archivos en disco; pueden diferir del último commit.
- **Staging** (*index*): lo que entrará en el **siguiente** `commit` (`git add`).
- **Repositorio** (commits): historial inmutable salvo herramientas como `reset` o `rebase`.

`git diff` compara working tree vs staging; `git diff --staged` compara staging vs último commit.

```
  Working Tree          Staging (Index)        Repositorio (.git)
 ┌──────────────┐      ┌──────────────┐       ┌──────────────┐
 │  Archivos    │      │  Snapshot    │       │   Commits    │
 │  en disco    │─────>│  preparado   │──────>│  (historial) │
 │              │      │              │       │              │
 └──────────────┘      └──────────────┘       └──────────────┘
       git add ──────>       git commit ──────>
       <────── git restore   <────── git reset
```

### `fetch` vs `pull`

- **`git fetch`**: trae commits del remoto y **actualiza referencias** (`origin/main`, etc.) **sin** fusionar en tu rama actual. Tu trabajo local no cambia hasta que hagas `merge` o `rebase`.
- **`git pull`**: suele ser `fetch` + `merge` (o `fetch` + `rebase` con `pull.rebase`). Es más rápido de un paso pero **mezcla** dos operaciones; si algo falla, conviene saber qué hizo cada parte.

### Merge vs rebase

- **Merge**: crea un commit de fusión; **preserva** el contexto de “dos líneas de trabajo que se unen”. Historial puede mostrar más bifurcaciones.
- **Rebase**: **reaplica** tus commits encima de otra base; historial más **lineal**, pero **reescribe** commits ya publicados si los rebases de nuevo (cambia hashes).

```
Merge (conserva bifurcación):

    main:    A───B───C───M
                  \     /
    feature:       D───E

Rebase (historial lineal):

    main:    A───B───C
                      \
    feature:           D'──E'
```

Norma habitual: **no rebases commits que ya están en `main` compartido** sin coordinación; en ramas locales o antes del push está bien. Equipos suelen decidir: “merge en PR público” o “rebase + fast-forward”.

### `main` local vs `origin/main`

- **`main`**: tu rama local.
- **`origin/main`**: **último estado conocido** del remoto tras el último `fetch`/`pull`; no es una rama que “edites” directamente, es una referencia de lectura.

Tras `fetch`, puedes comparar: `git log main..origin/main` (commits que tienes en remoto y tú no) u `origin/main..main` (al revés).

### HEAD y *detached HEAD*

- **HEAD** apunta al commit en el que estás (normalmente el último de una rama).
- **Detached HEAD**: estás en un commit concreto **sin** rama (por ejemplo tras `git checkout <hash>`). Los commits nuevos ahí **no pertenecen a ninguna rama** hasta que crees una (`git switch -c ...`) o te arriesgas a perderlos al cambiar de sitio.

### Reset: `--soft`, `--mixed`, `--hard`

- **`--soft`**: mueve la rama; **deja** cambios en **staging**.
- **`--mixed`** (por defecto): mueve la rama; cambios vuelven al **working tree** sin staging.
- **`--hard`**: mueve la rama y **descarta** cambios en working tree y staging en esos archivos. **Destructivo** si no habías respaldado o commiteado.

### `.gitignore` no “des-traquea” lo ya versionado

Añadir un archivo a `.gitignore` **no quita** el seguimiento de archivos que **ya** están en el repositorio. Hay que dejar de rastrearlos con `git rm --cached <archivo>` (sin borrar el archivo en disco) y luego commitear.

### `main` vs `master`

Son **nombres** de rama; el comportamiento de Git es el mismo. Muchos proyectos nuevos usan `main` por convención; repositorios antiguos pueden seguir en `master`. No mezcles nombres en documentación sin aclarar cuál usa tu remoto.

### Force push (`--force` / `--force-with-lease`)

- **`git push --force`** sobrescribe la rama remota. Puede **borrar trabajo ajeno** si otra persona ya subió commits.
- **`--force-with-lease`** solo fuerza si el remoto sigue donde lo viste en el último `fetch`; es algo **más seguro**, pero sigue siendo operación delicada en ramas compartidas.

Usar force solo cuando el equipo lo acuerde (p. ej. tras rebase de una rama de feature propia antes del merge).

### Etiquetas (*tags*) vs ramas

- **Rama** avanza con nuevos commits (puntero móvil).
- **Tag** suele marcar un **punto fijo** (p. ej. `v1.0.0`). Para desplegues o releases se usan tags anotados `git tag -a`.

---

## Autor

- Natalia Edith Mejia Bautista

### Contacto

- nmejia30@ciencias.unam.mx  
- natalia.mejbau@gmail.com

## Instructor

- Daniel Barajas González

### Contacto

- ldanielbg@comunidad.unam.mx
