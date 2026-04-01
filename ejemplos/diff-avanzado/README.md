# Diff avanzado (`git diff`)

## Propósito

Ir más allá del `git diff` básico: comparar **ramas**, **commits específicos** y aprovechar opciones avanzadas como `--stat`, `--word-diff` y `--name-status` para obtener exactamente la información que necesitas sin ruido.

## Para quién es esta guía

Desarrolladores que ya manejan commits y ramas, y necesitan **comparaciones precisas** entre puntos del historial — por ejemplo, revisar qué cambió en una feature antes de abrir un *pull request* o entender diferencias entre staging y directorio de trabajo.

## Prerrequisitos

- Saber crear ramas (`git branch`, `git checkout -b`) y commits.
- Entender la diferencia entre **staging area** (índice) y **directorio de trabajo**.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Distinguir la sintaxis de doble punto (`main..feature`) vs triple punto (`main...feature`) y cuándo usar cada una.
2. Usar opciones de resumen y formato: `--stat`, `--shortstat`, `--word-diff` y `--name-status`.
3. Comparar cambios **staged** (listos para commit) vs **unstaged** (solo en el directorio de trabajo) con `git diff` y `git diff --staged`.

## Escenario

Un proyecto con la rama `main` y una rama `feature/mejoras` que divergen después de un punto común. En `main` se añade documentación; en la feature se mejora funcionalidad y se agrega un archivo de utilidades. El script demuestra múltiples técnicas de diff sobre este historial bifurcado.

Archivos en esta carpeta:

| Archivo | Rol |
|---------|-----|
| `demo-setup.sh` | Crea un repo bajo `_demo-diff-avanzado/`, construye el historial y ejecuta las comparaciones. |

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-diff-avanzado/` con el historial descrito y se ejecutan varios comandos `git diff` con distintas opciones.

## Pasos manuales (para repetir o enseñar)

1. Crear un repositorio con al menos dos commits en `main`.
2. Crear una rama `feature/mejoras` desde un commit intermedio y añadir cambios propios.
3. Volver a `main` y añadir un commit adicional (para que las ramas diverjan).
4. Ejecutar las comparaciones:
   - `git diff main..feature/mejoras` — todos los cambios entre las puntas de ambas ramas.
   - `git diff main...feature/mejoras` — solo los cambios de la feature desde el punto de divergencia.
   - `git diff main..feature/mejoras --stat` — resumen estadístico.
   - `git diff main..feature/mejoras --word-diff` — diferencias palabra a palabra.
   - `git diff main..feature/mejoras --name-status` — solo nombres de archivos y tipo de cambio.
5. Modificar un archivo sin hacer `git add` y ejecutar `git diff` (unstaged).
6. Hacer `git add` y ejecutar `git diff --staged` (staged).

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| `A..B` vs `A...B` | `A..B` muestra la diferencia entre las **puntas** de ambas ramas (lo que B tiene y A no). `A...B` muestra los cambios en B **desde el ancestro común** con A, ignorando lo que avanzó A por su cuenta. |
| `--stat` vs `--shortstat` | `--stat` muestra un resumen **por archivo** (inserciones/eliminaciones con barras). `--shortstat` muestra **solo los totales** en una línea. |
| Modos de `--word-diff` | Por defecto usa `plain` (corchetes y llaves). Otras opciones: `color` (solo colores, sin delimitadores) y `porcelain` (formato para scripts). |
| `--name-only` vs `--name-status` | `--name-only` lista solo los nombres de archivos modificados. `--name-status` añade una letra de estado: **M** (modified), **A** (added), **D** (deleted), **R** (renamed). |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Indica siempre las dos referencias** que se comparan (ramas, tags, hashes) y el sentido de la comparación.
- **Documenta qué opción de diff usar** según el contexto: `--stat` para revisiones rápidas, `--word-diff` para cambios de redacción, `--name-status` para entender el alcance de una feature.
- **Incluye ejemplos reales** de la salida esperada para que el lector sepa qué buscar.

### Ejemplo de sección "Verificación"

```text
git diff main..feature/mejoras --stat    # debe mostrar archivos modificados con conteo de líneas
git diff --staged                        # debe mostrar solo los cambios ya añadidos al índice
```

## Referencias

- [git diff](https://git-scm.com/docs/git-diff)
- Pro Git: [Herramientas de Git - Depuración](https://git-scm.com/book/es/v2/Herramientas-de-Git-Depuraci%C3%B3n-con-Git)
