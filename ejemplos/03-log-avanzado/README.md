# Log avanzado (`git log`)

## Proposito

Explorar las **opciones avanzadas** de `git log` para filtrar, buscar y formatear el historial de commits. Un historial bien consultado ahorra tiempo al depurar, revisar PRs o entender decisiones pasadas.

## Para quien es esta guia

Desarrolladores que ya usan `git log` basico y necesitan **buscar commits concretos**, filtrar por autor, fecha o contenido, y personalizar la salida para revisiones rapidas o reportes.

## Prerrequisitos

- Saber leer la salida basica de `git log` (hash, autor, fecha, mensaje).
- Entender la diferencia entre ramas y la nocion de historial lineal vs ramificado.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Personalizar la salida con `--pretty=format` para mostrar exactamente los campos que necesitas (hash corto, autor, fecha relativa, mensaje).
2. Filtrar commits con `--author`, `--grep`, `--since`/`--until` y `-S` (pickaxe) para encontrar cambios especificos sin revisar todo el historial.
3. Visualizar la topologia de ramas con `--graph --all --oneline` para entender bifurcaciones y merges de un vistazo.

## Escenario

Un repositorio con **12+ commits** de **dos autores** distintos (`Demo Log` y `Colaborador`), con mensajes convencionales (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`). Incluye una rama secundaria para demostrar `--graph --all`. El script ejecuta varias consultas `git log` con distintas opciones y muestra los resultados.

```
main:       A ── B ── C ── D ── E ── F ── G ── H ── I ── J
                                                          \
feature/mejoras:                                           K ── L
```

## Como ejecutar la demostracion

```bash
bash demo-setup.sh
```

Se crea `_demo-log-avanzado/` con el historial descrito y se ejecutan varias consultas de `git log` con opciones avanzadas.

## Pasos manuales (para repetir o ensenar)

1. **Formato personalizado**: `git log --pretty=format:"%h %an %ar %s"` -- muestra hash corto, autor, fecha relativa y mensaje en una linea.
2. **Filtrar por autor**: `git log --author="Nombre" --oneline` -- solo commits de ese autor.
3. **Buscar en mensajes**: `git log --grep="fix" --oneline` -- commits cuyo mensaje contiene "fix".
4. **Filtrar por fecha**: `git log --since="2 days ago" --oneline` -- commits recientes.
5. **Buscar en cambios (pickaxe)**: `git log -S "texto" --oneline` -- commits que anadieron o eliminaron "texto" en el codigo.
6. **Grafo visual**: `git log --oneline --graph --all` -- muestra todas las ramas con lineas ASCII.
7. **Combinar filtros**: `git log --author="Colaborador" --grep="feat" --oneline` -- autor + patron de mensaje.

## Notas que suelen confundir

| Concepto | Aclaracion |
|----------|------------|
| `--grep` vs `-S` | `--grep` busca en el **mensaje** del commit; `-S` (pickaxe) busca en el **contenido** de los cambios (diff). Son complementarios. |
| `--follow` para renombrados | Si un archivo fue renombrado, `git log archivo.txt` no muestra commits previos al rename. Usa `git log --follow archivo.txt` para rastrear a traves de renombramientos. |
| `--oneline` vs `--pretty` | `--oneline` es un atajo de `--pretty=format:"%h %s"`. Si necesitas mas campos, usa `--pretty=format:` directamente. |
| `--all` | Sin `--all`, `git log` solo muestra la historia alcanzable desde HEAD. Con `--all` incluye **todas** las ramas, tags y refs. Importante al usar `--graph`. |

## Como documentar para otros desarrolladores

Ademas de la plantilla general (proposito, requisitos, pasos, verificacion, fallos):

- **Documenta los alias utiles** de tu equipo: por ejemplo, `git config --global alias.lg "log --oneline --graph --all --decorate"`.
- **Incluye ejemplos de busqueda** que resuelvan preguntas reales: "Quien cambio esta funcion?" (`git log -S "funcion" --oneline`), "Que se hizo la semana pasada?" (`git log --since="1 week ago"`).
- **Explica los formatos de fecha** aceptados: `--since="2024-01-01"`, `--since="3 days ago"`, `--until="yesterday"`.

### Ejemplo de seccion "Consultas frecuentes"

```text
# Commits de la ultima semana por autor
git log --since="1 week ago" --author="nombre" --oneline

# Commits que tocaron un archivo especifico
git log --follow -- ruta/archivo.txt

# Buscar quien introdujo una cadena
git log -S "TODO" --oneline
```

## Ver tambien

- [Blame (`git blame`)](../05-blame/) -- identificar linea por linea quien hizo cada cambio.
- [Bisect (`git bisect`)](../11-bisect/) -- busqueda binaria para encontrar el commit que introdujo un bug.
- [Diff avanzado (`git diff`)](../02-diff-avanzado/) -- comparar cambios entre commits, ramas o el staging.

## Referencias

- [git log - Documentacion oficial](https://git-scm.com/docs/git-log)
- Pro Git: [Ver el historial de commits](https://git-scm.com/book/es/v2/Fundamentos-de-Git-Ver-el-Historial-de-Confirmaciones)
