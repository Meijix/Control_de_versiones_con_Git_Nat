# Bisect (`git bisect`)

## Propósito

Encontrar el **commit exacto** que introdujo un error en el proyecto usando una **búsqueda binaria** automatizada sobre el historial de commits. En lugar de revisar cada commit uno a uno, `git bisect` divide el rango a la mitad en cada paso hasta aislar al culpable.

## Para quién es esta guía

Desarrolladores que necesitan **depurar cuándo se introdujo un bug** y ya manejan `git log`, commits y la navegación básica del historial.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Prerrequisitos

- Saber leer `git log --oneline` y entender qué es un hash de commit.
- Tener claro que un commit es un punto en el tiempo con un estado completo del proyecto.
- Poder identificar si un estado del código es "bueno" (sin el bug) o "malo" (con el bug).

## Objetivos de aprendizaje

1. Iniciar una sesión de bisect con `git bisect start`, marcar commits como `good` o `bad`, y dejar que Git navegue el historial automáticamente.
2. Automatizar la búsqueda con `git bisect run <script>` para que un test determine si cada commit es bueno o malo sin intervención manual.
3. Finalizar la sesión con `git bisect reset` para volver al estado original del repositorio.

## Escenario

Un proyecto tiene **8 commits** que van añadiendo funcionalidad línea por línea a `app.txt`. En el **commit 5** se introduce accidentalmente una línea con un error crítico (`BUG: error critico`). Usando `git bisect`, localizaremos ese commit exacto sin tener que revisar los 8 commits manualmente.

Archivos en esta carpeta:

| Archivo | Rol |
|---------|-----|
| `demo-setup.sh` | Crea un repo bajo `_demo-bisect/`, genera los 8 commits y ejecuta `git bisect run` para encontrar el commit problemático. |

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-bisect/` con un historial de 8 commits y se ejecuta una búsqueda binaria automática para localizar el commit que introdujo el error.

## Pasos manuales (para repetir o enseñar)

1. `git bisect start` — inicia la sesión de bisect.
2. `git bisect bad HEAD` — marca el commit actual (último) como malo (tiene el bug).
3. `git bisect good <hash_del_primer_commit>` — marca el primer commit como bueno (no tenía el bug).
4. Git hace checkout a un commit intermedio. Inspecciona si el bug existe:
   - Si **tiene** el bug: `git bisect bad`
   - Si **no tiene** el bug: `git bisect good`
5. Repite el paso 4 hasta que Git identifique el commit culpable.
6. `git bisect reset` — finaliza la sesión y vuelve a la rama original.

### Alternativa automática

En lugar de los pasos 4-5, puedes usar:

```bash
git bisect run bash test.sh
```

Donde `test.sh` devuelve código **0** si el commit es bueno y **distinto de 0** si es malo.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Bisect vs log/blame | `git log` y `git blame` muestran **quién** y **qué** cambió; `git bisect` encuentra **cuándo** se rompió algo, incluso si el bug no es evidente en el diff. |
| Bisect con merges | `git bisect` funciona con historiales no lineales (merges), pero puede ser más difícil de seguir. En esos casos `git bisect run` con un test automático es especialmente útil. |
| Importancia de `bisect reset` | Si no ejecutas `git bisect reset` al terminar, Git queda en estado "detached HEAD" dentro de la sesión de bisect. **Siempre** finaliza con reset. |
| Códigos de salida en `bisect run` | El script de test debe devolver **0** = commit bueno, **1-124** y **126-127** = commit malo, **125** = skip (no se puede probar este commit). No uses código 128+ (Git lo interpreta como error fatal). |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Describe el síntoma del bug** con claridad: qué se observa, qué debería ocurrir.
- **Incluye el comando de test** que usaste con `bisect run`, para que otros puedan reproducir la búsqueda.
- **Documenta el commit encontrado**: hash, mensaje, autor y fecha, para que el equipo pueda analizar el cambio.
- **Sugiere el siguiente paso**: `git revert <hash>` si corresponde, o una corrección manual.

### Ejemplo de sección "Verificación"

```text
git log -1 --oneline    # debe mostrar el commit que introdujo el bug
grep "BUG:" app.txt     # confirma que el error está presente en ese commit
git bisect reset         # vuelve al estado original
```

## Ver también

- [Blame](../blame/README.md) — rastrear quién cambió cada línea.
- [Log avanzado](../log-avanzado/README.md) — filtrar y buscar en el historial.

## Referencias

- [git bisect](https://git-scm.com/docs/git-bisect)
- Pro Git: [Depuración con Git](https://git-scm.com/book/es/v2/Herramientas-de-Git-Depuraci%C3%B3n-con-Git)
