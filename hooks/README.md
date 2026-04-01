# Hooks de Git (plantillas)

Esta carpeta contiene **ejemplos listos para copiar** a `.git/hooks/` en tus proyectos. Cubren tres necesidades habituales:

| Objetivo | Archivo | Hook de Git |
|----------|---------|-------------|
| Formato / espacios en blanco | [`pre-commit.format.sample`](pre-commit.format.sample) | `pre-commit` |
| Evitar commits directos a `main` / `master` | [`pre-commit.protect-main.sample`](pre-commit.protect-main.sample) | `pre-commit` |
| Mensajes [Conventional Commits](https://www.conventionalcommits.org/) | [`commit-msg.conventional-commits.sample`](commit-msg.conventional-commits.sample) | **`commit-msg`** (no es `pre-commit`) |
| Combinar formato + protección de rama principal | [`pre-commit.combined.sample`](pre-commit.combined.sample) | `pre-commit` |

## Por qué `commit-msg` y no `pre-commit` para el mensaje

- **`pre-commit`** se ejecuta **antes** de que exista el mensaje definitivo; sirve para revisar **archivos en staging**.
- **`commit-msg`** recibe la **ruta del fichero** con el mensaje y es el lugar adecuado para validar formato del título (`feat:`, `fix(scope):`, etc.).

Confundirlos es un error frecuente: las reglas de Conventional Commits van en **`commit-msg`**.

## Instalación rápida

Desde la raíz del repositorio donde quieras activar los hooks:

```bash
bash hooks/install.sh
```

Por defecto (`all`) instala:

1. `pre-commit.combined.sample` → `.git/hooks/pre-commit` (formato con `git diff --cached --check` + bloqueo de `main`/`master`).
2. `commit-msg.conventional-commits.sample` → `.git/hooks/commit-msg`.

Otras opciones:

```bash
bash hooks/install.sh format-only   # solo --check de espacios en blanco
bash hooks/install.sh protect-only    # solo bloqueo de main/master
```

Copia manual: renombra el `.sample` a `pre-commit` o `commit-msg`, colócalo en `.git/hooks/` y ejecuta `chmod +x`.

## Detalle de cada ejemplo

### Formato (`pre-commit.format.sample`)

- Usa `git diff --cached --check` para detectar **errores de espacio en blanco** en lo que vas a commitear (sin herramientas externas).
- Incluye comentarios con **ejemplos opcionales** para Prettier, Black o `gofmt` si tu equipo ya los usa.

### Protección de `main` (`pre-commit.protect-main.sample`)

- Si la rama actual es `main` o `master`, el hook **falla** y cancela el commit.
- **Excepción:** `ALLOW_MAIN_COMMIT=1 git commit ...` (útil solo si tu política lo permite; documenta en tu proyecto cuándo usarla).

### Conventional Commits (`commit-msg.conventional-commits.sample`)

- Valida la **primera línea** con tipos habituales: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`.
- Acepta **scope** opcional y **`!`** para cambios que rompen compatibilidad (`feat!: ...`, `fix(api)!: ...`).
- **Omite** la validación en líneas que empiezan por `Merge ` o `Revert ` (commits generados por Git).

## Combinar varios `pre-commit`

Git solo ejecuta **un** script `pre-commit`. [`pre-commit.combined.sample`](pre-commit.combined.sample) llama a `pre-commit.format.sample` y `pre-commit.protect-main.sample` en la carpeta **`hooks/` en la raíz del repo** (no dentro de `.git`). Tras `git clone`, mantén esa carpeta en el proyecto; el hook instalado en `.git/hooks/pre-commit` depende de ella.

Si prefieres un único fichero **autocontenido** en `.git/hooks/` (por ejemplo para distribuir sin la carpeta `hooks/`), copia y pega el contenido de los `.sample` en un solo script o usa `core.hooksPath` apuntando a una carpeta versionada.

## Compartir con el equipo

`.git/hooks/` **no se versiona** por defecto. Opciones:

- Versionar esta carpeta `hooks/` en el repo y documentar `bash hooks/install.sh` en el README del proyecto.
- O `git config core.hooksPath hooks` apuntando a una carpeta **dentro** del repositorio (por ejemplo `hooks/activos/`), de modo que todos usen los mismos scripts tras un `git pull`.

## Referencias

- [Documentación de githooks](https://git-scm.com/docs/githooks)
- [Conventional Commits](https://www.conventionalcommits.org/)
