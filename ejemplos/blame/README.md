# Blame (`git blame`)

## Propósito

Identificar **quién modificó cada línea** de un archivo y **en qué commit**, útil para entender la historia de cambios específicos. `git blame` anota cada línea con el hash del commit, el autor y la fecha de la última modificación.

## Para quién es esta guía

Desarrolladores que necesitan **depurar** o **entender el historial** de un archivo concreto: rastrear cuándo se introdujo una línea, quién la escribió y en qué contexto (mensaje del commit).

## Prerrequisitos

- Entender commits y cómo leer la salida de `git log`.
- Saber que cada línea del archivo está asociada al **último commit que la tocó**, no necesariamente al commit que creó el archivo.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Ejecutar `git blame <archivo>` y leer la salida (hash, autor, fecha, número de línea, contenido).
2. Usar `git blame -L <inicio>,<fin> <archivo>` para acotar el análisis a un rango de líneas específico.
3. Interpretar la salida de blame para identificar qué autor modificó cada línea y en qué commit.

## Escenario

Un archivo `config.txt` es creado y modificado a lo largo de **4 commits** por **dos autores** distintos. Usaremos `git blame` para rastrear la autoría de cada línea y ver cómo distintas modificaciones quedan reflejadas en la anotación.

| Commit | Autor | Cambio |
|--------|-------|--------|
| 1 | Demo Blame | Crea `config.txt` con 5 líneas de configuración |
| 2 | Demo Blame | Cambia el puerto de 3000 a 8080 |
| 3 | Colaborador Ejemplo | Activa modo debug y cambia nivel de log |
| 4 | Demo Blame | Añade configuración de timeout |

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-blame/` con el historial descrito y se ejecutan varios comandos `git blame` para mostrar la autoría línea por línea.

## Pasos manuales

1. Navega al repositorio de demostración: `cd _demo-blame/`.
2. Ejecuta `git blame config.txt` — verás cada línea anotada con el commit, autor y fecha.
3. Ejecuta `git blame -L 2,4 config.txt` — solo muestra las líneas 2 a 4.
4. Para investigar un commit concreto que aparezca en blame: `git show <hash>`.
5. Para ignorar cambios de espacios en blanco: `git blame -w config.txt`.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Blame no es para culpar | El nombre puede sonar negativo, pero `git blame` es una herramienta de **comprensión**, no de acusación. Úsala para entender el contexto de un cambio. |
| Flag `-L` para rango de líneas | `git blame -L 10,20 archivo` muestra solo las líneas 10 a 20; útil en archivos grandes para enfocarse en la sección relevante. |
| Flag `-w` para ignorar espacios | `git blame -w` ignora cambios de espacios en blanco, mostrando el commit que realmente cambió la lógica y no solo el formato. |
| Archivos renombrados | Si un archivo fue renombrado, `git log --follow <archivo>` rastrea su historial completo; `git blame` por sí solo muestra la historia desde el nombre actual. |

## Cómo documentar para otros desarrolladores

Cuando documentes el uso de `git blame` para tu equipo, incluye:

1. **Propósito** — para qué se usa blame en el flujo del proyecto (depuración, revisiones de código, auditoría).
2. **Ejemplo concreto** — un comando con archivo real del proyecto y qué buscar en la salida.
3. **Combinación con otras herramientas** — `git show <hash>` para ver el commit completo, `git log -L` para historial de una función.
4. **Limitaciones** — blame muestra el último commit que tocó cada línea, no toda la cadena de cambios; para eso usar `git log -p`.

### Ejemplo de sección "Verificación"

```text
git blame config.txt          # cada línea muestra autor y commit distinto
git blame -L 2,4 config.txt   # solo líneas 2-4 del archivo
git show <hash>                # detalle del commit señalado por blame
```

## Referencias

- [git blame](https://git-scm.com/docs/git-blame)
- Pro Git: [Depuración con Git](https://git-scm.com/book/es/v2/Herramientas-de-Git-Depuraci%C3%B3n-con-Git)
