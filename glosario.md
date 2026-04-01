# Glosario de Git

Definiciones de los términos más usados en Git, ordenados alfabéticamente.

| Término | Definición |
|---------|------------|
| **blob** | Objeto interno de Git que almacena el contenido de un archivo. Cada versión de un archivo es un blob distinto identificado por su hash SHA. |
| **branch** (rama) | Puntero móvil a un commit. Avanza automáticamente con cada nuevo commit. Permite trabajar en líneas de desarrollo paralelas. |
| **checkout** | Comando que cambia el contenido del working tree al estado de una rama o commit. En versiones modernas se prefieren `git switch` y `git restore`. |
| **cherry-pick** | Aplicar los cambios de un commit específico sobre la rama actual, creando un nuevo commit con distinto hash. |
| **clone** | Crear una copia local completa de un repositorio remoto, incluyendo todo el historial y ramas. |
| **commit** | Instantánea del estado del proyecto en un momento dado. Contiene los cambios, el autor, la fecha y un mensaje descriptivo. Es inmutable una vez creado. |
| **conflict** (conflicto) | Situación en la que Git no puede fusionar automáticamente dos cambios porque afectan las mismas líneas. Requiere resolución manual. |
| **detached HEAD** | Estado en el que HEAD apunta directamente a un commit en lugar de a una rama. Los commits hechos aquí no pertenecen a ninguna rama hasta crear una. |
| **diff** | Comparación entre dos estados del código. Puede ser entre working tree y staging, entre commits, o entre ramas. |
| **fast-forward** | Tipo de merge donde la rama destino simplemente avanza al último commit de la rama fuente, sin crear commit de fusión. Ocurre cuando no hay divergencia. |
| **fetch** | Descargar commits y referencias de un remoto sin modificar la rama local. Actualiza las referencias remotas (e.g., `origin/main`). |
| **fork** | Copia de un repositorio en el servidor (GitHub, GitLab) bajo tu cuenta. No es un concepto de Git en sí, sino del hosting. Distinto de clone (copia local). |
| **HEAD** | Puntero al commit actual en el que te encuentras. Normalmente apunta a la rama activa; si apunta a un commit directamente, estás en *detached HEAD*. |
| **hook** | Script que Git ejecuta automáticamente en ciertos eventos (antes del commit, antes del push, etc.). Se almacenan en `.git/hooks/`. |
| **index** | Ver **staging area**. |
| **merge** | Fusionar los cambios de una rama en otra. Puede ser fast-forward (sin commit de fusión) o crear un commit de merge con dos padres. |
| **origin** | Nombre convencional del remoto principal (el repositorio del que se hizo clone). Es un alias, no un nombre especial de Git. |
| **pull** | Combinación de `fetch` + `merge` (o `fetch` + `rebase` con `pull.rebase`). Trae y fusiona cambios del remoto en un solo paso. |
| **push** | Enviar commits locales al repositorio remoto. Solo funciona si el remoto no tiene commits que tú no tengas (salvo con `--force`). |
| **rebase** | Reaplicar commits de una rama sobre otra base, creando nuevos commits con hashes distintos. Produce un historial lineal pero reescribe historia. |
| **reflog** | Registro local de todos los movimientos de HEAD y de las ramas. Permite recuperar commits "perdidos" tras reset, rebase u otras operaciones. Expira a los 90 días por defecto. |
| **remote** (remoto) | Repositorio alojado en un servidor (GitHub, GitLab, Bitbucket, etc.) con el que sincronizas tu copia local. |
| **repository** (repositorio) | Directorio que contiene el historial completo del proyecto en la carpeta oculta `.git/`. Incluye commits, ramas, tags y configuración. |
| **reset** | Mover la rama actual a otro commit. Con `--soft` conserva cambios en staging, con `--mixed` los deja en el working tree, con `--hard` los descarta. |
| **revert** | Crear un nuevo commit que deshace los cambios de un commit anterior. A diferencia de reset, no reescribe la historia; es seguro para ramas compartidas. |
| **stash** | Guardar temporalmente cambios sin commitear en una pila. Permite cambiar de rama con el working tree limpio y recuperar los cambios después. |
| **staging area** (área de preparación) | Zona intermedia entre el working tree y el repositorio. Los cambios se agregan con `git add` y se confirman con `git commit`. También llamada *index*. |
| **tag** (etiqueta) | Referencia fija a un commit específico. Las etiquetas **ligeras** son solo punteros; las **anotadas** incluyen autor, fecha y mensaje. Se usan para marcar releases. |
| **tracking branch** | Rama local vinculada a una rama remota (e.g., `main` sigue a `origin/main`). Permite usar `git push`/`git pull` sin especificar el remoto. |
| **upstream** | El repositorio original del que se hizo fork. También se usa para referirse a la rama remota que "sigue" tu rama local. |
| **working tree** (árbol de trabajo) | Los archivos en disco tal como los ves en tu editor. Pueden diferir del último commit y del staging area. |

## Referencias

- [Glosario oficial de Git](https://git-scm.com/docs/gitglossary)
- [Pro Git: Fundamentos de Git](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Fundamentos-de-Git)
