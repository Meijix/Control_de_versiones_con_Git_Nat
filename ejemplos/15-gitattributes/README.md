# Gitattributes (`.gitattributes`)

## Propósito

Configurar **cómo Git maneja archivos específicos** dentro del repositorio: normalización de fin de línea (LF vs CRLF), estrategias de merge para lockfiles y diff semántico para archivos binarios o de texto especial. Todo esto se define por ruta o patrón de archivo, de forma versionada y compartida con el equipo.

## Para quién es esta guía

Equipos que trabajan en **múltiples sistemas operativos** (Windows, macOS, Linux) o que gestionan **archivos binarios** (imágenes, PDFs, ZIPs) dentro de sus repositorios. También es útil para proyectos con lockfiles (`package-lock.json`, `yarn.lock`) que generan conflictos de merge innecesarios.

## Prerrequisitos

- Conocimientos básicos de Git: `git add`, `git commit`, `git diff`.
- Entender la diferencia entre archivos de texto y binarios en un repositorio.

> **Windows**: los problemas de fin de línea (CRLF vs LF) son especialmente frecuentes en equipos mixtos. `.gitattributes` es la forma recomendada de resolverlos de manera consistente, por encima de `core.autocrlf` en la configuración local.

## Objetivos de aprendizaje

1. Usar `* text=auto` para normalizar automáticamente los fines de línea en todo el repositorio.
2. Definir estrategias de merge (`merge=ours`) para evitar conflictos en archivos generados como lockfiles.
3. Marcar archivos binarios correctamente para que Git no intente mostrar diffs de texto ni normalizar su contenido.

## ¿Qué es `.gitattributes`?

Es un archivo que se coloca en la **raíz del repositorio** y define **atributos por ruta** (usando los mismos patrones glob que `.gitignore`). Cada línea asocia un patrón de archivo con uno o más atributos que controlan el comportamiento de Git.

La diferencia clave frente a `.git/config` o `~/.gitconfig` es que `.gitattributes` **se versiona junto al código**: cualquier persona que clone el repositorio obtiene la misma configuración de atributos sin necesidad de ajustar nada en su máquina local.

```text
# Sintaxis general
patrón    atributo1    atributo2 ...
```

Ejemplo mínimo:

```text
* text=auto
*.png binary
```

## Configuraciones más útiles

### Normalización de fin de línea

El atributo `text` controla la conversión de fines de línea. Con `text=auto`, Git detecta automáticamente si un archivo es de texto y normaliza a LF en el repositorio, convirtiendo a la convención del SO al hacer checkout.

```text
# Detección automática para todos los archivos
* text=auto

# Forzar LF en scripts (deben funcionar en Unix)
*.sh   text eol=lf
*.bash text eol=lf

# Forzar CRLF en archivos exclusivos de Windows
*.bat text eol=crlf
*.cmd text eol=crlf
```

### Archivos binarios

El atributo `binary` es un atajo para `-diff -merge -text`: Git no intentará mostrar diffs de texto, no fusionará contenido y no tocará los fines de línea.

```text
*.png  binary
*.jpg  binary
*.pdf  binary
*.zip  binary
```

### Estrategia de merge

Para archivos generados que siempre producen conflictos inútiles (lockfiles, por ejemplo), se puede indicar a Git que en caso de conflicto **conserve la versión local** (`merge=ours`).

```text
package-lock.json merge=ours
yarn.lock         merge=ours
```

> **Importante**: para que `merge=ours` funcione, primero hay que registrar el driver:
> ```bash
> git config merge.ours.driver true
> ```

### Diff personalizado

Git puede usar drivers de diff que entienden la estructura del archivo, mejorando la legibilidad de los cambios.

```text
*.md diff=markdown
```

Con `diff=markdown`, Git muestra los encabezados (`#`, `##`, etc.) como contexto en los hunks del diff, haciendo mucho más fácil ubicar dónde ocurrió el cambio.

## Archivo de ejemplo

En esta misma carpeta se incluye **`.gitattributes-ejemplo`**, un archivo listo para copiar con las configuraciones más comunes comentadas en español. Revísalo y ajústalo según las necesidades de tu proyecto.

## Cómo usarlo

1. Copia el archivo de ejemplo a la raíz de tu proyecto:

   ```bash
   cp .gitattributes-ejemplo /ruta/a/tu/proyecto/.gitattributes
   ```

2. Revisa y ajusta las reglas según los tipos de archivo de tu proyecto.

3. Haz commit del archivo:

   ```bash
   git add .gitattributes
   git commit -m "Agregar .gitattributes para normalización de líneas y binarios"
   ```

4. (Opcional) Si el repositorio ya tiene historial con fines de línea inconsistentes, normaliza los archivos existentes:

   ```bash
   git add --renormalize .
   git commit -m "Normalizar fines de línea según .gitattributes"
   ```

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| `.gitattributes` vs `.gitconfig` | `.gitattributes` se versiona en el repo y afecta a todos los clones; `.gitconfig` es configuración local/global del usuario y no se comparte. |
| `text` vs `binary` | `text` activa normalización de fines de línea y diff de texto; `binary` desactiva ambos (`-diff -merge -text`). |
| `merge=ours` no es automático | Requiere registrar el driver con `git config merge.ours.driver true`; sin eso, Git ignora el atributo y hace merge normal. |
| Cuándo aplican los atributos | Los atributos se leen al momento del `checkout`, `add`, `diff` y `merge`. Cambiar `.gitattributes` **no** reescribe archivos ya existentes en el working tree; usa `git add --renormalize .` para aplicar retroactivamente. |

## Cómo documentar para otros desarrolladores

Además de incluir el archivo `.gitattributes` en la raíz del proyecto:

- **Explica en el README del proyecto** que existe un `.gitattributes` y cuál es su propósito general (normalización de líneas, manejo de binarios, lockfiles).
- **Documenta el paso de configuración del driver** si usas `merge=ours`: indica que cada desarrollador debe ejecutar `git config merge.ours.driver true` una vez después de clonar.
- **Lista los tipos de archivo** que se tratan como binarios, especialmente si no son obvios (fuentes tipográficas, archivos de diseño, etc.).
- **Incluye el comando de renormalización** (`git add --renormalize .`) en la guía de onboarding para que los desarrolladores existentes actualicen su copia de trabajo.

## Ver también

- [Hooks de Git: `pre-commit`](../14-hooks-pre-commit/) — automatizar validaciones locales antes de cada commit.
- [GitHub Actions](../16-github-actions/) — validaciones en CI/CD que complementan la configuración local.

## Referencias

- [git-scm.com/docs/gitattributes](https://git-scm.com/docs/gitattributes)
- [Pro Git: Personalización de Git — Atributos](https://git-scm.com/book/es/v2/Personalizando-Git-Atributos-de-Git)
