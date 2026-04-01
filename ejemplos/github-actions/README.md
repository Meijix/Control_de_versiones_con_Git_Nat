# GitHub Actions (CI básico)

## Propósito

Introducir **CI/CD con GitHub Actions** para automatizar la ejecución de pruebas cada vez que se hace `push` a `main` o se abre un **Pull Request**. GitHub Actions permite definir flujos de trabajo (_workflows_) directamente en el repositorio, sin necesidad de servidores externos.

## Para quién es esta guía

Personas que ya trabajan con Git y GitHub y quieren **automatizar tareas repetitivas** como ejecutar pruebas, linters o builds cada vez que el código cambia en el repositorio remoto.

## Prerrequisitos

- Un repositorio alojado en **GitHub** (público o privado).
- Conocimiento básico de **YAML** (indentación por espacios, listas con `-`, pares `clave: valor`).
- Saber hacer `push` y abrir Pull Requests en GitHub.

## Objetivos de aprendizaje

1. Entender los **disparadores** (`on: push`, `on: pull_request`) que inician un workflow.
2. Comprender la estructura de **jobs** y **steps** dentro de un workflow.
3. Utilizar **actions del marketplace** (`actions/checkout`, `actions/setup-node`, etc.) para configurar el entorno de ejecución.

## Escenario

Se proporciona un workflow básico (`ci-basico.yml`) que se ejecuta en cada `push` a `main` y en cada Pull Request dirigido a `main`. El workflow:

1. Hace _checkout_ del código del repositorio.
2. Ejecuta una verificación básica (un `echo` de confirmación).
3. Incluye secciones comentadas para **Node.js** y **Python** que puedes descomentar según tu stack.

## Cómo usar el ejemplo

A diferencia de otros ejemplos de este repositorio, los workflows de GitHub Actions **no se ejecutan localmente**. Para usarlo:

1. Copia el archivo `ci-basico.yml` a la carpeta `.github/workflows/` de tu repositorio:

   ```bash
   mkdir -p .github/workflows
   cp ejemplos/github-actions/ci-basico.yml .github/workflows/ci-basico.yml
   ```

2. Haz commit y push:

   ```bash
   git add .github/workflows/ci-basico.yml
   git commit -m "Agregar workflow de CI básico"
   git push origin main
   ```

3. Ve a la pestaña **Actions** de tu repositorio en GitHub para ver la ejecución.

## Anatomía del workflow

Un archivo de workflow tiene cuatro bloques principales:

| Bloque | Descripción |
|--------|-------------|
| `name` | Nombre descriptivo que aparece en la pestaña Actions de GitHub. |
| `on` | **Disparadores**: eventos que inician el workflow (`push`, `pull_request`, `schedule`, etc.). |
| `jobs` | Conjunto de trabajos que se ejecutan (por defecto en paralelo). Cada job tiene un `runs-on` que define el sistema operativo. |
| `steps` | Pasos secuenciales dentro de un job. Pueden usar `uses:` para invocar una action del marketplace o `run:` para ejecutar comandos de shell. |

### Ejemplo mínimo comentado

```yaml
name: CI Básico          # Nombre visible en GitHub
on:
  push:
    branches: [main]     # Se dispara al hacer push a main
jobs:
  pruebas:
    runs-on: ubuntu-latest   # Máquina virtual donde corren los pasos
    steps:
      - uses: actions/checkout@v4   # Descarga el código del repo
      - run: echo "¡CI funcionando!"  # Comando de verificación
```

## Pasos manuales

Si prefieres crear el workflow desde cero en tu repositorio:

1. Crea la carpeta de workflows:
   ```bash
   mkdir -p .github/workflows
   ```

2. Crea un archivo YAML (por ejemplo `ci.yml`) con la estructura `name`, `on`, `jobs`, `steps`.

3. En la sección `steps`, agrega al menos `actions/checkout@v4` para descargar el código.

4. Añade los pasos de instalación de dependencias y ejecución de pruebas según tu stack.

5. Haz `commit`, `push` y revisa la pestaña **Actions** en GitHub.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Actions vs hooks locales | Los **hooks** (pre-commit, pre-push) se ejecutan en tu máquina local; **GitHub Actions** se ejecuta en servidores de GitHub tras el push. Ambos son complementarios. |
| Precio | Los repositorios **públicos** tienen minutos ilimitados. Los privados tienen un límite mensual gratuito (2000 min/mes en plan Free); consulta la [documentación de facturación](https://docs.github.com/es/billing/managing-billing-for-github-actions). |
| Secrets | Las variables sensibles (tokens, claves API) se almacenan en **Settings > Secrets** del repositorio y se acceden con `${{ secrets.NOMBRE }}`. Nunca las escribas directamente en el YAML. |
| `ubuntu-latest` | GitHub actualiza periódicamente la imagen; si necesitas reproducibilidad, fija la versión (e.g., `ubuntu-22.04`). |

## Referencias

- [Documentación oficial de GitHub Actions](https://docs.github.com/es/actions)
- [Sintaxis del workflow](https://docs.github.com/es/actions/using-workflows/workflow-syntax-for-github-actions)
- [Marketplace de Actions](https://github.com/marketplace?type=actions)
- [actions/checkout](https://github.com/actions/checkout)
- [actions/setup-node](https://github.com/actions/setup-node)
- [actions/setup-python](https://github.com/actions/setup-python)
